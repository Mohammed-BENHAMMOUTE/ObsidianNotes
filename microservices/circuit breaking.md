[[1. Microservices Architectures]]

for synchronous communication:
circuit breaking has multiple techniques:
1. time out
2. rate limiting 
3. circuit breaking

## what is a circuit breaker?
its design pattern used in microservices architecture to resolve the issue of cascading failures and allow some fault tolerance in the system.

### what are the states of a circuit breaker?

there are three states of circuit breaker:

1. `closed` : the circuit breaker allows all traffic to the downstream service, the downstream service is considered Healthy.
2. `halfOpen`: the downstream service is in the state of recovering, to check if the downstream service is working or not, the circuit breaker in the half open state allows some traffic to the downstream service, the quantity of this traffic is controlled so it does not overwhelm the recovering service.
   the traffic that is redirect is real user traffic, not synthetic traffic, this allows us to have real feedback on our application health, synthetic traffic can be some time miss leading and does not reflect the true state of the downstream service.
   
   the question that arises is how do we transition from the <mark style="background: #FFF3A3A6;">half-open</mark> state to either the <mark style="background: #BBFABBA6;">closed-state</mark> or <mark style="background: #FF5582A6;">open-state</mark> ?
   
   the answer to that is simple, depending on the outcome of the test cases allowed in the half-open state, if no request has failed we transition to the <mark style="background: #BBFABBA6;">closed-state</mark> otherwise, if a one request fails, we go back to the open state.
3. the closed state is the state where everything happens as if there is no circuit breaker, request to the downstream service are routed naturally, though in a circuit breaker pattern, we can usually utilize some functionalities even in the closed state, like Throttling and rate limiting.
		what is the difference between throttling and rate limiting?
		+ first rate limiting is the concept, and throttling is the implementation of that rule or concept, for example "users can only send 15 requests per second" is a rate limiting rule or policy.
		+ on the other hand Throttling is a mechanism that controls traffic to enforce these limits, through either rejecting them, delaying them or queuing the 

## Benefits of circuits breakers?
+ preventing cascading failures, meaning one service failure doesn't bring down other services that rely on it.
+ graceful error handling, by returning fallback responses instead of continuously trying to reach the failing service.
+ When a service fails, the circuit breaker provides a cool down period to allow the downstream service to heal properly, reducing the chance of repeated failure during the recovery time.
  

#### challenges of using circuit breakers in Microservices:

+ extra layer of complexity, devs have to manage its state(open, closed, half-open) and make sure it integrate well with existing services.
+ Properly setting up circuit breaker parameters is tricky, because with the wrong configuration it could lead to either too many failed attempts or unnecessary service disruptions.
+ When multiple services use circuit breakers, understanding the interdependencies and potential points of failure can become complex. This can lead to confusion about which service is causing issues.


#### When to use the circuit breaker pattern?

+ For operations that consume significant resources (like database queries or external API calls), a circuit breaker can help avoid overloading the system when failures occur.
+  In a [microservices architecture](https://www.geeksforgeeks.org/microservices/), where services communicate frequently, a circuit breaker can protect each service from failures in others, maintaining overall system stability.
+ You rely on third-party services or APIs that are known to have failures, using a circuit breaker can help manage those outages without overwhelming your system.

