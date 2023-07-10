# Coding Jam 2023
## Proof of concept for an accessible navigation system
July 8 - 9 2023

### Model specifications

#### Definition of a grid
We consider a simplified model for a city, given by a graph $G = (V, E)$, where V corresponds to prespecified landmarks and edges are drawn between connected vertices. For instance, one can think of modeling Manhattan, where $V$ is the set of all intersection points and edges represent avenues and streets. 

#### Definition of a path in a grid
A path of length $n$ in $G$ between $a \in V$ and $b \in V$ is defined to be an $(n + 1)$-uple of vertices $(v_0, v_1, \ldots, v_n)$ where $v_0=a$, $v_n=b$ and for all $1 \leqslant i \leqslant n$, $(v_{i-1}, v_{i}) \in E$. 

#### Characteristics of vertices, edges, and users
To each vertex $v \in V$ is associated an elevation $\varepsilon_v$ (in meters), a business index $b_v$, and a safety index $s_v$. \
To each edge $e \in E$ is associated a length $l_e$ (in meters).\
To adapt our algorithm to varying user profiles, each user $U$ has three customizable coefficients $\alpha_\varepsilon(U), \alpha_b(U), \alpha_s(U)$ respectively representing how fine they feel about elevation gains, crowdy areas and safety concerns. They are chosen non-negative and such that $\alpha_\varepsilon(U) + \alpha_b(U) + \alpha_s(U)=1$.

#### Edge weights customized for different user profiles
For a given user $U$, the weight $w_e(U)$ of an edge $e=(v_1, v_2) \in E$ is determined by the length of $e$, scaled by an adjusting multiplier including some properties of $a$ and $b$: $$w_e(U)=l_e(1 + m_e(U))$$ where $m_e(U) \in [0,1]$ represents how much $e$ suits the user's preferences. \
We propose the following computation for $m_e(U)$: $$m_e(U)=\alpha_\varepsilon(U) \varepsilon_e + \alpha_b(U) b_e + \alpha_s(U)s_e$$ where $\varepsilon_e, b_e, s_e \in [0,1]$ respectively represent elevation, crowdedness, or safety concerns.\
In what follows, we selected the following expressions for those three indices: $\varepsilon_e = \frac{|\varepsilon_{v_1} - \varepsilon_{v_2}|}{l_e}$, $b_e = \frac{1}{2}(b_{v_1} + b_{v_2})$, and $s_e = \frac{1}{2}(s_{v_1} + s_{v_2})$.

#### Cost of a path for a specific user
For user $U$, the cost of a path $p=(v_0, v_1, \ldots, v_n)$ from $v_0=a \in V$ to $v_n=b \in V$ is defined as $$ c_p(U) = \sum\limits_{i=0}^{n-1}{w_{(v_i, v_{i+1})}(U)} $$

#### Finding the shortest path in the graph from source to destination
For a user $U$, a source and a destination $a,b\in V$, our goal is to find the path $p^*$ from $a$ to $b$ in $G$ with minimal cost, ie solve the following optimization problem:
$$ p^* = \underset{p \text{ path from } a \text{ to }b}{\arg\min}{c_p(U)}$$
Since weights are only supported by edges, Dijkstra's algorithm provides an efficient way to compute this shortest path.