[[Competitive programming]]
```Cpp
#include <vector>

class Solution {
private:
    std::vector<type> result;
    
    void backtrack(/* parameters */) {
        // Base case: if solution is found
        if (/* condition for solution */) {
            // Add solution to result
            result.push_back(/* current solution */);
            return;
        }
        
        // Iterate through possible choices
        for (/* each choice */) {
            // Check if the choice is valid
            if (/* is valid choice */) {
                // Make the choice
                
                // Recursively backtrack
                backtrack(/* updated parameters */);
                
                // Undo the choice (backtrack)
            }
        }
    }

public:
    std::vector<type> solve(/* input parameters */) {
        // Initialize any necessary variables
        
        // Start the backtracking process
        backtrack(/* initial parameters */);
        
        return result;
    }
};
```