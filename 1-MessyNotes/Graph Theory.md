## Graphs vs Trees: Core Differences

A graph is a non-linear data structure consisting of vertices (nodes) and edges that connect these vertices. A tree is a special type of graph with specific constraints.

Key differences between graphs and trees:
- Trees cannot have cycles; graphs can
- Trees must be connected; graphs can be disconnected
- In trees, there is exactly one path between any two nodes
- A tree with n nodes has exactly n-1 edges

![[Pasted image 20241225153615.png]]

## Graph Representation

Graphs can be represented in two primary ways: adjacency lists and adjacency matrices.

### Adjacency List
- Implementation: Array/vector of lists, where each list contains neighbors of a vertex
- Space Complexity: O(V + E)
- Best for: Sparse graphs (where E << V²)

### Adjacency Matrix
- Implementation: V×V boolean matrix where matrix[i][j] indicates edge between vertices i and j
- Space Complexity: O(V²)
- Best for: Dense graphs

### Time Complexity Analysis
The O(V + E) complexity comes from:
- V: Processing all vertices
- E: Processing all edges through adjacency lists
This is optimal as any complete graph traversal must examine each vertex and edge at least once.

## Graph Traversal Algorithms

![[Pasted image 20241225182452.png]]

### Breadth-First Search (BFS)
```cpp
void bfs(vector<vector<int>>& graph, int start) {
    vector<bool> visited(graph.size(), false);
    queue<int> q;
    
    visited[start] = true;
    q.push(start);
    
    while (!q.empty()) {
        int current = q.front();
        q.pop();
        cout << current << " ";
        
        for (int neighbor : graph[current]) {
            if (!visited[neighbor]) {
                visited[neighbor] = true;
                q.push(neighbor);
            }
        }
    }
}
```

### Depth-First Search (DFS)
```cpp
void dfs(vector<vector<int>>& graph, int vertex, vector<bool>& visited) {
    visited[vertex] = true;
    
    for (int neighbor : graph[vertex]) {
        if (!visited[neighbor]) {
            dfs(graph, neighbor, visited);
        }
    }
}
```

## Connected Components

A connected component is a subgraph where any two vertices are connected by a path, and no vertex is connected to any vertex outside the component.

![[Pasted image 20241225183013.png]]

## Topological Sort

Topological sorting produces a linear ordering of vertices in a directed acyclic graph (DAG) such that for every directed edge u→v, vertex u comes before v in the ordering.

![[Pasted image 20241225183807.png]]

## Cycle Detection and Edge Classification

Edge types in graph traversal:
1. Tree Edge: Direct parent-child relationship in DFS tree
2. Back Edge: Edge pointing to an ancestor (indicates cycle)
3. Forward Edge: Edge pointing to a descendant
4. Cross Edge: Edge between unrelated vertices

![[Pasted image 20241225200842.png]]
