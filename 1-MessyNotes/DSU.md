---
aliases:
---
# Disjoint Set Union (DSU) with Rollback - CP Documentation

## Table of Contents
1. [Introduction](#introduction)
2. [Standard DSU Recap](#standard-dsu-recap)
3. [DSU with Rollback](#dsu-with-rollback)
4. [Implementation](#implementation)
5. [Advanced Techniques](#advanced-techniques)
6. [Problem Types](#problem-types)
7. [Practice Problems](#practice-problems)
8. [Time & Space Complexity](#complexity-analysis)

## Introduction

**DSU with Rollback** is a variant of the standard Disjoint Set Union data structure that supports **undoing** the last union operations. This is crucial for problems involving:
- Backtracking algorithms
- Offline query processing with divide & conquer
- Dynamic connectivity with edge deletions
- Persistent data structures

### Key Differences from Standard DSU
| Feature | Standard DSU | DSU with Rollback |
|---------|--------------|-------------------|
| Path Compression | ✅ Yes | ❌ **NO** (breaks rollback) |
| Union by Rank | ✅ Yes | ✅ Yes |
| Undo Operations | ❌ No | ✅ Yes |
| Find Complexity | O(α(n)) | O(log n) |
| Space Complexity | O(n) | O(n + operations) |

## Standard DSU Recap

```cpp
struct StandardDSU {
    vector<int> parent, rank;
    
    StandardDSU(int n) : parent(n), rank(n, 0) {
        iota(parent.begin(), parent.end(), 0);
    }
    
    int find(int x) {
        return parent[x] == x ? x : parent[x] = find(parent[x]); // Path compression
    }
    
    bool unite(int x, int y) {
        x = find(x); y = find(y);
        if (x == y) return false;
        if (rank[x] < rank[y]) swap(x, y);
        parent[y] = x;
        if (rank[x] == rank[y]) rank[x]++;
        return true;
    }
};
```

## DSU with Rollback

### Core Concept
Instead of modifying the tree structure permanently, we:
1. **Store history** of all changes made during union operations
2. **Disable path compression** (it would modify parent pointers)
3. **Enable rollback** by reversing stored changes

### Why No Path Compression?
Path compression modifies parent pointers during `find()` operations, making it impossible to restore the exact previous state.

## Implementation

### Basic Rollback DSU

```cpp
struct RollbackDSU {
    vector<int> parent, rank;
    vector<tuple<int, int, int, int>> history; // {node1, old_parent1, node2, old_rank2}
    
    RollbackDSU(int n) : parent(n), rank(n, 0) {
        iota(parent.begin(), parent.end(), 0);
    }
    
    int find(int x) {
        return parent[x] == x ? x : find(parent[x]); // NO path compression
    }
    
    bool unite(int x, int y) {
        x = find(x); y = find(y);
        if (x == y) {
            history.emplace_back(-1, -1, -1, -1); // No-op marker
            return false;
        }
        
        // Store current state before modification
        if (rank[x] < rank[y]) swap(x, y);
        
        if (rank[x] == rank[y]) {
            history.emplace_back(y, parent[y], x, rank[x]);
            parent[y] = x;
            rank[x]++;
        } else {
            history.emplace_back(y, parent[y], -1, -1);
            parent[y] = x;
        }
        return true;
    }
    
    void rollback() {
        assert(!history.empty());
        auto [node1, old_parent1, node2, old_rank2] = history.back();
        history.pop_back();
        
        if (node1 == -1) return; // No-op rollback
        
        parent[node1] = old_parent1;
        if (node2 != -1) rank[node2] = old_rank2;
    }
    
    bool connected(int x, int y) {
        return find(x) == find(y);
    }
    
    int snapshot() { return history.size(); }
    
    void rollback_to(int snapshot_id) {
        while (history.size() > snapshot_id) {
            rollback();
        }
    }
};
```