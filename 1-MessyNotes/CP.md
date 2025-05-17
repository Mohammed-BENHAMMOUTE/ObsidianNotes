## Math:
```cpp
// Fast Input/Output Methods
ios_base::sync_with_stdio(false); 
cin.tie(nullptr);             // Use these at the start of main() for 

// Common Mathematical Operations
// Calculate (a * b) % mod avoiding overflow
ll mul_mod(ll a, ll b, ll mod) {
    return ((a % mod) * (b % mod)) % mod;
}

// Calculate (a + b) % mod avoiding overflow
ll add_mod(ll a, ll b, ll mod) {
    return ((a % mod) + (b % mod)) % mod;
}

// Calculate ceil(n/m)
ll ceil_div(ll n, ll m) {
    return (n + m - 1) / m;
}

// Fast Power Function (Binary Exponentiation)
// Calculates b^e % mod in O(log e)
ll fast_power(ll b, ll e, ll mod) {
    ll result = 1;
    while(e > 0) {
        if(e & 1) result = mul_mod(result, b, mod);
        b = mul_mod(b, b, mod);
        e >>= 1;
    }
    return result;
}

// Modular Multiplicative Inverse
// Returns x where (a * x) % mod = 1
ll mod_inverse(ll a, ll mod) {
    return fast_power(a, mod-2, mod);  // Only works when mod is prime
}
// modular inverse using non prime m:

def extended_gcd(a, b):
    if a == 0:
        return b, 0, 1
    gcd, x1, y1 = extended_gcd(b % a, a)
    x = y1 - (b//a) * x1
    y = x1
    return gcd, x, y

def mod_inverse(a, m):
    gcd, x, y = extended_gcd(a, m)
    if gcd != 1:
        raise Exception('Modular inverse does not exist')
    return (x % m + m) % m  # Handle negative x



vector<ll> fact(MAX_N);
vector<ll> fact_inv(MAX_N);

void precompute() {
    fact[0] = 1;
    for(ll i = 1; i < MAX_N; i++) {
        fact[i] = (fact[i-1] * i) % MOD;
    }
    
    // Calculate modular inverse of factorials
    fact_inv[MAX_N-1] = mod_inverse(fact[MAX_N-1], MOD);
    for(ll i = MAX_N-2; i >= 0; i--) {
        fact_inv[i] = (fact_inv[i+1] * (i+1)) % MOD;
    }
}

// Combination Calculator (nCr)
// Calculates C(n,r) % mod
ll nCr(ll n, ll r, ll mod, vector<ll>& fact, vector<ll>& fact_inv) {
    if(r > n) return 0;
    return mul_mod(fact[n], 
           mul_mod(fact_inv[r], fact_inv[n-r], mod), 
           mod);
}

// Permutation Calculator (nPr)
// Calculates P(n,r) % mod
ll nPr(ll n, ll r, ll mod, vector<ll>& fact, vector<ll>& fact_inv) {
    if(r > n) return 0;
    return mul_mod(fact[n], fact_inv[n-r], mod);
}
```

simple prime numbers functions:
```cpp
// Find all primes up to n using Sieve
vector<bool> get_primes(int n) {
    vector<bool> is_prime(n + 1, true);
    is_prime[0] = is_prime[1] = false;
    
    for(long long i = 2; i <= sqrt(n); i++)
        if(is_prime[i])
            for(long long j = i * i; j <= n; j += i) 
                is_prime[j] = false;
    
    return is_prime;
}

// Get vector containing prime numbers up to n
vector<int> get_prime_numbers(int n) {
    vector<bool> is_prime = get_primes(n);
    vector<int> primes;
    
    for(int i = 2; i <= n; i++)
        if(is_prime[i])
            primes.push_back(i);
    
    return primes;
}

// Get prime factors of a number
vector<int> prime_factors(int n) {
    vector<int> factors;
    
    for(int i = 2; i * i <= n; i++) {
        while(n % i == 0) {
            factors.push_back(i);
            n /= i;
        }
    }
    if(n > 1) factors.push_back(n);
    return factors;
}

// Count number of prime factors
int count_prime_factors(int n) {
    int count = 0;
    
    for(int i = 2; i * i <= n; i++) {
        while(n % i == 0) {
            count++;
            n /= i;
        }
    }
    if(n > 1) count++;
    
    return count;
}

// Check if number is prime - O(sqrt(n))
bool is_prime(int n) {
    if(n < 2) return false;
    if(n == 2) return true;
    if(n % 2 == 0) return false;
    
    for(int i = 3; i * i <= n; i += 2)
        if(n % i == 0) return false;
    
    return true;
}

// Get all divisors of a number
vector<int> get_divisors(int n) {
    vector<int> divisors;
    
    for(int i = 1; i * i <= n; i++) {
        if(n % i == 0) {
            divisors.push_back(i);
            if(i * i != n) 
                divisors.push_back(n/i);
        }
    }
    sort(divisors.begin(), divisors.end());
    
    return divisors;
}

// Count number of divisors
int count_divisors(int n) {
    int count = 0;
    for(int i = 1; i * i <= n; i++) {
        if(n % i == 0) {
            count++;
            if(i * i != n) count++;
        }
    }
    return count;
}
```

### Search Techniques
```cpp
int BSfindFirst(int start, int end, int val) {
	while(start < end) {
		int mid = start + (end-start)/2;
		if(f(mid) < val)		start= mid+1;
		else if(f(mid) > val)	end  = mid-1;
		else					end  = mid;
	}
	return start;
}
int BSfindLast(int start, int end, int val) {
	while(start < end) {
		int mid = start + (end-start)/2;
		if(f(mid) < val)		start= mid+1;
		else if(f(mid) > val)	end  = mid-1;
		else					start= mid;
	}
	return start;
}

double BS_double(double start, double end, double val) {
	while(fabs(end - start) > EPS) {	// iterate 100-500 iteration
		double mid = start + (end-start)/2;
		if(f(mid) < val)	start= mid;
		else 				end  = mid;
	}
	return start;
}

double binary(double start, double end)
{
	lp(i, 100) {	// loop as much as u want
	    double mid = (start+end)/2;
	    if( can(mid) )
	    	end = mid;
	    else
	    	start = mid;
	}

	if( can(end) )
		return start;
	return -1;	// failed
}
```

### Graph:
1. dfs related:
```cpp
void dfs(int node)
{
	visited[node] = true;

	rep(i, adj[node])
	{
		int child = adj[node][i];
		if (!visited[child])	// To avoid cyclic behavior
			dfs(child);
	}

	topsort.push_back(node);	// DAG // Other way Indegree / Outdegree
}

int ConnectedComponenetsCnt()
{
	int cnt = 0;
	lp(i, n)
	{
		if(!visited[i])	// Then no one reach this isolated node yet and its neighbors.
		{
			dfs(i);
			cnt++;
		}
	}
	return cnt;
}

void dfs_EdgeClassification(int node)
{
	start[node] = timer++;
	rep(i, adj[node])
	{
		int child = adj[node][i];
		if (start[child] == -1)	// Not visited Before. Treed Edge
			dfs_EdgeClassification(child);
		else {
			if(finish[child] == -1)// then this is ancestor that called us and waiting us to finish. Then Cycle. Back Edge
				anyCycle = 1;
			else if(start[node] < start[child])	// then you are my descendant
				;	// Forward Edge
			else
				;	// Cross Edge
		}
	}
	finish[node] = timer++;
}

// cycle detection using bfs:
bool isCyclic(int V, vector<vector<int>> adj) {
    vector<int> indegree(V , 0);
    for(int i =0 ; i < V ; i++) 
    {
        for(int x : adj[i])
		{
            indegree[x]++;
        }
    }
    queue<int> q;
    for(int i = 0; i < V ; i++) {
        if(indegree[i] == 0 ){
            q.push(i);
        }
    };
    int cnt  = 0;
	while(!q.empty()){
        int current = q.front();q.pop();cnt++;
	    for(int x : adj[current]){
		    indegree[x]--;
	        if(indegree[x] == 0){
				q.push(x);
	        }
		}
	}
    return cnt != V;
};
```

1. Floyd warshall algorithm:
```cpp
for (int i = 1; i <= n; i++) {
	for (int j = 1; j <= n; j++) {
		if (i == j) distance[i][j] = 0;
		else if (adj[i][j]) distance[i][j] = adj[i][j];
		else distance[i][j] = INF;
	}
}

for (int k = 1; k <= n; k++) {
	for (int i = 1; i <= n; i++) {
		for (int j = 1; j <= n; j++) {
			distance[i][j] = min(distance[i][j],
			distance[i][k]+distance[k][j]);
		}
	}
}
```



#### Topological sort:
```cpp
// using bfs
bool isCyclic(int V, vector<vector<int>> adj) {
    vector<int> indegree(V , 0);
    for(int i =0 ; i < V ; i++) 
    {
        for(int x : adj[i])
        {
            indegree[x]++;
        }
    }
    queue<int> q;
    for(int i = 0; i < V ; i++) {
        if(indegree[i] == 0 ){
            q.push(i);
        }
    };
    int cnt  = 0;
    while(!q.empty()){
        int current = q.front();q.pop();cnt++;
        for(int x : adj[current]){
            indegree[x]--;
            if(indegree[x] == 0){
                q.push(x);
            }
        }
    }
        return cnt != V;
};
```

```cpp
struct edge {
	int from, to, w;
	edge(int from, int to, int w): from(from), to(to), w(w) {}
	bool operator < (const edge & e) const {
		return w > e.w;
	}
};
int Dijkstra2(vector< vector< edge > > adjList, int src, int dest = -1)	// O(E logV)
{
	int n = sz(adjList);
	vi dist(n, OO), prev(n, -1);
	dist[src] = 0;
	priority_queue<edge> q;
	q.push( edge(-1, src, 0) );
	while( !q.empty() ) {
		edge e = q.top();	q.pop();
		if(e.w > dist[e.to])	continue;	// some other state reached better
		prev[ e.to ] = e.from;
		rep(j, adjList[e.to]) {
			edge ne = adjList[e.to][j];
			if( dist[ne.to] > dist[ne.from] + ne.w ) {
				ne.w = dist[ne.to] = dist[ne.from] + ne.w;
				q.push( ne );
			}
		}
	}
	return dest == -1 ? -1 : dist[dest];
}
vector<int> dijkstra(vector<vector<pair<int, int>>> &adj, int src) {
    int n = adj.size();
    vector<int> dist(n, INT_MAX);
    priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
    pq.push({0, src});
    dist[src] = 0;
    while (!pq.empty()) {
        int distance = pq.top().first;
        int  parent = pq.top().second;
        pq.pop();
        for (auto it : adj[parent]) {
            int child = it.first;
			int currDistance = it.second;
			if (dist[parent] + currDistance < dist[child]) {
                dist[child] = dist[parent] + currDistance;
                pq.push({dist[child], child});
            }
        }
    }
    return dist;
}
```
### Dynamic programming:
Knapsack:
```cpp
possible[0][0] = true;
for (int k = 1; k <= n; k++) {
	for (int x = 0; x <= W; x++) {
		if (x-w[k] >= 0) possible[x][k] |= possible[x-w[k]][k-1];
		possible[x][k] |= possible[x][k-1];
	}
};
```

```cpp
possible[0] = true;
for (int k = 1; k <= n; k++) {
	for (int x = W; x >= 0; x--) {
		if (possible[x]) possible[x+w[k]] = true;
	}
}
```

longest increasing substring:
```cpp
int lis(vector<int>& arr) {
    int n = arr.size();
    vector<int> lis(n, 1);
    for (int i = 1; i < n; i++) {
        for (int prev = 0; prev < i; prev++) {
            if (arr[i] > arr[prev] && lis[i] < lis[prev] + 1) {
                lis[i] = lis[prev] + 1;
            }
        }
    }
    return *max_element(lis.begin(), lis.end());
}
```
longest common substring 
```cpp
int maxCommStr(const string& s1, const string& s2) {
    int m = s1.length();
    int n = s2.length();
    vector<vector<int>> LCSuf(m + 1, vector<int>(n + 1, 0));    
    int res = 0;
    for (int i = 1; i <= m; i++) {
        for (int j = 1; j <= n; j++) {
            if (s1[i - 1] == s2[j - 1]) {
                LCSuf[i][j] = LCSuf[i - 1][j - 1] + 1;
                res = max(res, LCSuf[i][j]);
            } else {
                LCSuf[i][j] = 0;
            }
        }
    }
    return res;
}
```
