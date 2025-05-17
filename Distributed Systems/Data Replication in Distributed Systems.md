[[Distributed Systems]]
## 1. Fundamental Concepts

### What is Replication?

- Storing copies of data across multiple machines
- Purposes:
    1. Scalability
    2. Fault Tolerance
    3. High Availability
    4. Reduced Latency

### Two Main Data Distribution Methods

1. Replication: Copying the same data to multiple nodes
2. Partitioning (Sharding): Splitting data into smaller subsets across different nodes

## 2. Replication Approaches

### A. Single-Leader Replication

- One node (leader/master) accepts all writes
- Other nodes (followers/replicas) replicate data from the leader
- Read/write separation:
    - Writes only to leader
    - Reads from leader or followers

#### Replication Types

1. Synchronous Replication
    
    - Leader waits for follower confirmation
    - Strong consistency
    - Can block writes if follower is slow
2. Asynchronous Replication
    
    - Leader doesn't wait for follower confirmation
    - Better performance
    - Risk of data loss if leader fails
3. Semi-Synchronous Replication
    
    - One follower is synchronous
    - Others are asynchronous
    - Provides a balance between consistency and performance

#### Handling Node Failures

- Follower Failure:
    - Reconnect and catch up with missed changes
- Leader Failure (Failover):
    
    1. Detect leader failure
    2. Choose new leader
    3. Reconfigure system
    
    - Challenges: Data loss, split-brain problem, timeout sensitivity

#### Replication Log Implementation Methods

1. Statement-Based Replication
    
    - Log and replay SQL statements
    - Issues with non-deterministic functions
2. Write-Ahead Log (WAL) Shipping
    
    - Send low-level disk block changes
    - Version-specific, storage engine dependent
3. Logical (Row-Based) Log Replication
    
    - Track row-level modifications
    - More flexible, storage-independent
4. Trigger-Based Replication
    
    - Custom application-level replication
    - Flexible but complex

### B. Multi-Leader Replication

- Multiple nodes can accept writes
- Each leader also acts as a follower

#### Use Cases

1. Multi-datacenter operations
2. Offline-capable applications (e.g., calendar apps)

#### Challenges

- Write Conflicts
- Complexity in conflict resolution

#### Conflict Resolution Strategies

1. Last Write Wins (LWW)
2. Replica Priority
3. Merging Values
4. Explicit Conflict Storage

#### Replication Topologies

- All-to-All (Mesh)
- Circular (Ring)
- Star
- Tree

### C. Leaderless Replication

- Any replica can accept writes
- No global write ordering

#### Key Characteristics

- Partial write success
- Stale read handling
- Quorum-based consistency

#### Quorum Mechanisms

- Parameters: n (total replicas), w (write replicas), r (read replicas)
- Consistency ensured when w + r > n
- Adjustable for read-heavy or write-heavy workloads

#### Consistency Techniques

1. Read Repair
2. Anti-Entropy
3. Sloppy Quorums

## 3. Key Considerations

- Trade-offs between consistency, availability, and performance
- Importance of handling network failures
- Complexity increases with more advanced replication models

## Exam Tips

- Understand the pros and cons of each replication approach
- Know the challenges in maintaining consistency
- Be prepared to discuss trade-offs in distributed systems