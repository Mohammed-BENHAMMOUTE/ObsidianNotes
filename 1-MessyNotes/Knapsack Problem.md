[[Competitive programming]]
[[algorithms]]


types of knapsacks problems:
1. 0/1 knapsack.
2. Fractional Knapsack.

in the knapsack problem you are given a an array and you are asked to find a subset that verifies certain The conditions.

how can we do this efficiently?
1. define the sub-problems:
   the sub-problem that i can see here is the number of elements used to gather this sets, and what elements are those?
   
for each item we have two options: either we include that item or exclude it.

for example we can have the following for the classical knapsack problem where we are trying to find the maximum value we can get into our bag of capacity W.

to do that we can have the following recurrence relationship:
we either include or exclude there for:

dp{i}{w} = is the max sum of the subset using the first i elements, not necessarly using all of them.

```cpp
dp[i][w] = {
	dp[i-1][w] if nums[i] > w
	max(dp[i-1][w-nums[i]] + nums[i], dp[i-1][w])
}
```

minimum number coins to form the given sum? 





