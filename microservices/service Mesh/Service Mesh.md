+ cloud native applications: is an application where we can deliver rapidly frequently and reliably.


how to make our application agile, global access at scale and reliable, 
we should combine these three : **Microservices** , **Containers**, and **Automation**.

problem: 
it is hard to manage security and monitoring with microservices at scale.

Kubernetes does not solve these problems:

1. Managing Traffic
2. Securing the communication between microservices
3. Observability
4. Resilience

+ first solution before kubernetes: 
client libraries, but they are not recommended becaudse they solve infrastructure problems in the application code. which is bad for maintainability.like Eureka for service discovery.
+ second solution: is the side car containers, we run a side car container that will act as a proxy and handle all the heavy nasty work we used to do in the application layer.

### what is service mesh?
A service mesh is _a software layer that handles all communication between services in applications_. This layer is composed of containerized microservices.


## Problems of Service Mesh
1. **Invasiveness issues**
2. **Consumption of Ressource issues**
3. **Traffic issues**
4. **Security issues**


## Ambient Mesh:
we use ztunnel for level 4 
and we use WayPoint Proxies


look up eBPF:
