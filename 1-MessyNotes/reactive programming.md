# Programming Paradigms
## Functional Programming Concepts

### Parallelism in Functional Programming
Functional programming makes parallel execution simpler because:
- Pure functions and immutability eliminate traditional synchronization problems with shared data
- Calculations are independent and can be executed simultaneously without interference
- The functional paradigm aligns well with the Map-Reduce model (widely used in Big Data)

**Advantages:**
- Better scalability on multi-core and distributed architectures
- Simpler code compared to approaches based on locks and manual synchronization

**Example of Functional vs Imperative Parallelism:**

Functional approach using streams:
```java
List<Integer> numbers = List.of(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
int sum = numbers.parallelStream()
    .filter(n -> n % 2 == 0)    // Filter even numbers
    .map(n -> n * n)            // Square them
    .map(n -> n + 10)           // Add 10
    .reduce(0, (a, b) -> a + b); // Calculate sum = 294
```

Imperative approach with manual thread management:
```java
List<Integer> numbers = List.of(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
int numberOfThreads = 4;
int sum = 0;
final Object lock = new Object();

// Split list into segments
int segmentSize = (int) Math.ceil((double) numbers.size() / numberOfThreads);
List<List<Integer>> segments = new ArrayList<>();
// ... thread creation and synchronization code
```

### Higher Order Functions (HOF)
**Definition:** Functions that take one or more functions as arguments or return a function as a result.

**Key Characteristics:**
1. Simplifies complex algorithms by making them modular
2. Enables code reuse
3. Allows dynamic function construction
4. Provides concision through lambdas and streams

**Example:**
```java
public static List<Integer> applyFunctionToList(
    List<Integer> numbers, 
    Function<Integer, Integer> func
) {
    return numbers.stream()
        .map(func)
        .toList();
}

// Usage
List<Integer> numbers = List.of(1, 2, 3, 4, 5, 6);
List<Integer> doubled = applyFunctionToList(numbers, n -> n * 2);
List<Integer> squared = applyFunctionToList(numbers, n -> n * n);
```

### Lazy Evaluation
**Definition:** An evaluation strategy where expressions are only evaluated when their value is actually needed.

**Benefits:**
1. Performance: Only calculates what's needed, saving time and resources
2. Expressiveness: Allows definition of unlimited data flows
3. Modularity: Separates data transformation logic without forcing immediate evaluation

**Example:**
```java
Path filePath = Path.of("largefile.txt");
try (Stream<String> lines = Files.lines(filePath)) {
    lines.filter(line -> line.contains("ERROR"))
        .map(String::toUpperCase)
        .limit(5)
        .forEach(System.out::println);
}
```

### Function Composition
**Definition:** Creating new functions by chaining two or more existing functions.

**Example:**
```java
Function<Integer, Integer> multiply3 = x -> x * 3;
Function<Integer, Integer> subtract1 = x -> x - 1;
Function<Double, Integer> divideBy2 = x -> x / 2.0;

Function<Integer, Double> composed = divideBy2.compose(subtract1).compose(multiply3);
double result = composed.apply(5); // ((5 * 3) - 1) / 2 = 7
```

### Monads
**Definition:** An abstraction for chaining computations while encapsulating effects (I/O, errors, state) in a controlled structure.

**Example without Monad:**
```java
String maybeName = readFromExternalAPI();
if (maybeName != null) {
    String upperName = maybeName.toUpperCase();
    System.out.println(upperName);
} else {
    AlertService.sendAlert();
}
```

**Example with Monad (Optional):**
```java
Optional<String> maybeName = Optional.ofNullable(readFromExternalAPI());
maybeName
    .map(String::toUpperCase)
    .ifPresentOrElse(System.out::println, AlertService::sendAlert);
```

### Pattern Matching
**Definition:** A technique for decomposing complex data structures into simpler elements by checking their shapes or values.

**Example:**
```java
interface Shape {}
final class Circle implements Shape { double radius; }
final class Rectangle implements Shape { double length, width; }

Shape shape = new Circle(5);
String result = switch (shape) {
    case Circle c -> "Circle with radius " + c.radius;
    case Rectangle r -> "Rectangle " + r.length + "x" + r.width;
    default -> "Unknown shape";
};
```

### Currying
**Definition:** Transforming a function that takes multiple arguments into a series of functions that each take a single argument.

**Example:**
```java
// Traditional approach
public static double tax(double price, double taxRate) {
    return price + (price * taxRate);
}

// Curried approach
Function<Double, Function<Double, Double>> tax = taxRate -> 
    price -> price + (price * taxRate);

Function<Double, Double> usTax = tax.apply(0.07); // 7%
Function<Double, Double> euTax = tax.apply(0.20); // 20%
```

## Reactive Programming

### Core Concepts
**Definition:** A programming paradigm focused on handling asynchronous data streams and event-based programming.

### The Reactive Manifesto (2014) Pillars:
1. **Reactivity:** Quick and reliable response under varying load
2. **Resilience:** System stays responsive during failures
3. **Elasticity:** System adapts to varying workload
4. **Message-Driven:** Asynchronous message passing for loose coupling

### Observable Pattern
- **Observable:** Source that emits data stream
- **Observer:** Consumer that reacts to emitted data
- **Subscription:** Connection between Observable and Observer

### Flux vs Mono
**Flux:**
- Can emit 0 to N elements
- Used for streams, lists, continuous events
- Good for handling multiple elements

**Mono:**
- Emits 0 or 1 element
- Used for single results
- Simpler for single-element operations

### Error Handling
```java
Flux<String> dataStream = Flux.just("data1", "data2", "data3")
    .map(data -> {
        // Potential exception
        return data;
    })
    .retry(3) // Retry 3 times
    .onErrorResume(e -> Flux.just("fallback1", "fallback2"));
```

### Backpressure
**Definition:** Managing data flow when production rate exceeds consumption rate.

**Example:**
```java
Flux<Integer> dataStream = Flux.range(1, 1000)
    .onBackpressureBuffer(100)
    .onBackpressureDrop(value -> System.out.println("Dropped: " + value))
    .subscribe(value -> {
        // Slow consumption processing
    });
```

## Common Pitfalls to Avoid
1. Don't convert every loop into imperative forEach
2. Avoid excessive parallelism
3. Don't modify shared objects in streams
4. Be careful with method references
5. Prefer immutability

## Exam Tips
- Understand the differences between blocking and non-blocking models
- Know how to implement and use HOFs
- Be able to explain lazy evaluation benefits
- Understand when to use Flux vs Mono
- Know how to handle errors in reactive programming
- Be able to explain backpressure and its importance