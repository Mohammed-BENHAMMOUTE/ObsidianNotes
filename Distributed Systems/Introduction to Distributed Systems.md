[[Distributed Systems]]

### **Detailed Summary for Exam Preparation: Introduction to Distributed Systems**  

---

#### **1. Definition of Distributed Systems**  
- **Core Definition**:  
  - A collection of *independent, networked computers (nodes)* that collaborate to appear as a *single coherent system* to users (Tanenbaum).  
  - Nodes share resources, operate concurrently, and are geographically dispersed.  
- **Key Classifications (Flynn’s Taxonomy)**:  
  - **MIMD** (Multiple Instruction, Multiple Data):  
    - **Shared Memory**: Nodes access a global address space.  
    - **Distributed Memory**: Nodes have independent memory; communication via middleware.  
  - *Distributed systems are MIMD with distributed memory*.  

---

#### **2. Characteristics of Distributed Systems**  
1. **Concurrency**:  
   - Nodes execute tasks simultaneously (parallel processing).  
2. **Fault Tolerance**:  
   - Systems continue functioning despite component failures (e.g., replication, failover).  
3. **No Global Clock**:  
   - Nodes use local clocks; synchronization via protocols (e.g., NTP, Lamport timestamps).  
4. **Scalability**:  
   - Nodes can be added/removed to adapt to workload changes.  
5. **Transparency**:  
   - Users interact with the system as a single entity (hides underlying complexity).  
6. **Resource Sharing**:  
   - Hardware, software, and data are shared across nodes.  

---

#### **3. Why Use Distributed Systems?**  
- **Historical Drivers**:  
  - Evolution from mainframes (1950s) to cloud computing, IoT, and blockchain (2010s).  
- **Key Needs**:  
  1. Harness interconnected systems for scalability and reliability.  
  2. Address challenges of the digital age (big data, real-time processing).  
  3. Leverage advancements in networking, miniaturization, and computing power.  

---

#### **4. Challenges of Distributed Systems**  
| **Challenge**              | **Key Issues**                                                                 | **Related Fallacies** |  
|-----------------------------|-------------------------------------------------------------------------------|-----------------------|  
| **Complexity**              | Design, debugging, and troubleshooting due to distributed nature.            | All 8 Fallacies       |  
| **Communication Overhead**  | Network latency, congestion, bandwidth limitations.                          | F1, F2, F3            |  
| **Data Consistency**        | Maintaining up-to-date data across nodes (replication vs. consistency trade-offs). | F1                    |  
| **Security**                | Larger attack surface; data protection (encryption, access control).          | F4                    |  
| **Fault Tolerance**         | Handling node failures; preventing cascading failures.                       | F1, F5                |  
| **Scalability**             | Balancing load; managing performance as the system grows.                    | F3, F7                |  
| **Management & Monitoring** | Coordination across administrators; heterogeneous networks.                  | F6, F8                |  

- **The 8 Fallacies of Distributed Computing**:  
  1. The network is reliable.  
  2. Latency is zero.  
  3. Bandwidth is infinite.  
  4. The network is secure.  
  5. Topology doesn’t change.  
  6. There is one administrator.  
  7. Transport cost is zero.  
  8. The network is homogeneous.  

---

#### **5. Types of Distributed Systems**  
1. **Client-Server**:  
   - Clients request services from centralized servers (e.g., web servers, databases).  
2. **Peer-to-Peer (P2P)**:  
   - Decentralized nodes act as both clients and servers (e.g., BitTorrent, blockchain).  
3. **Cloud Computing**:  
   - On-demand resources over the internet (e.g., AWS, Azure).  
4. **Distributed File Systems**:  
   - Files stored across nodes (e.g., GFS, HDFS).  
5. **Distributed Databases**:  
   - Data distributed for scalability (e.g., Cassandra, MongoDB).  
6. **Sensor Networks (IoT)**:  
   - Devices collect and transmit data (e.g., smart homes, industrial IoT).  

---

#### **6. Interaction Styles Between Nodes**  
- **Categorized by**:  
  - **Synchrony**:  
    - *Synchronous*: Blocking until response (e.g., Request/Response).  
    - *Asynchronous*: Non-blocking (e.g., Publish/Subscribe).  
  - **Communication Pattern**:  
    - *One-to-One*: Single sender and receiver.  
    - *One-to-Many*: Broadcast to multiple receivers.  

| **Style**              | **Example**                          |  
|-------------------------|--------------------------------------|  
| Request/Response        | HTTP API calls.                      |  
| Notification            | One-way messages (e.g., logging).    |  
| Publish/Subscribe       | Event-driven systems (e.g., Kafka).  |  

---

#### **7. Key Takeaways**  
- Distributed systems are **hard** due to inherent challenges like network unreliability, latency, and security.  
- Design principles must address fallacies (e.g., assume networks are unreliable and latency is non-zero).  
- Real-world systems vary widely (client-server, P2P, cloud) and require trade-offs between consistency, availability, and partition tolerance (CAP theorem).  

---

#### **Exam Focus Areas**  
- **Definitions**: Know Tanenbaum’s and Lamport’s definitions.  
- **Fallacies vs. Challenges**: Map fallacies to specific challenges (e.g., F1 → Complexity, F3 → Bandwidth).  
- **Examples**: Be ready to explain real-world systems (e.g., HDFS for distributed files, AWS for cloud).  
- **Interaction Styles**: Compare synchronous vs. asynchronous and one-to-one vs. one-to-many.  
