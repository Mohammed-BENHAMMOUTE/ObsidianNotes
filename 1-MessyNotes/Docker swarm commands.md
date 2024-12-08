[[Docker]]
[[Docker Swarm]]

---

### **1. Swarm Initialization and Management**

- **Initialize a Swarm cluster:**
    
    ```bash
    docker swarm init
    ```
    
- **Join a Swarm as a manager/worker:**
    
    ```bash
    docker swarm join --token <TOKEN> <MANAGER-IP>:<PORT>
    ```
    
- **Leave a Swarm:**
    
    ```bash
    docker swarm leave
    ```
    
    _(Use `--force` to leave as a manager.)_
    
- **Inspect the current Swarm configuration:**
    
    ```bash
    docker swarm inspect
    ```
    
- **Update Swarm settings:**
    
    ```bash
    docker swarm update
    ```
    

---

### **2. Node Management**

- **View all nodes in the Swarm:**
    
    ```bash
    docker node ls
    ```
    
- **Promote a worker to a manager:**
    
    ```bash
    docker node promote <NODE-ID>
    ```
    
- **Demote a manager to a worker:**
    
    ```bash
    docker node demote <NODE-ID>
    ```
    
- **Remove a node from the Swarm:**
    
    ```bash
    docker node rm <NODE-ID>
    ```
    
- **Inspect a specific node:**
    
    ```bash
    docker node inspect <NODE-ID>
    ```
    
- **Update node availability:**
    
    ```bash
    docker node update --availability <active|pause|drain> <NODE-ID>
    ```
    

---

### **3. Service Management**

- **Create a service:**
    
    ```bash
    docker service create --name <SERVICE-NAME> <IMAGE>
    ```
    
- **List all services:**
    
    ```bash
    docker service ls
    ```
    
- **Inspect a service:**
    
    ```bash
    docker service inspect <SERVICE-NAME>
    ```
    
- **Scale a service:**
    
    ```bash
    docker service scale <SERVICE-NAME>=<NUMBER-OF-TASKS>
    ```
    
- **Update a service:**
    
    ```bash
    docker service update <SERVICE-NAME>
    ```
    
- **Remove a service:**
    
    ```bash
    docker service rm <SERVICE-NAME>
    ```
    

---

### **4. Task Management**

- **List all tasks in a service:**
    
    ```bash
    docker service ps <SERVICE-NAME>
    ```
    
- **Inspect a task:**
    
    ```bash
    docker inspect <TASK-ID>
    ```
    

---

### **5. Stack Management**

- **Deploy a stack using a Compose file:**
    
    ```bash
    docker stack deploy -c <COMPOSE-FILE> <STACK-NAME>
    ```
    
- **List all stacks:**
    
    ```bash
    docker stack ls
    ```
    
- **View services in a stack:**
    
    ```bash
    docker stack services <STACK-NAME>
    ```
    
- **View tasks in a stack:**
    
    ```bash
    docker stack ps <STACK-NAME>
    ```
    
- **Remove a stack:**
    
    ```bash
    docker stack rm <STACK-NAME>
    ```
    

---

### **6. Monitoring and Troubleshooting**

- **Monitor the Swarm:**
    
    ```bash
    docker node ls
    docker service ls
    ```
    
- **Check service logs:**
    
    ```bash
    docker service logs <SERVICE-NAME>
    ```
    
- **View node resource usage:**
    
    ```bash
    docker stats
    ```
    

---

### **7. Miscellaneous Commands**

- **Display join-token for manager/worker nodes:**
    
    ```bash
    docker swarm join-token manager
    docker swarm join-token worker
    ```
    
- **Rotate join-tokens:**
    
    ```bash
    docker swarm join-token --rotate manager
    docker swarm join-token --rotate worker
    ```
    

---

This set of commands should cover most of your needs for managing Docker Swarm efficiently! Let me know if you need clarification on any of them.