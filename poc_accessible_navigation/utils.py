import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import networkx as nx

RADIUS_EARTH = 6371000

def pre_process_point(str_point):
    """
    Takes a point in format 'POINT(a b)' and returns (a, b)
    """
    a, b = str_point[7:-1].split()
    return (float(a), float(b))

def compute_haversine_distance(point1, point2):
    """
    Computes the spherical distance on Earth in meters between two points point1 and point2 given by their longitude and latitude
    """
    # Retrieving the coordinates of both points
    longitude1, latitude1 = point1
    longitude2, latitude2 = point2
    
    # Converting to radians
    longitude1 = longitude1 * np.pi / 180
    latitude1 = latitude1 * np.pi / 180
    longitude2 = longitude2 * np.pi / 180
    latitude2 = latitude2 * np.pi / 180
    
    # Computing the Haversine distance
    haversine_distance = 2 * RADIUS_EARTH * np.arcsin(np.sqrt(np.sin(0.5 * (latitude2 - latitude1)) ** 2 + np.sin(0.5 * (longitude2 - longitude1)) ** 2 * np.cos(latitude1) * np.cos(latitude2)))
    
    return haversine_distance

def insert_in_order(cnn, ordered_cnns, coordinates):
    """
    Takes as input an ordered list of cnns
    (assumed to lie on the same street)
    and another cnn also lying on this street,
    and returns the updated ordered cnn list
    """
    
    n = len(ordered_cnns)
    
    # Computing the distances between ordered points
    distances_between_ordered_points = [compute_haversine_distance(coordinates[ordered_cnns[i]], coordinates[ordered_cnns[i + 1]]) for i in range(n - 1)]
    
    # Computing distances between the new point and each of the other points
    distances_new_point_to_previous_points = [compute_haversine_distance(coordinates[ordered_cnns[i]], coordinates[cnn]) for i in range(n)]
    
    for i in range(n - 1):
        if (distances_new_point_to_previous_points[i] + distances_new_point_to_previous_points[i + 1] < distances_between_ordered_points[i]):
            # It is shorter to go from i to the new point and then to i + 1, so the new point
            # lies between i and i + 1
            return ordered_cnns[:i + 1] + [cnn] + ordered_cnns[i + 1:]
        
    # Otherwise, the new point has to be added at the beginning or at the end
    if (distances_new_point_to_previous_points[0] < distances_new_point_to_previous_points[1]):
        # The new point is added at the beginning
        return [cnn] + ordered_cnns
    
    # Otherwise, the new point is added at the end
    return ordered_cnns + [cnn]

def order_vertices(list_cnns, coordinates):
    """
    Takes as input a list of vertices assumed to lie on a given street,
    and orders them using our Haversine distance function
    """
    
    # If less than 2 points, then no need to order anything
    if len(list_cnns) <= 2:
        return list_cnns
    
    # Recursive part
    # Ordering the first n - 1 vertices
    ordered_first_cnns = order_vertices(list_cnns[:-1], coordinates)
    
    # Inserting the last one in the ordered list
    ordered_cnns = insert_in_order(list_cnns[-1], ordered_first_cnns, coordinates)
    
    return ordered_cnns

def create_list_edges(raw_data, coordinates):
    """
    Builds the list of edges in the city graph
    Vertices will be identified by their cnn ID
    """
    processed_data = raw_data.copy()
    
    # Dealing with Nans in st_type
    processed_data = processed_data.fillna('')
    
    # Concatenating the street name and street type
    processed_data['full_st'] = processed_data['st_name'] + ' ' + processed_data['st_type']
    processed_data = processed_data[['cnn', 'full_st']]
    
    # Grouping all intersections belonging to the same street
    processed_data = processed_data.groupby('full_st')['cnn'].apply(lambda list_cnn: ','.join([str(cnn) for cnn in list_cnn]))
    
    set_edges = set()
    for str_list_cnns in processed_data.values:
        # Splitting and converting to integers
        list_cnns = str_list_cnns.split(',')
        list_cnns = list({int(cnn) for cnn in list_cnns})
        ordered_cnns = order_vertices(list_cnns, coordinates)
        
        # Adding edges
        n = len(list_cnns)
        if (n >= 2):
            for i in range(n - 1):
                set_edges.add((list_cnns[i], list_cnns[i + 1]))
    
    # Converting to list of edges
    list_edges = list(set_edges)
    
    return list_edges

def create_length_edges(list_edges, coordinates, name_to_idx):
    """
    Creates the dictionary with edges (in indices not cnn) as keys and distance in meters as values
    """
    
    length_edges = {}
    for edge in list_edges:
        i, j = name_to_idx[edge[0]], name_to_idx[edge[1]]
        i, j = min(i, j), max(i, j)
        distance = compute_haversine_distance(coordinates[edge[0]], coordinates[edge[1]])
        length_edges[(i, j)] = distance
        
    return length_edges