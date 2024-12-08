[[docker]]
[[Docker Swarm]]
---

## **Docker Networking**

### **Container Networking Basics**

- Each container has its own **network namespace**, which isolates its network stack (interfaces, IP addresses, ports, etc.).
- By default, containers cannot communicate with each other unless explicitly configured.

#### **Example: Sharing a Network Namespace**

To allow a container to use the same network namespace as another (e.g., a Redis server):

```shell
docker run -d --name redis redis --bind 127.0.0.1
docker run -it --network container:redis redis redis-cli -h 127.0.0.1
```

- The `--network container:redis` option ensures the new container shares the network namespace of the `redis` container.

---

### **Docker Bridge Network**

The **bridge network** is the default Docker network. It acts as a virtual network switch with several key features:

#### **Characteristics**

1. **Internal Network Creation:**
    - Provides an isolated Docker network for container communication.
    - Functions as a **DHCP server**, assigning IPs (e.g., `172.17.0.0/16`).
2. **Container Communication:**
    - Containers on the same bridge network can communicate directly:
        
        ```text
        Container A (172.17.0.2) <--> docker0 bridge <--> Container B (172.17.0.3)
        ```
        
3. **NAT (Network Address Translation):**
    - Translates container private IPs to the host's IP for external access.
    - Maps container ports to host ports when specified with the `-p` flag.

#### **NAT in Action**

Think of NAT as a "receptionist" managing traffic between a private network and the internet:

```text
Internet <--> NAT (Router/Gateway) <--> Private Network
```

**How it works:**

1. Replaces private source IP (e.g., `192.168.1.5`) with a public IP.
2. Tracks connections to route responses back to the correct private IP.

#### **Publishing Ports Safely**

By default, publishing a port exposes it to the outside world. To restrict access to the host machine:

```shell
docker run -p 127.0.0.1:8080:80 -p '[::1]:8080:80'
```

- First option (`127.0.0.1`) binds to IPv4.
- Second option (`[::1]`) binds to IPv6.

---

### **Docker Network Types**

1. **Bridge (Default):**
    
    - Works on a single host.
    - Ideal for local development or single-host deployments.
    - Containers communicate via container names if on the same user-defined bridge network.
    
    ```shell
    docker network create my-bridge
    docker run --network my-bridge nginx
    ```
    
2. **Overlay:**
    
    - Enables multi-host communication.
    - Used in **Docker Swarm** for distributed applications and microservices.
    - Facilitates service discovery and load balancing.
3. **Host:**
    
    - Bypasses Docker's network isolation; container shares the host's network stack.
    - Highest performance but exposes container ports directly on the host.
4. **Macvlan:**
    
    - Assigns a unique MAC address to each container, making them appear as physical devices.
    - Containers get unique IPs on the physical network.
5. **None:**
    
    - Disables networking entirely.
    - Useful for maximum isolation or when networking isn't required.
6. **Plugins:**
    
    - Third-party network drivers for advanced use cases (e.g., specialized networking setups).

---

### **Docker DNS**

Docker provides DNS services for containers to simplify communication:

- Each container gets a DNS resolver (`127.0.0.11`).
- Containers are discoverable by name within the same user-defined network.

#### **Key Points**

1. DNS resolution only works in **user-defined networks**.
2. Default bridge network lacks DNS-based name resolution.
3. Container names must be **unique** within a network.
4. DNS updates dynamically as containers join/leave the network.

---

### **Bridge vs. Overlay Networking**

|Feature|Bridge|Overlay|
|---|---|---|
|**Scope**|Single host|Multi-host|
|**Use Case**|Local development|Distributed applications|
|**Communication**|Containers on the same host|Containers across multiple hosts|
|**Networking**|Simplified|Requires Swarm or orchestration|

---

### **Key Concepts to Remember**

1. Always specify `-p` or `--publish` to expose container ports.
2. Use `127.0.0.1` binding to restrict access to the host machine.
3. For multi-host setups, prefer **overlay networks** with Docker Swarm.
4. Use DNS names in **user-defined networks** for simplicity.

---
#docker