## Priority Queue:

leetcode problem: [23. Merge k Sorted Lists](https://leetcode.com/problems/merge-k-sorted-lists/)
in this problem, just like merging arrays, I had to use Priority Queue,the only problem i faced if since we are using linked list, i had to declare the logic of comparison that i used, also the type of data structure that our heap will use, i had to define a comparison struct, 
```C
struct compare {
    bool operator()(ListNode* a, ListNode* b) {
        return a->val > b->val;
    }
};
```
then inside of the priority queue declaration,i used the following declaration:
```Cpp
priority_queue<ListNode*, vector<ListNode*>, compare> pq;
```

since the lists are sorted, we only have to enqueue the first element of each linked list at first and for each node of the linked list processed, we include its next to the priority queue.

## Task Scheduler [621. Task Scheduler](https://leetcode.com/problems/task-scheduler/)
nice problem actually.

you are asked to find the minimum time for a cpu to do some tasks with certain cooling period.
```txt
You are given an array of CPU `tasks`, each labeled with a letter from A to Z, and a number `n`.
Each CPU interval can be idle or allow the completion of one task.

Tasks can be completed in any order, but there's a constraint:
there has to be a gap of **at least** `n` intervals between two tasks with the same label.

Return the minimum number of CPU intervals required to complete all tasks.
```

the solution here resides in noticing that we can place the most frequent element as the first and last element in this sequence. so we dont have to simulate this precedure, we simply use this information.
another problem is the number of elements with max frequency, suppose that we have two elements that have two task with max frequncy 3.
then the which task will be last ? we dont know and we dont care,  A B  -  A  B - A B
another information that we need is: how many tasks has the maxFreq

the formula: 
```
ans = max((maxFreq -1)*(n+1) + countMaxFreq , tasks.size());
```
is this enough ?  can this be less than tasks.size()
and therefore here is the solution:
```cpp
class Solution {
public:
    bool isNStraightHand(vector<int>& hand, int groupSize) {
        if(hand.size() % groupSize != 0) return false;
        if(groupSize == 1) return true;
        map<int, int> freq;
        for(int x : hand){
            freq[x]++;
        }
        while(!freq.empty()){
            int first  = freq.begin()->first;
            for(int i = 0; i < groupSize ;i++) {
                int current = first + i;
                if(freq.find(current)  == freq.end()){
                    return false;
                }
                freq[current]--;
                if(freq[current] == 0) {
                    freq.erase(current);
                }
            }
            
        }
        return true;
    }
};
```


## Topological sort with khan algorithm:
