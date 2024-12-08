[[Design Patterns and Code refactoring]]
[[Structural Patterns]]
## Def:
proxy design pattern is a structural design pattern that lets you provide a <mark style="background: #BBFABBA6;">substitute</mark> or a <mark style="background: #BBFABBA6;">placeholder</mark> of another object.
Proxy controls access/requests to the original business logic and allows you to perform actions before or after the request get's to that object.

![[Pasted image 20241207104813.png]]
### what is the problem that the proxy design pattern solves?
### 1. **Access Control**

- **Problem:** You need to control access to an object, ensuring that only authorized or controlled access is permitted.
- **Solution:** A proxy can act as a gatekeeper, allowing or denying access to the real object based on specific conditions (e.g., authentication, permissions).

### 2. **Resource Management (Lazy Initialization)**

- **Problem:** Some objects are resource-intensive to create (e.g., large objects, network connections, or database connections), but they might not always be needed.
- **Solution:** The proxy delays the creation or initialization of the object until it is actually needed (lazy loading).
### 3. **Performance Optimization (Caching)**

- <mark style="background: #CACFD9A6;">Problem</mark>: Repeated access to an object can be expensive in terms of computation or resource usage.
- <mark style="background: #BBFABBA6;">**Solution</mark>:** The proxy can cache the results of expensive operations and return the cached data instead of recomputing or re-fetching it.
### 5. **Logging, Monitoring, or Auditing**

- <mark style="background: #CACFD9A6;">**Problem</mark>:** You want to log or monitor the interactions with an object without modifying its code.
- <mark style="background: #BBFABBA6;">**Solution</mark>:** The proxy can intercept and log requests or responses, providing a transparent way to monitor the real object's usage.
### 6. **Security Proxies**

- **<mark style="background: #CACFD9A6;">Problem</mark>:** Sensitive data or operations require additional protection.
- **<mark style="background: #BBFABBA6;">Solution</mark>:** The proxy enforces security policies, ensuring that sensitive methods or data are accessed only under appropriate conditions.
## There are 4 types of Proxies:
1. <mark style="background: #BBFABBA6;">Virtual proxy</mark>: manages resources-intensive objects, delaying its creation until needed.
2. <mark style="background: #BBFABBA6;">Remote proxy</mark>: manages communication between remote and local objects.
3. <mark style="background: #BBFABBA6;">Smart proxies</mark>: adds certain functionalities like logging or caching or reference counting.
4. <mark style="background: #BBFABBA6;">Protection Proxies</mark>: Controls access to the real object based on permissions.
### Example Scenarios

- A virtual proxy for loading large images in a graphical editor.
- A remote proxy for accessing services in distributed systems (e.g., REST APIs, gRPC).
- A protection proxy for controlling access to sensitive data in an enterprise application.

### UML:

![[Pasted image 20241207112303.png]]

### How to implement:
1. make the proxy and the business object interchangeable by adding an interface between them if it doesn't already exist, if not possible you can make the proxy class inherit from the business class, this way you will inherit the interface of the super class.
2. create the proxy class, it should have a field for storing a reference to the business class via interface. In general the 
   proxy class manages the whole life-cycle of the business object.
3. Implement the intended purpose of the proxy and then delegate
   the main business workload to business object.




