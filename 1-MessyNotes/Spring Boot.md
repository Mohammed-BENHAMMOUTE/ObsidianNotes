[[Books]]
## Rest API's? WHy?
REST is an acronym for _representational state transfer_, which is a somewhat cryptic way of saying that when one application communicates with another, Application A brings its current state with it; it doesn’t expect Application B to maintain state— current and cumulative, process-based information—between communication calls. Application A supplies a representation of its relevant state with each request to Application B. You can easily see why this increases survivability and resilience, because if there is a communication issue or Application B crashes and is restarted, it doesn’t lose the current state of its interactions with Application A; Application A can simply reissue the request and pick up where the two applications left off.

## Repositories in Spring Boot:
we should use the highest level of interfaces possible.
we usually use JpaRepository but we can also use CrudRepository
```java
interface CoffeeRepository extends CrudRepository<Coffee, String> {}
```
