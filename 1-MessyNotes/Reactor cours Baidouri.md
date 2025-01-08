[[Programming pradigmes]]
## Core Concepts

### What is Project Reactor?
Project Reactor is a Java library for reactive programming launched by VMware in 2015. It enables creation of non-blocking, asynchronous, and reactive applications. It's fundamental for reactive applications in Spring WebFlux ecosystem.

### Key Benefits
- Concurrent processing with fewer threads
- Better resource utilization
- Non-blocking asynchronous approach
- Excellent for distributed systems and microservices
- Event-driven architecture support

### Mono vs Flux
Mono represents 0 or 1 value, while Flux represents 0 to N values (potentially infinite).

## Stream Types Comparison

### Reactive Streams vs Ordinary Streams
Reactive Streams:
- Asynchronous and non-blocking
- Built-in backpressure management
- Can handle infinite streams
- Optimized for resource management
- Don't block threads

Ordinary Streams:
- Synchronous and blocking
- No backpressure management
- Only handle finite collections
- Less efficient with large data
- Can block threads

## Key Operators

### Transformation Operators
1. map:
   - Transforms each value in stream
   - Simple one-to-one transformation
   - Example: `mono.map(value -> value.toUpperCase())`

2. flatMap:
   - Transforms and flattens nested streams
   - Used for async operations
   - Better for complex transformations
   - Example: Used when dealing with nested collections

### Combination Operators
1. zip: Combines multiple streams into tuples
2. merge: Combines streams in interleaved order
3. concat: Combines streams sequentially

### Error Handling
1. onErrorReturn: Provides fallback value
2. onErrorResume: Provides fallback stream
3. retry: Retries failed operations

## Backpressure Handling
Three main strategies:
1. onBackpressureBuffer: Buffers elements
2. onBackpressureDrop: Drops excess elements
3. onBackpressureLatest: Keeps only latest element

## Spring WebFlux Integration

### Key Components
1. @RestController: Handles HTTP requests reactively
2. WebFluxConfigurer: Customizes configuration
3. WebClient: Reactive HTTP client

### Example Structure
```java
@RestController
public class UserController {
    @GetMapping("/users/{id}")
    public Mono<User> getUserById(@PathVariable Long id) {
        return userService.findById(id);
    }

    @GetMapping("/users")
    public Flux<User> getAllUsers() {
        return userService.findAll();
    }
}
```

## Debugging Tools
1. doOnNext(): Observe elements without modification
2. doOnError(): Capture and handle errors
3. doOnTerminate(): Execute action at stream end
4. log(): Detailed event tracking

## Testing
Use StepVerifier for testing reactive streams:
```java
StepVerifier.create(mono)
    .expectNext("expectedValue")
    .expectComplete()
    .verify();
```

## Key Points for Exam
1. Understand difference between Mono and Flux usage
2. Know when to use map vs flatMap
3. Understand backpressure concepts
4. Know error handling strategies
5. Understand basic WebFlux structure
6. Be familiar with combination operators
7. Know debugging approaches

Remember: Focus on understanding when to use each operator rather than memorizing syntax. The exam will likely test your understanding of concepts more than specific implementation details.