- [x] The skyline problem. 
- [ ] Perfect rectangle.
- [ ] minimal interval to include each query. 
- [ ] rectangle area 2.
// Created by mohammed on 12/12/24.
```cpp
#include<bits/stdc++.h>
using namespace std;
class Solution {
public:
    vector<vector<int>> getSkyline(vector<vector<int>>& buildings) {
        const int n = buildings.size();
        int mxCurrent = 0;
        vector<pair<int,int>> events;
        multiset<int> s;
        vector<vector<int>> ans;
        for (int i =0 ; i < n ;i++) {
            events.push_back(make_pair(buildings[i][0], -buildings[i][2]));
            events.push_back(make_pair(buildings[i][1],buildings[i][2]));
        }
        sort(events.begin(), events.end());
        for (const pair<int, int>& event : events) {
            int curr = event.second;
            if (curr< 0) {
                s.insert(-curr);
                if (-curr > mxCurrent) {
                    ans.push_back({event.first, -event.second});
                    mxCurrent = -curr;
                }
            }else {
                auto it = s.find(curr);
                s.erase(it);
                if (curr == mxCurrent) {
                    if (s.empty()) {
                        mxCurrent = 0;
                    }else {
                        mxCurrent = *s.rbegin();
                    }
                }
                if (mxCurrent < curr) {
                    ans.push_back({event.first,mxCurrent});
                }
            }
        };
        return ans;
    }
};
```