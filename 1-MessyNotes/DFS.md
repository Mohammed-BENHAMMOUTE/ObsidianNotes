### Roads in Berland:
https://codeforces.com/contest/25/problem/C
in this problem we have to find the new shortest path if we add new paths to the the graph, we do using somethong similar to the algorithm of Floyd-Warshal. We have alsmost to reconstruct the the matrix by for each shortest path between two nodes, we insert  the new road in  the path. and check of its smaller than the current shortest path.
https://codeforces.com/contest/25/submission/280651899

### Party:
https://codeforces.com/contest/116/problem/C
in this problem the idea is to find the maximum depth of connected components.
i Struggled to code it using dfs.
here is how to find the max depth in a graph using dfs


```cpp
void dfs(int v) {
	vis[v] = 1;
	maxDepth[v] = 1;
	for(auto u : adj[v]) {
		if(vis[u] == 0) {
			dfs(u);
		}
		maxDepth[v] = max(maxDepth[v], maxDepth[u] + 1);
	}
};

int main{
.
.
.
.
.
int result = 0;

for(int i = 1; i <= n; i++) {
	if(vis[i] == 0) {
		dfs(i);
		result = max(result, maxDepth[i]);
	};
};
	cout << result << endl;
};
```
## Forming Teams:
the main idea is to count how many individuals make a problem when we trie to color the graph , and devide it by two since each one will be counted twice.
`https://codeforces.com/contest/216/submission/283792071`

## Maze:
you are givene a connected matrix and you are asked to fill k spaces such that the new matrix is still connected.
you can do dfs starting from any node and when the number of nodes visited is superior to `Freecells - k`, you fill these spaces, you can easily do this by choosing the last k elements of the call stack of the in the dfs function.
```java
function <void (int,int)> dfs = [&](int x, int y){}
	vis[x][y]=1;
	for(int i = 0; i < 4 ; i++){
		int nx = x + dx[i];
		int ny = y + dy[i];
		if(isValid(nx,ny) && a[nx][ny] == '.' && !vis[nx][ny]){
			dfs(nx,ny);
		}
	}
	if(k > 0){
	a[x][y] = 'X';
	k--;
	}
};
```

## Choosing the capitol of for Treeland
https://codeforces.com/contest/219/problem/D
this problem is about tree reRouting, and can be solved in two ways the first is to do dfs on all of the nodes and find the minimum, the time complexity if of `O(n**2)`, a better a proach is to do dfs on a chosen node and dtermine the number of the roads we need to reverse, and then create a dp table, for each node , we can conclude its answer using its parent node, if its in the right directition we subtract one , else we add one to the parents dp[parent].

