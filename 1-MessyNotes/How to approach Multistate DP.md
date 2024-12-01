[[DP]]

The key steps are:

1. **Identify the states**: Determine the different states your problem can be in at any given time. In the stock problem, the states were:
   - Holding a stock
   - In cooldown (just sold a stock)
   - Not holding a stock and not in cooldown

2. **Define the state variables**: Represent the states using an appropriate data structure, typically a 1D or 2D array. In the stock problem, we used a 2D array `dp[i][j]` where `i` represents the day and `j` represents the state.

3. **Identify the base cases**: Determine the initial conditions for the first day/time step. This sets the foundation for the rest of the solution. In the stock problem, the base cases were the states on day 0.

4. **Establish the state transitions**: Determine how you can move between the different states from one day/time step to the next. This is the core of the dynamic programming solution. In the stock problem, the state transitions were the equations that calculated the maximum profit for each state on the current day based on the previous day's states.

5. **Write the recurrence relation**: Combine the state variables and state transitions into a concise mathematical expression that captures the overall solution. In the stock problem, the recurrence relation was the set of equations that defined `dp[i][j]` in terms of `dp[i-1][k]` for the different states `j` and `k`.

6. **Implement the solution**: Translate the recurrence relation into code, using a bottom-up (iterative) or top-down (recursive with memoization) approach. In the stock problem, we used a bottom-up, iterative approach.

7. **Optimize space complexity**: Analyze the solution and see if you can optimize the space complexity, usually by reducing the number of state variables required. In the stock problem, we could have reduced the 2D array to a 1D array by only storing the necessary states.

8. **Test and validate**: Test your solution with sample inputs and edge cases to ensure it works correctly. Verify that the final answer matches the problem statement.

The key things to remember are:
1. Clearly identify the states and the state variables
2. Establish the base cases and state transitions
3. Translate the recurrence relation into code
4. Optimize space complexity if possible
