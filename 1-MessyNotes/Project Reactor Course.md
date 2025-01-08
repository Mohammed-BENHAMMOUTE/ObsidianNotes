# Reactive Programming in Java: A Comprehensive Guide

[[Programming pradigmes]]

## Understanding Reactive Programming

Reactive programming represents a paradigm shift in how we handle data and events in modern applications. At its core, reactive programming is a declarative approach that revolves around the processing of asynchronous data streams and event handling. Rather than pulling data, we create systems that react to data as it becomes available.

### Core Concepts

The reactive programming model is built on the Publisher-Subscriber pattern, which has two main components:

1. **Publisher**: The data source that produces information but remains dormant until explicitly activated.
2. **Subscriber**: The consumer that requests and processes the data according to defined rules.

## Project Reactor: Implementation in Java

Project Reactor is Spring's implementation of reactive programming, providing two main types of publishers:

### Flux and Mono

- **Flux**: Handles streams of 0 to N elements
- **Mono**: Represents a single value or empty result (0 or 1 element)

Both implement the Reactive Streams specification but serve different use cases. Here's how they work:

```java
// Creating a Flux
public class ReactiveExample {
    public Flux<String> createSimpleFlux() {
        return Flux.fromIterable(List.of("Hello", "Reactive", "World"))
            .log(); // logging for visibility
    }

    public Mono<String> createSimpleMono() {
        return Mono.just("Single Value");
    }
}
```

### The Subscription Process

Understanding the subscription process is crucial. Here's what happens behind the scenes:

1. **Creation**: Publisher is created but remains inactive
2. **Subscription**: When subscribe() is called:
   - onSubscribe signal is sent
   - Subscription object is created
3. **Data Flow**:
   - onNext signals are sent for each element
   - onComplete signal is sent when done
   - onError signal is sent if an error occurs

Example with detailed logging:

```java
public void demonstrateSubscription() {
    Flux<String> flux = Flux.fromIterable(List.of("Hello", "World"))
        .log()  // Shows all reactive signals
        .map(String::toUpperCase);
    
    flux.subscribe(
        data -> System.out.println("Received: " + data),    // onNext
        error -> System.err.println("Error: " + error),     // onError
        () -> System.out.println("Completed")               // onComplete
    );
}
```

## Advanced Operations

### Transformation Operators

#### Map vs FlatMap

The map and flatMap operators serve different purposes:

```java
// Map: one-to-one transformation
Flux<Integer> lengths = Flux.just("Hello", "World")
    .map(str -> str.length());

// FlatMap: one-to-many transformation
Flux<String> letters = Flux.just("Hello", "World")
    .flatMap(str -> Flux.fromArray(str.split("")))
    .delayElements(Duration.ofMillis(100)); // Introducing artificial delay
```

FlatMap is particularly useful when dealing with asynchronous operations, as it maintains the reactive nature of the stream.

### Combining Streams

#### Concat vs Merge

These operators combine multiple streams but behave differently:

```java
public class StreamCombination {
    public Flux<String> demonstrateConcat() {
        Flux<String> flux1 = Flux.just("1", "2").delayElements(Duration.ofMillis(100));
        Flux<String> flux2 = Flux.just("3", "4").delayElements(Duration.ofMillis(50));
        
        // Concat: Sequential combination
        return Flux.concat(flux1, flux2);  // Will maintain order: 1,2,3,4
    }
    
    public Flux<String> demonstrateMerge() {
        Flux<String> flux1 = Flux.just("1", "2").delayElements(Duration.ofMillis(100));
        Flux<String> flux2 = Flux.just("3", "4").delayElements(Duration.ofMillis(50));
        
        // Merge: Concurrent combination
        return Flux.merge(flux1, flux2);  // Order based on timing: might be 3,4,1,2
    }
}
```

### Error Handling

Project Reactor provides several error handling mechanisms:

```java
public class ErrorHandlingExample {
    public Flux<String> demonstrateErrorHandling() {
        return Flux.just("A", "B", null, "C")
            .map(str -> str.toLowerCase())
            .onErrorReturn("Default")  // Returns a default value on error
            .onErrorResume(error -> Flux.just("Fallback1", "Fallback2"))  // Provides alternative flux
            .doOnError(error -> System.err.println("Error occurred: " + error));  // Side effect
    }
}
```

### Testing Reactive Streams

Project Reactor provides StepVerifier for testing reactive streams:

```java
public class ReactiveTest {
    @Test
    void testFlux() {
        Flux<String> flux = Flux.just("Hello", "World");
        
        StepVerifier.create(flux)
            .expectNext("Hello")
            .expectNext("World")
            .verifyComplete();
    }
    
    @Test
    void testWithVirtualTime() {
        Flux<String> delayedFlux = Flux.just("Hello", "World")
            .delayElements(Duration.ofHours(1));
            
        StepVerifier.withVirtualTime(() -> delayedFlux)
            .expectSubscription()
            .expectNoEvent(Duration.ofHours(1))
            .expectNext("Hello")
            .expectNoEvent(Duration.ofHours(1))
            .expectNext("World")
            .verifyComplete();
    }
}
```

## Backpressure

Backpressure is a crucial concept in reactive programming that helps manage the flow of data between publisher and subscriber. It prevents overwhelming the subscriber with more data than it can handle.

```java
public class BackpressureExample {
    public void demonstrateBackpressure() {
        Flux.range(1, 100)
            .log()
            .onBackpressureBuffer(10) // Buffer up to 10 elements
            .subscribe(new BaseSubscriber<Integer>() {
                @Override
                protected void hookOnSubscribe(Subscription subscription) {
                    request(2); // Request only 2 elements initially
                }
                
                @Override
                protected void hookOnNext(Integer value) {
                    System.out.println("Received: " + value);
                    // Request one more after processing each element
                    request(1);
                }
            });
    }
}
```

This guide covers the fundamental concepts and advanced features of reactive programming in Java. Remember that reactive programming is particularly useful in scenarios involving:
- High-throughput data streaming
- Real-time data processing
- Systems with variable load
- Microservices architecture
- Event-driven applications

## Advanced Operators and Patterns

### Sequential vs Concurrent Operations

#### concatMap vs flatMap

The distinction between concatMap and flatMap is crucial for understanding how to handle nested streams properly:

```java
public class MapOperatorsExample {
    // flatMap processes inner streams concurrently
    public Flux<String> demonstrateFlatMap() {
        return Flux.just("Hello", "Reactive", "World")
            .flatMap(word -> Flux.fromArray(word.split(""))
                .delayElements(Duration.ofMillis(100)))
            .log();
    }

    // concatMap processes inner streams sequentially
    public Flux<String> demonstrateConcatMap() {
        return Flux.just("Hello", "Reactive", "World")
            .concatMap(word -> Flux.fromArray(word.split(""))
                .delayElements(Duration.ofMillis(100)))
            .log();
    }
}
```

The key differences are:
- flatMap: Inner streams are processed in parallel, order is not guaranteed
- concatMap: Inner streams are processed sequentially, maintaining order
- Use flatMap when order doesn't matter and you want maximum throughput
- Use concatMap when maintaining the order of elements is crucial

### Window and Buffer Operations

These operators help manage large streams by grouping elements:

```java
public class GroupingOperationsExample {
    // Buffer collects elements into List<T>
    public Flux<List<Integer>> demonstrateBuffer() {
        return Flux.range(1, 10)
            .buffer(3) // Creates List of 3 elements
            .log();
    }

    // Window creates new Flux for each group
    public Flux<Flux<Integer>> demonstrateWindow() {
        return Flux.range(1, 10)
            .window(3)
            .log();
    }

    // Time-based buffering
    public Flux<List<String>> demonstrateTimeBuffer() {
        return Flux.interval(Duration.ofMillis(100))
            .map(i -> "Event " + i)
            .bufferTimeout(10, Duration.ofSeconds(1))
            .log();
    }
}
```

### Batching and Throttling

Managing the rate of data flow is crucial in reactive applications:

```java
public class ThrottlingExample {
    // Limit rate of emissions
    public Flux<String> demonstrateLimitRate() {
        return Flux.range(1, 100)
            .map(i -> "Event " + i)
            .limitRate(10) // Request 10 elements at a time
            .log();
    }

    // Sample stream at intervals
    public Flux<String> demonstrateSample() {
        return Flux.interval(Duration.ofMillis(100))
            .map(i -> "Event " + i)
            .sample(Duration.ofSeconds(1)) // Take one element per second
            .log();
    }
}
```

### Handling Completion and Empty Streams

Reactor provides several operators for handling edge cases:

```java
public class CompletionHandlingExample {
    public Flux<String> demonstrateDefaultIfEmpty() {
        return Flux.empty()
            .defaultIfEmpty("No data available")
            .log();
    }

    public Flux<String> demonstrateSwitchIfEmpty() {
        return Flux.empty()
            .switchIfEmpty(Flux.just("Fallback1", "Fallback2"))
            .log();
    }

    // Ensure completion within timeout
    public Flux<String> demonstrateTimeout() {
        return Flux.just("A", "B")
            .delayElements(Duration.ofSeconds(2))
            .timeout(Duration.ofSeconds(1))
            .onErrorReturn("Timeout occurred")
            .log();
    }
}
```

### Combining Multiple Streams

Advanced stream combination techniques:

```java
public class StreamCombinationExample {
    // Zip combines elements positionally
    public Flux<String> demonstrateZip() {
        Flux<String> flux1 = Flux.just("A", "B", "C");
        Flux<Integer> flux2 = Flux.just(1, 2, 3);
        
        return Flux.zip(flux1, flux2, 
            (str, num) -> str + num)
            .log();
    }

    // CombineLatest combines most recent elements
    public Flux<String> demonstrateCombineLatest() {
        Flux<String> flux1 = Flux.just("A", "B", "C")
            .delayElements(Duration.ofMillis(100));
        Flux<Integer> flux2 = Flux.just(1, 2, 3)
            .delayElements(Duration.ofMillis(150));
        
        return Flux.combineLatest(flux1, flux2,
            (str, num) -> str + num)
            .log();
    }

    // mergeSequential maintains order while processing concurrently
    public Flux<String> demonstrateMergeSequential() {
        Flux<String> flux1 = Flux.just("1", "2")
            .delayElements(Duration.ofMillis(200));
        Flux<String> flux2 = Flux.just("3", "4")
            .delayElements(Duration.ofMillis(100));

        return Flux.mergeSequential(flux1, flux2)
            .log();
    }
}
```

### Context and Threading

Understanding how Reactor handles context and threading is crucial for advanced usage:

```java
public class ContextAndThreadingExample {
    public Flux<String> demonstrateContext() {
        return Flux.just("Data")
            .transformDeferredContextual((flux, context) ->
                flux.map(data -> data + " - " + 
                    context.get("user")))
            .contextWrite(Context.of("user", "John"))
            .log();
    }

    public Flux<String> demonstratePublishOn() {
        return Flux.just("A", "B", "C")
            .publishOn(Schedulers.boundedElastic())
            .map(this::slowOperation)
            .log();
    }

    public Flux<String> demonstrateSubscribeOn() {
        return Flux.just("A", "B", "C")
            .subscribeOn(Schedulers.boundedElastic())
            .map(this::slowOperation)
            .log();
    }

    private String slowOperation(String value) {
        try {
            Thread.sleep(100);
            return "Processed " + value;
        } catch (InterruptedException e) {
            return "Error processing " + value;
        }
    }
}
```

### Testing Advanced Scenarios

Testing complex reactive flows requires special consideration:

```java
public class AdvancedTestingExample {
    @Test
    void testConcurrentOperations() {
        Flux<String> flux = Flux.just("A", "B", "C")
            .flatMap(value -> Flux.just(value)
                .delayElements(Duration.ofMillis(100)));

        StepVerifier.create(flux)
            .expectSubscription()
            .expectNoEvent(Duration.ofMillis(90))
            .expectNext("A", "B", "C")
            .verifyComplete();
    }

    @Test
    void testContextPropagation() {
        Flux<String> flux = Flux.just("Data")
            .transformDeferredContextual((f, ctx) ->
                f.map(d -> d + ctx.get("key")))
            .contextWrite(Context.of("key", "Value"));

        StepVerifier.create(flux)
            .expectNext("DataValue")
            .verifyComplete();
    }
}
```

### Best Practices and Common Patterns

When working with reactive streams, consider these patterns:

1. Error Recovery Pattern:
```java
public class ErrorRecoveryPattern {
    public Flux<String> demonstrateCircuitBreaker() {
        return Flux.just("A", "B")
            .flatMap(value -> callExternalService(value))
            .timeout(Duration.ofSeconds(1))
            .retry(3)
            .onErrorResume(error -> Flux.just("Fallback"))
            .log();
    }

    private Mono<String> callExternalService(String value) {
        // Simulate external service call
        return Mono.just(value)
            .delayElement(Duration.ofMillis(
                new Random().nextInt(2000)));
    }
}
```

2. Caching Pattern:
```java
public class CachingPattern {
    public Flux<String> demonstrateCache() {
        return Flux.just("Expensive", "Operation")
            .map(this::expensiveOperation)
            .cache(Duration.ofMinutes(10))
            .log();
    }

    private String expensiveOperation(String value) {
        try {
            Thread.sleep(1000);
            return "Processed " + value;
        } catch (InterruptedException e) {
            return "Error";
        }
    }
}
```

Remember that reactive programming is most effective when:
- You need to handle backpressure
- You're dealing with async operations
- You want to compose complex operations
- You need to handle varying load efficiently
- You're building responsive applications

The key to mastering these advanced concepts is understanding how they work together and when to apply each pattern based on your specific use case.

Would you like me to elaborate on any of these concepts or provide more specific examples for any particular scenario?