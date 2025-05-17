[[Distributed Systems]]

---

## **1. Starting Point: Single Server Setup**
- **Components**: Web server, database, and application logic run on a single machine.
- **Request Flow**:
  1. User accesses via DNS.
  2. HTTP requests routed to the web server.
  3. Server returns HTML/JSON responses.
- **Limitations**: No redundancy, limited scalability, single point of failure (SPOF).

---

## **2. Separating Data Tier**
- **Why?** Independent scaling of web tier (handles traffic) and data tier (handles storage).
- **Database Options**:
  - **Relational (SQL)**: Structured data, ACID compliance, joins.
  - **NoSQL**: Unstructured data, low latency, horizontal scaling (key-value, document, graph, column stores).
- **Use Cases for NoSQL**: High write volumes, unstructured data, massive datasets.

---

## **3. Scaling the Web Tier**
### **Vertical Scaling (Scale-Up)**
- Add more resources (CPU, RAM) to a single server.
- **Pros**: Simplicity.  
- **Cons**: Hardware limits, no redundancy, high cost.

### **Horizontal Scaling (Scale-Out)**
- Add more servers + **Load Balancer**.
- **Load Balancer Algorithms**:
  - **Static**: Round Robin, Sticky Round Robin, Weighted Round Robin, IP/URL Hash.
  - **Dynamic**: Least Connections, Least Time (response time-based).
- **Benefits**: Fault tolerance, high availability, elasticity.

---

## **4. Database Replication**
- **Master-Slave Architecture**:
  - **Master**: Handles writes.
  - **Slaves**: Read replicas (improve read performance).
- **Advantages**:
  - Performance: Parallel read operations.
  - Reliability: Data redundancy.
  - Availability: Failover to healthy replicas.
- **Failure Handling**:
  - Slave failure: Redirect reads to master or other slaves.
  - Master failure: Promote a slave (requires data recovery).

---

## **5. Caching Strategies**
- **Purpose**: Reduce database load, improve latency.
- **Cache Types**:
  - **Cache-Aside**: App checks cache first, lazy loading, read heavy.
  - **Read-Through**: Cache fetches from DB on miss, read heavy.
  - **Write-Through**: Writes to cache + DB synchronously, cache consistency.
  - **Write-Back**: Async writes to DB (risk of data loss). 
  - **Write-Around**: Direct DB writes, bypass cache, better for application where cache is costly.
- **Considerations**:
  - TTL (Time-to-Live) for stale data.
  - Eviction policies (LRU, LFU, FIFO).
  - Cache failure resilience.

---

## **6. Content Delivery Network (CDN)**
- **Purpose**: Cache static assets (images, CSS, JS) globally.
- **Workflow**:
  1. User request → Nearest CDN edge server.
  2. Cache miss → Fetch from origin (web server/S3).
  3. Cache with TTL.
- **GeoDNS**: Routes users to the nearest CDN node.
- **Considerations**: Cost, cache invalidation, fallback to origin.

---

## **7. Stateless Web Tier**
- **Stateful vs. Stateless**:
  - **Stateful**: Session data stored on servers → Requires sticky sessions.
  - **Stateless**: Session data in shared storage (DB/Redis) → Auto-scaling friendly.
- **Benefits**: Simplicity, fault tolerance, scalability.

---

## **8. Multiple Data Centers**
- **GeoDNS**: Routes users to the nearest data center.
- **Challenges**:
  - Data synchronization (cross-DC replication).
  - Traffic redirection during outages.
  - Consistent deployments.
- **Use Case**: Disaster recovery, reduced latency for global users.

---

## **9. Asynchronous Messaging**
- **Message Channels**: Decouple producers/consumers (e.g., RabbitMQ, Kafka).
- **Use Case**: Background processing (e.g., photo editing).
- **Benefits**: Scalability, fault tolerance, load leveling.

---

## **10. Monitoring, Logging & Automation**
- **Logging**: Centralized error tracking (e.g., ELK Stack).
- **Metrics**:
  - Host-level (CPU, memory).
  - Business-level (DAU, revenue).
- **Automation**: CI/CD pipelines, auto-scaling.

---

## **11. Scaling the Data Tier**
### **Vertical Scaling (Database)**
- **Limitations**: Hardware limits, high cost, SPOF.

### **Horizontal Scaling (Sharding)**
- **Sharding Key**: Distributes data across shards (e.g., `user_id % 4`).
- **Challenges**:
  - Resharding (consistent hashing).
  - Hotspots (celebrity problem).
  - Joins require denormalization.
- **Benefits**: Handles massive datasets, parallel operations.

---

## **12. Key Takeaways**
1. **Iterative Scaling**: Start small, incrementally add layers (load balancers, CDN, caching).
2. **Redundancy**: Avoid SPOFs at every tier.
3. **Decoupling**: Use stateless services, async messaging.
4. **Monitoring**: Track metrics to identify bottlenecks.
5. **Automation**: Enable CI/CD, auto-scaling, and self-healing.

---

**Tags**: #Scalability #DistributedSystems #LoadBalancing #Caching #CDN #Sharding