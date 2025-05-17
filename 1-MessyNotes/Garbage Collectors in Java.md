[[java]]
[[Interview Prep]]

---
# Java Garbage Collectors

### **Overview**
- **Purpose**: Automate memory reclamation of unreachable heap objects to prevent leaks.
- **Key Trade-offs**: Throughput vs. Latency, Pause Times, Heap Size, CPU/Memory Overhead.

---

## **Types of Garbage Collectors**

### 1. Serial GC 
- **Mechanism**: Single-threaded, "stop-the-world" pauses.
- **Use Case**: Small apps, CLI tools, limited-resource environments.
- **Pros**: Simple, low overhead.
- **Cons**: Long pauses for large heaps.

### 2. Parallel (Throughput) GC ⚡
- **Mechanism**: Multi-threaded STW pauses, divides heap into regions.
- **Use Case**: Multi-core systems prioritizing throughput (batch processing, analytics).
- **Pros**: Faster than Serial GC.
- **Cons**: Still noticeable pauses.

### 3. CMS (Concurrent Mark-Sweep) 🔄
- **Mechanism**: Mostly concurrent (phases: initial mark, concurrent mark, remark, sweep).
- **Use Case**: Apps needing shorter pauses (older web servers).
- **Pros**: Reduced STW pauses.
- **Cons**: Heap fragmentation, deprecated in Java 9+.

### 4. G1 (Garbage-First) 
- **Mechanism**: Heap divided into regions; prioritizes garbage-heavy regions. Mixes generational + concurrent strategies.
- **Use Case**: Balanced throughput + low latency (default since Java 9).
- **Pros**: Predictable pauses, handles large heaps.
- **Cons**: Moderate overhead.

### 5. ZGC (Z Garbage Collector) 
- **Mechanism**: Concurrent compaction, read barriers, sub-10ms pauses.
- **Use Case**: Large heaps (TB-scale), latency-critical apps (real-time systems).
- **Pros**: Minimal pauses, scalable.
- **Cons**: Higher CPU/memory usage.

### 6. Shenandoah 
- **Mechanism**: Concurrent compaction via "Brooks pointers", sub-millisecond pauses.
- **Use Case**: Ultra-low latency (financial trading, telecom).
- **Pros**: Pauses independent of heap size.
- **Cons**: Requires JDK 12+, Red Hat support.

---

## **Key Concepts**
- **Stop-the-World (STW)**: Application halts during GC (Serial/Parallel GC).
- **Heap Fragmentation**: Unused memory gaps (CMS weakness).
- **Throughput**: Work done per unit time (Parallel GC excels).
- **Latency**: Pause predictability (ZGC/Shenandoah focus).

---

## **Summary**
| GC Type        | Pause Style       | Best For                     | Trade-off                   |
| -------------- | ----------------- | ---------------------------- | --------------------------- |
| **Serial**     | STW               | Small apps                   | Simplicity ↔️ Long pauses   |
| **Parallel**   | STW (multi)       | Throughput-focused apps      | Speed ↔️ Moderate pauses    |
| **CMS**        | Mostly concurrent | Shorter pauses (deprecated)  | Low pauses ↔️ Fragmentation |
| **G1**         | Concurrent/STW    | Balanced workloads (default) | Predictability ↔️ Overhead  |
| **ZGC**        | Concurrent        | Huge heaps + low latency     | Scalability ↔️ Resource use |
| **Shenandoah** | Concurrent        | Extreme low-latency demands  | Speed ↔️ Complexity         |