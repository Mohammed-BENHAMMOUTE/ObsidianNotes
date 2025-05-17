[[Distributed Systems]]
## Overview

Cache eviction policies determine which data should be removed from the cache when it reaches its storage limit. The goal is to optimize performance by keeping the most relevant data in memory.

## Common Eviction Policies

### 1. **Least Recently Used (LRU)**

- Removes the **least recently accessed** item.
    
- Assumes that recently used data is more likely to be used again.
    
- Implemented using a **doubly linked list** + **hashmap** for O(1) operations.
    
- **Use case:** General-purpose caching, operating system page replacement.
    

### 2. **Least Frequently Used (LFU)**

- Removes the **least frequently accessed** item.
    
- Maintains a **count** of accesses for each item.
    
- More complex than LRU but works better for **frequently accessed hot data**.
    
- **Use case:** Caches with predictable and repeated access patterns.
    

### 3. **First-In-First-Out (FIFO)**

- Removes the **oldest** item in the cache (first inserted, first evicted).
    
- Simple but does not consider access frequency.
    
- **Use case:** Streaming applications where old data becomes irrelevant.
    

### 4. **Random Replacement (RR)**

- Randomly selects an item to evict.
    
- Very simple to implement but lacks optimization.
    
- **Use case:** When simplicity is prioritized over efficiency.
    

### 5. **Time-To-Live (TTL) / Expiry-Based Eviction**

- Items are removed after a **fixed time period**.
    
- Useful when data naturally expires (e.g., session tokens, temporary results).
    
- **Use case:** Distributed caching, session management.
    

### 6. **Adaptive Replacement Cache (ARC)**

- Dynamically balances between **LRU and LFU**.
    
- Uses two queues to track **recency and frequency**.
    
- **Use case:** Modern databases and file systems (e.g., ZFS).
    

### 7. **Segmented LRU (SLRU)**

- Maintains two segments:
    
    - A **protected** segment for frequently accessed items.
        
    - A **probationary** segment for recently added items.
        
- Items move between segments based on usage.
    
- **Use case:** High-performance caching in web servers and databases.
    

## Choosing the Right Eviction Policy

|Policy|Best For|Downsides|
|---|---|---|
|**LRU**|General caching, OS memory management|Can remove frequently used old data|
|**LFU**|Hotspot data caching|Higher complexity, slow updates|
|**FIFO**|Streaming workloads|Doesn't account for access patterns|
|**RR**|Simple, lightweight caches|Poor cache efficiency|
|**TTL**|Expiring session data|Requires careful TTL tuning|
|**ARC**|Adaptive workloads|More complex than LRU/LFU|
|**SLRU**|Hybrid access patterns|Slightly more complex than LRU|

## Example: LRU Implementation in C++

```cpp
#include <unordered_map>
#include <list>
#include <iostream>

class LRUCache {
private:
    int capacity;
    std::list<int> keys;
    std::unordered_map<int, std::pair<int, std::list<int>::iterator>> cache;

public:
    LRUCache(int cap) : capacity(cap) {}

    int get(int key) {
        if (cache.find(key) == cache.end()) return -1;
        keys.splice(keys.begin(), keys, cache[key].second);
        return cache[key].first;
    }

    void put(int key, int value) {
        if (cache.find(key) != cache.end()) {
            keys.splice(keys.begin(), keys, cache[key].second);
        } else {
            if (keys.size() == capacity) {
                int lru = keys.back();
                keys.pop_back();
                cache.erase(lru);
            }
            keys.push_front(key);
        }
        cache[key] = {value, keys.begin()};
    }
};
```

## References

- [[LRU Cache]]
    
- [[Cache Strategies]]
    
- [[Database Optimization]]