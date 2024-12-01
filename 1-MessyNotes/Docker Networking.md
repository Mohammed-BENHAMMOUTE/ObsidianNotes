[[Docker]]
when creating a container each one has its own network namespace. if we create two container they do no have the same and can't communicate with each other, for example if we create a redis server, and we want to use the redis cli without using the exec redis cli ,we can create a new container and have the same network namespace as the redis server:

```shell
docker run -d --name redis --example/redis --bind 127.0.0.1
docker run -it --network container:redis redis redis-cli -h 127.0.0.1
```

container
the default network in docker uses the virtual bridge. 
the base ip address is 172.17.0.0/16.

a bridge is like a virtual network  switch that docker creates on your docker environment, it serves several purposes:
1. Internal network creation:
	+ creates an isolated docker network where your containers can communicate.
	+ acts as the DHCP server, automatically assigning new ip adresses to containers.
	+ Usually operates in the 172.17.0.0/16 subnet by default.
2. Container communication:
```
Container A (172.17.0.2) <--> docker0 bridge <--> Container B (172.17.0.3)
```
3. Nat Functionality:
   + Performs network address Translation between containers and the outside world.
   + Allows containers to access external network.
   + Maps the containers ports to the host ports when you specify them with the -p flag.
## NAT (network access translation):
Think of it like a receptionist at a large office building:
```shell 
Internet <---> NAT (Router/Gateway) <---> Private Network
                    |
        Translates addresses and tracks connections
```
inside the private networks use the local private  ip address, when these devices want to talk to the internet they cant use the the private ip address directly so what NAT does is two things:
1. Replaces the private source IP with a public IP.
2. Keeps track of which internal device made which request.
here is a simple example:

```text 
Your Computer (192.168.1.5) wants to access google.com
↓
NAT changes the source IP to your public IP (say 74.125.x.x)
↓
When google.com replies, NAT remembers to send it back to 192.168.1.5
```


when you publish a container port is insecure and you will be publishing them to the outside world, 
if you want to only allow connections from the local host you can do the following command:
```shell
docker run -p 127.0.0.1:8080:80 -p '[::1]:8080:80'
```
the first publish is for the ipv4 and the secodn is for the ipv6.
## The difference between Bridge and Overlay Docker networks:
1. **Docker Bridge**:
   + works on a single host/machine.
   + used for container to container communication in the same host.
   + creates a container network where containers can communicates using the containers names.
   + good for local development and single-host deployment.
example:
```shell
# Create bridge network
docker network create my-bridge

# Run container in bridge network
docker run --network my-bridge nginx
```

2. Docker Overlay:
- Designed for multi-host communication
- Enables container-to-container communication across multiple Docker hosts
- Used in Docker Swarm mode for service discovery and load balancing
- Containers can communicate across different physical or virtual machines
- Essential for distributed applications and microservices.

3. Host:
- Removes network isolation between the container and the Docker host
- Container uses the host's network stack directly
- No network namespace separation
- Highest possible network performance
- Container ports are directly exposed on the host's network interface.
4. Macvlan:
- Assigns a MAC address to each container
- Containers appear as physical devices on your network
- Provides direct access to the physical network
- Containers can have their own unique IP addresses on your network.
5. None:
- Completely disables networking for a container
- Container has only loopback interface (localhost)
- Maximum network isolation
- No external connectivity.
6. PLugins:
Use plugins that give out of the box features.

Docker DNS:
- Each container gets a DNS resolver (127.0.0.11).
- Default hostname is container name.
- Automatic service discovery within network.
- Round-robin DNS for services.

Key Points to Remember:
1. DNS resolution only works in user-defined networks
2. Default bridge network doesn't support automatic DNS resolution
3. Container names must be unique in a network
4. DNS updates are automatic when containers join/leave network