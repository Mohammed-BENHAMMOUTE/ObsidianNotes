## 1. Docker vs. Kubernetes
Docker alone has limitations compared to Kubernetes, primarily in:
- **Scalability**: Kubernetes can automatically scale applications up/down based on demand
- **Maintenance**: Kubernetes provides automated deployments, rollbacks, and self-healing capabilities
Example: If your application suddenly receives high traffic:
- Docker: Manual scaling required
- Kubernetes: Can automatically create new pods to handle increased load

## 2. Distributed Architecture Types
1. **Service-Based Architecture**
   - Larger, more coarse-grained services
   - Each service handles a specific business domain
   Example: E-commerce system with separate services for Orders, Inventory, and Users

2. **Service-Oriented Architecture (SOA)**
   - Enterprise-level architecture
   - Uses ESB (Enterprise Service Bus)
   - Focuses on reusability
   Example: Banking system with shared services like Authentication, Logging

3. **Client-Based Architecture**
   - Focus on client-side processing
   - Server primarily provides data
   Example: Single Page Applications (SPAs)

4. **Microservices Architecture**
   - Small, independent services
   - Each service runs its own process
   Example: Netflix's system where each component (user profiles, recommendations, video streaming) is a separate service

## 3. Elasticity vs. Scalability
- **Scalability**: Ability to handle increased load by adding resources
  - Example: Adding more servers to handle more users
- **Elasticity**: Ability to automatically scale up/down based on demand
  - Example: AWS Auto Scaling adjusting resources during peak hours

## 4. Kubernetes Concepts

### Pods
- Smallest deployable unit in Kubernetes
- Contains one or more containers
- Shares network namespace and storage
Example Pod configuration:
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: web-app
spec:
  containers:
  - name: main-container
    image: nginx
  - name: helper-container
    image: log-collector
```

### Master-Worker Architecture
**Master Components** (Control Plane):
1. **etcd**
   - Distributed key-value store
   - Stores cluster state
   - Can be replaced with other databases, but not recommended

2. **API Server**
   - RESTful interface for cluster
   - All communications go through it

3. **Scheduler**
   - Decides which node runs which pod
   - Considers resources, constraints

4. **Controller Manager**
   - Manages different controllers
   - Handles node failures, replication

**Worker Node Components**:
1. **Kubelet**
   - Pod lifecycle manager
   - Ensures containers are running

2. **Kube-proxy**
   - Network proxy
   - Handles pod networking
   - Can be overridden using service mesh solutions like Istio

3. **Container Runtime**
   - Runs containers
   - Options include:
     - containerd: Industry standard container runtime
     - runc: Low-level container runtime
     - Docker (being phased out)

### Important Kubernetes Objects
1. **ConfigMaps**
   - Store non-sensitive configuration
   Example:
   ```yaml
   apiVersion: v1
   kind: ConfigMap
   metadata:
     name: app-config
   data:
     database_url: "db.example.com"
   ```

2. **Secrets**
   - Store sensitive information
   - Can be managed by:
     - AWS KMS (Key Management Service)
     - HashiCorp Vault
     - Cloud Provider Secret Managers

3. **Ingress**
   - Manages external access to services
   - Provides load balancing, SSL termination
   Example:
   ```yaml
   apiVersion: networking.k8s.io/v1
   kind: Ingress
   metadata:
     name: example-ingress
   spec:
     rules:
     - host: example.com
       http:
         paths:
         - path: /
           pathType: Prefix
           backend:
             service:
               name: web-service
               port:
                 number: 80
   ```

### Service Mesh and Sidecar Proxy
- Service Mesh: Infrastructure layer for service-to-service communication
- Sidecar Proxy: Additional container in pod handling network communication
Example: Istio injects a sidecar proxy (Envoy) into pods for traffic management
