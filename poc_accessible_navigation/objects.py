import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import networkx as nx

# Some global constants
SCALE_SAFETY = 5 # safety index for a point will take integer values between 0 and 5
SCALE_BUSINESS = 5 # business index for a point will take integer values between 0 and 5

class Grid:
    """
    A grid is defined by the graph G representing the city and relation 
    between intersections, and information on lengths, elevation, 
    crowdedness and safety
    """
    def __init__(self, parameters_grid, seed=0):
        """
        Initializes the graph
        """
        self.nb_vertices = len(parameters_grid['idx_to_name'])
        self.idx_to_name = parameters_grid['idx_to_name']
        self.name_to_idx = parameters_grid['name_to_idx']
        
        # Elevation, how busy is the way, how safe it is
        self.elevations = parameters_grid['elevations']
        self.business = parameters_grid['business']
        self.safety = parameters_grid['safety']
        
        # Edges
        self.length_edges = parameters_grid['length_edges']
        # Possibly changing the order of vertices in an edge (first one has to be smaller than the second one)
        self.process_length_edges()
        self.set_edges = set(self.length_edges.keys())
        
        # Computing the networkx graph object for visualization purposes
        self.compute_networkx(seed=seed)

    def compute_networkx(self, seed=0):
        """
        Computes the NetworkX object representing the graph, and updates the corresponding Grid field
        """
        self.networkx_graph = nx.Graph()
        
        # Adding nodes
        self.networkx_graph.add_nodes_from(range(self.nb_vertices))
        
        # Adding edges
        self.networkx_graph.add_edges_from(self.set_edges)
        
        # Relabeling nodes
        nx.relabel_nodes(self.networkx_graph, self.idx_to_name, copy=False)
        
        # Fixing the layout
        self.graph_layout = nx.spring_layout(self.networkx_graph, seed=seed)
        
    def draw(self):
        """
        Once the Networkx representation of the graph has been computed, drawing the graph
        """
        nx.draw_networkx(self.networkx_graph, pos=self.graph_layout)
        plt.show()
        
    def draw_path(self, path):
        """
        Draws a path within a graph
        """
        edge_color = {edge: 'black' for edge in self.networkx_graph.edges}
        for edge in path.edges:
            name1, name2 = self.idx_to_name[edge[0]], self.idx_to_name[edge[1]]
            edge_color[(name1, name2)] = 'red'
        node_color = ['#1f78b4'] * self.nb_vertices
        node_color[path.vertices[0]] = 'green'
        node_color[path.vertices[-1]] = 'yellow'
        nx.draw_networkx(self.networkx_graph, pos=self.graph_layout, edge_color=list(edge_color.values()), node_color=node_color)
    
    def process_length_edges(self):
        """
        Going through all edges and making sure that the first vertex has a smaller index than the second vertex
        """
        self.length_edges = {(min(edge[0], edge[1]), max(edge[0], edge[1])): length for edge, length in self.length_edges.items()}
        
    def weight_function(self, edge, user):
        """
        Returns the cost of edge from a to b
        """
        i, j = edge
        length = self.length_edges[edge]
        elevation1, elevation2 = self.elevations[i], self.elevations[j]
        business1, business2 = self.business[i], self.business[j]
        safety1, safety2 = self.safety[i], self.safety[j]
        
        # Slope of the street
        slope = abs(elevation1 - elevation2) / length
        
        # How busy is the street?
        business = 0.5 * (business1 + business2) / SCALE_BUSINESS
        
        # How safe is the street?
        safety = 1 - 0.5 * (safety1 + safety2) / SCALE_SAFETY
        
        # Retrieving user information
        coef_elevation, coef_business, coef_safety = user.coef_elevation, user.coef_business, user.coef_safety
        
        # Multiplier between 0 and 1
        multiplier = coef_elevation * slope + coef_business * business + coef_safety * safety
        
        # Weighted length
        weighted_length = length * (1 + multiplier)
        
        return weighted_length

class Path:
    """
    A path in a grid G is simply defined by a sequence of vertices, with no cycle.
    """
    def __init__(self, grid, path_vertices):
        self.vertices = path_vertices
        self.len_path = len(self.vertices) - 1
        self.edges = {(min(self.vertices[i], self.vertices[i + 1]), max(self.vertices[i], self.vertices[i + 1])) for i in range(self.len_path)}
        self.grid = grid
        assert self.is_path_correct()
        
    def is_path_correct(self):
        """
        Checking that the path only goes through existing edges
        """
        path_correct = self.edges.issubset(self.grid.set_edges)
        return path_correct

class User:
    """
    Allowing each user to have different priorities regarding elevation, avoiding busy areas and safety concerns
    """
    def __init__(self, coef_elevation, coef_business, coef_safety):
        sum_coefs = coef_elevation + coef_business + coef_safety
        self.coef_elevation = coef_elevation / sum_coefs
        self.coef_business = coef_business / sum_coefs
        self.coef_safety = coef_safety / sum_coefs

class Session:
    """
    A session is defined by a pair of user and grid
    This allows customization of preferences for different user profiles
    """
    def __init__(self, grid, user):
        self.grid = grid
        self.user = user
        self.grid_weighted_length_edges = self.compute_grid_weighted_length_edges()
        self.custom_weight_fun = lambda i, j, edge_dict: self.grid_weighted_length_edges[min(self.grid.name_to_idx[i], self.grid.name_to_idx[j]),
                                                                                        max(self.grid.name_to_idx[i], self.grid.name_to_idx[j])]
        
    def compute_grid_weighted_length_edges(self):
        """
        Computes the weighted lengths of all edges in the city graph for this specific pair of user and grid
        """
        return {edge: self.grid.weight_function(edge, self.user) for edge in self.grid.length_edges}
    
    def shortest_path(self, departure, arrival):
        """
        Computes the shortest path from departure to arrival using the customizable user specificities
        """
        path_vertices = nx.shortest_path(self.grid.networkx_graph, source=departure, target=arrival, weight=self.custom_weight_fun)
        path_vertices_idx = [self.grid.name_to_idx[v] for v in path_vertices]
        path = Path(self.grid, path_vertices_idx)
        return path