[[Paradigmes de programmations]]
Created: 2025-01-08

## Why Parallel Programming is Simpler in Functional Programming?

At its core, functional programming makes parallel execution more straightforward and safer because of three key principles:

1. Pure functions eliminate traditional synchronization problems by avoiding shared state
2. Immutability ensures data consistency across parallel operations
3. Natural alignment with the Map-Reduce model, which is fundamental in big data processing

Consider this practical example of the difference between functional and imperative approaches:

### Functional Approach (Simple and Safe)
```java
List<Integer> numbers = List.of(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
int sum = numbers.parallelStream()
    .filter(n -> n % 2 == 0)    // Find even numbers
    .map(n -> n * n)            // Square them
    .map(n -> n + 10)           // Add 10
    .reduce(0, (a, b) -> a + b); // Sum everything
```

This code is naturally parallel because:
- Each operation is independent
- No shared state to worry about
- The runtime can automatically optimize parallel execution

### Imperative Approach (Complex and Error-Prone)
The same operation in imperative style requires explicit thread management, synchronization, and careful handling of shared resources:

```java
List<Integer> numbers = List.of(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
int numberOfThreads = 4;
final Object lock = new Object(); // Synchronization object
int sum = 0; // Shared state - potential problem area

// Complex thread management code...
// Risk of race conditions
// Need for explicit synchronization
// Harder to maintain and reason about
```

## Advanced Functional Programming Concepts

### Higher-Order Functions (HOF)

Higher-order functions are one of the most powerful features of functional programming. They are functions that can:
- Take other functions as parameters
- Return functions as results
- Or both

Example of HOF in practice:
```java
public static List<Integer> applyFunctionToList(
    List<Integer> numbers, 
    Function<Integer, Integer> func
) {
    return numbers.stream()
        .map(func)
        .toList();
}

// Using the HOF
List<Integer> numbers = List.of(1, 2, 3, 4, 5, 6);
List<Integer> doubled = applyFunctionToList(numbers, n -> n * 2);
List<Integer> squared = applyFunctionToList(numbers, n -> n * n);
```

### Lazy Evaluation

Lazy evaluation is a strategy that delays computation until the result is actually needed. Think of it as "just-in-time" computation. Benefits include:

- Performance optimization by avoiding unnecessary calculations
- Ability to work with potentially infinite data structures
- More efficient memory usage

Real-world example:
```java
// Reading a large file lazily
Path filePath = Path.of("largefile.txt");
try (Stream<String> lines = Files.lines(filePath)) {
    lines.filter(line -> line.contains("ERROR"))
        .map(String::toUpperCase)
        .limit(5)  // Only process what we need
        .forEach(System.out::println);
}
```

### Monads

Monads are a design pattern that helps manage and chain operations that involve side effects or complex computations. Think of them as "wrappers" that provide a controlled environment for operations.

Example comparing traditional vs monadic approach:
```java
// Traditional approach - prone to NullPointerException
User user = fetchUserFromDatabase("john");
if (user != null) {
    Friends friends = user.getFriends();
    if (friends != null) {
        Friend firstFriend = friends.getFirst();
        if (firstFriend != null) {
            System.out.println(firstFriend.getName());
        }
    }
}

// Monadic approach using Optional
Optional.ofNullable(fetchUserFromDatabase("john"))
    .map(User::getFriends)
    .map(Friends::getFirst)
    .map(Friend::getName)
    .ifPresent(System.out::println);
```

## Reactive Programming

### The Evolution and Need for Reactive Programming

Historical progression:
1. 1970-1980: Traditional imperative and object-oriented paradigms
2. 2009: Node.js introduces Event Loop model
3. 2014: Reactive Manifesto establishes core principles
4. 2020+: Widespread adoption through frameworks like Spring WebFlux

### The Four Pillars of Reactive Programming

1. **Responsive**: Systems respond quickly and consistently
   - Predictable behavior
   - Consistent response times
   - Reliable error handling

2. **Resilient**: Systems stay responsive even under failure
   - Failures are contained
   - Systems self-heal
   - Users see consistent behavior

3. **Elastic**: Systems stay responsive under varying workload
   - Scales up and down automatically
   - Efficient resource utilization
   - Cost-effective scaling

4. **Message-Driven**: Systems rely on asynchronous message passing
   - Loose coupling
   - Isolation between components
   - Location transparency

### Mono vs Flux Understanding

#### Mono
- Represents a single value or empty result
- Perfect for single HTTP requests
- Used when expecting 0 or 1 result
```java
Mono<User> user = userService.findById(id);
```

#### Flux
- Represents a stream of multiple values
- Ideal for continuous data streams
- Used when expecting 0 to N results
```java
Flux<Message> messages = chatService.getMessages();
```

### Backpressure Management

Backpressure is crucial for handling situations where data is produced faster than it can be consumed. Think of it like a water pipe system with flow control:

```java
Flux<Integer> dataStream = Flux.range(1, 1000)
    .onBackpressureBuffer(100) // Buffer up to 100 items
    .onBackpressureDrop(value -> log.warn("Dropped: {}", value))
    .subscribe(value -> {
        // Slow consumer processing
        Thread.sleep(100);
        process(value);
    });
```

## Common Pitfalls and Best Practices

### Things to Avoid
- Converting every loop to forEach blindly
- Overusing parallel streams without performance testing
- Modifying shared state in streams
- Complex nested method references

### Best Practices
- Use clear method chains
- Test performance before parallelizing
- Prefer immutability
- Handle errors properly in reactive streams

## Links and Related Concepts
- [[Functional Programming Basics]]
- [[Reactive Streams]]
- [[Asynchronous Programming]]
- [[Event-Driven Architecture]]

#programming #reactive #functional #advanced #exam-prep