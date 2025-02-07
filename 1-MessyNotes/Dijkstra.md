[[Graph Theory]]
[[CP]]

---

### **1. Master the Basics**  
**Focus**: Standard Dijkstra, path reconstruction, edge cases, and simple state tracking.  
- **Network Delay Time (LC 743)**  
  Classic Dijkstra implementation. Find the shortest time for all nodes to receive a signal.  
- **Path with Maximum Probability (LC 1514)**  
  Convert max probability to a shortest path problem using `-log(prob)`.  
- **Dijkstra? (CF 20C, 1900\*)**  
  Basic Dijkstra with path reconstruction. (*Slightly above 1800 but critical for path tracking*.)  
- **Shortest Routes I (CSES)**  
  Pure 1-to-all shortest paths. Practice optimizations (heap, adjacency lists).

---

### **2. Intermediate**  
**Focus**: Track additional states (steps, obstacles, time windows) and multi-parameter optimization.  
- **Cheapest Flights Within K Stops (LC 787)**  
  Track remaining stops (state = `[node, stops_left]`).  
- **Shortest Path with Obstacle Elimination (LC 1293)**  
  Track remaining obstacle removals (state = `[x, y, k]`).  
- **Bicycles (CF 1915G, 1700)**  
  Track the current bike’s speed. Each city offers bikes with different speeds.  
- **Planets (CF 229B, 1700)**  
  Edges are blocked at certain times. Track arrival time + wait periods.  
- **Investigation (CSES)**  
  Track multiple parameters: shortest path count, min/max edges in a path.  

---

### **3. Goal Level (1700–1800)**  
**Focus**: Advanced graph modeling, bidirectional Dijkstra, K-th shortest paths, and dynamic edge logic.  
- **Rudolf and Subway (CF 1941G, 1800)**  
  Model subway lines by grouping edges by color. Reduces graph complexity.  
- **Flight Discount (CSES)**  
  Run Dijkstra twice (forward + backward) to find the optimal edge to discount.  
- **Flight Routes (CSES)**  
  Track the top *K* shortest paths using a priority queue that stores multiple distances per node.  
- **Swim in Rising Water (LC 778)**  
  Priority depends on the max elevation encountered (greedy + Dijkstra).  
- **Minimum Path (CF 1473E, 2200\*)**  
  *Bonus stretch problem*: Modify edge weights (subtract max, add min). Advanced state tracking.  

---

### **Key Concepts Covered**  
1. **Standard SP**: Basic Dijkstra, path reconstruction.  
2. **State Tracking**: Stops, obstacles, time windows, bike speeds.  
3. **Graph Modeling**: Subway color grouping, elevation grids.  
4. **Multi-Parameter**: Track path counts, min/max edges, K-shortest paths.  
5. **Bidirectional Search**: Forward/backward Dijkstra for discounts.  

---

### **Practice Strategy**  
1. **Basics First**: Solve 5–10 standard Dijkstra problems until you can code them in <10 mins.
2. **Intermediate Patterns**: Focus on problems where the state includes *more than just the node* (e.g., `[node, k]`).  
3. **Advanced Modeling**: For 1700+ problems, draw the graph transformations (e.g., grouping edges by color in CF 1941G).  
4. **Time Constraints**: For CF problems, aim to solve 1700-rated in ≤30 mins.  

These problems will solidify your ability to recognize Dijkstra variations and handle 1700–1800 contests. For stretch goals, tackle CF 1473E (2200) to see how far state tracking can go!