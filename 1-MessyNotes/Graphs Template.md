[[CP]]

# Connected components
```C
int connectedComponent()
{
	int cnt = 0;
	for(int i = 0; i < n ; i++){
		if(!visited[i]){
			dfs(i);
			cnt++;
		}
	}
	return cnt;
}
```

## Topological Sort + Dfs:
```C
void dfs(int node)
{
	visited[node] = true;
	rep(i, adj[node])
	{
		int child = adj[node][i];
		if (!visited[child])	
			dfs(child);
	}
	topsort.push_back(node);
}
```
## Topological sort with Kahn's algorithm:
