# Multitasking and Multithreading in Java

## Multitasking vs. Multithreading

### Multitasking

- The computer runs multiple programs (processes) simultaneously
- While the CPU can only execute one task at a time, it rapidly switches between tasks
- These switches happen so quickly that it creates the illusion of running multiple programs simultaneously
- The operating system is responsible for managing these switches between different processes

### Multithreading

- Similar to multitasking, but happens within a single application
- Multiple threads of execution exist within the same process
- Threads share the same memory space and resources

![Thread vs Process](Pasted image 20250313021849.png)

### Modern CPUs and True Parallelism

- Modern CPUs have multiple cores (essentially multiple CPUs on a single chip)
- With multiple cores, we can actually run multiple threads truly in parallel
- A single application can distribute work across different CPU cores for better performance

## Benefits of Multithreading

1. **Better CPU Utilization**
    
    - When a thread is waiting for I/O operations (like file or network operations), other threads can utilize the CPU
    - Prevents CPU idle time during blocking operations
2. **Improved Responsiveness**
    
    - Critical for GUI applications to remain responsive
    - With a single thread, long operations would block the entire application
    - Solution: Delegate long-running tasks to separate threads
    - User interface remains responsive while background work continues
3. **True Parallelism**
    
    - With multiple CPU cores, independent threads can execute simultaneously
    - Can significantly improve performance for suitable tasks

## Concurrency Models

### No Shared State

- Threads operate independently without sharing data
- Each thread has its own separate data
- Eliminates most concurrency issues
- Examples: Actor model, message passing

### Shared State

- Threads access and modify the same data
- Requires synchronization mechanisms to prevent race conditions
- More prone to concurrency issues like deadlocks
- Examples: Using locks, synchronized methods

## Creating and Running Threads in Java

### 1. Using Anonymous Classes

```java
public static void main(String[] args) {
    Runnable runnable = new Runnable() {
        @Override 
        public void run() {
            System.out.println("Running in anonymous Runnable");
        }
    };
    
    Thread thread = new Thread(runnable);
    thread.start();
}
```

### 2. Using Lambda Expressions

```java
public static void main(String[] args) {
    Runnable runnable = () -> {
        System.out.println("Running in lambda Runnable");
    };
    // Runnable is a functional interface with a single abstract method
    
    Thread thread = new Thread(runnable);
    thread.start();
}
```

### 3. Extending the Thread Class

```java
class MyThread extends Thread {
    @Override
    public void run() {
        System.out.println("Running in thread subclass");
    }
}

public static void main(String[] args) {
    MyThread thread = new MyThread();
    thread.start();
}
```

### 4. Implementing the Runnable Interface

```java
class MyRunnable implements Runnable {
    @Override
    public void run() {
        System.out.println("Running in Runnable implementation");
    }
}

public static void main(String[] args) {
    MyRunnable myRunnable = new MyRunnable();
    Thread thread = new Thread(myRunnable);
    thread.start();
}
```

## Thread Management

### Thread Naming

```java
// Get current thread name
String threadName = Thread.currentThread().getName();

// Specify thread name during creation
Thread thread = new Thread(runnable, "CustomThreadName");
```

### Thread Sleep

```java
try {
    // Pause execution for 2000 milliseconds (2 seconds)
    Thread.sleep(2000);
} catch (InterruptedException e) {
    e.printStackTrace();
}
```

### Thread Synchronization

```java
// Only one thread can execute this method at a time
public synchronized void criticalMethod() {
    // Critical section code here
}

// Synchronized block on a specific object
public void anotherMethod() {
    synchronized(this) {
        // Critical section code here
    }
}
```

### Daemon Threads

- The JVM will keep running as long as there are non-daemon threads active
- When only daemon threads remain, the JVM will terminate
- Main thread is a non-daemon thread by default

```java
Thread thread = new Thread(runnable);
thread.setDaemon(true); // Mark as daemon before starting
thread.start();
```

### Waiting for Thread Completion

```java
Thread thread = new Thread(runnable);
thread.start();

try {
    thread.join(); // Main thread waits for this thread to complete
} catch (InterruptedException e) {
    e.printStackTrace();
}

// Optionally specify a timeout
// thread.join(1000); // Wait up to 1000ms for completion
```

## Thread Implementation Details

### OS-Level Threads

- Java threads traditionally map directly to operating system threads
- OS threads are relatively heavyweight (typically use ~1/2 MB of stack space)
- Context switching between OS threads has overhead

### Project Loom

- Introduces lightweight threads (virtual threads) managed by the JVM
- Allows for millions of virtual threads with minimal overhead
- Available in Java 19+ as a preview feature and standard in Java 21
- Virtual threads use significantly less memory than platform threads
- Ideal for I/O-bound applications

```java
// Creating a virtual thread in Java 21
Thread vThread = Thread.startVirtualThread(() -> {
    System.out.println("Running in a virtual thread");
});
```

## Thread Safety Concerns

### Common Issues

- Race conditions: When multiple threads access shared data and try to change it simultaneously
- Deadlocks: When two or more threads are blocked forever, waiting for each other
- Thread starvation: When a thread is unable to gain regular access to shared resources

### Thread Safety Solutions

- Synchronization (using `synchronized` keyword)
- Locks (ReentrantLock, ReadWriteLock)
- Atomic variables (AtomicInteger, AtomicReference, etc.)
- Thread-safe collections (ConcurrentHashMap, CopyOnWriteArrayList)
- Immutable objects

## Thread Pools

- Creating and destroying threads has overhead
- Thread pools maintain a pool of worker threads ready for tasks
- Executors framework provides easy-to-use thread pool implementations

```java
// Create a fixed-size thread pool with 5 threads
ExecutorService executor = Executors.newFixedThreadPool(5);

// Submit tasks to the pool
for (int i = 0; i < 10; i++) {
    final int taskId = i;
    executor.submit(() -> {
        System.out.println("Executing task " + taskId + " in thread " + 
                           Thread.currentThread().getName());
    });
}

// Shutdown the executor when done
executor.shutdown();
```

## CompletableFuture

- Part of Java's concurrency API for asynchronous programming
- Allows for composition of asynchronous operations without callbacks

```java
CompletableFuture<String> future = CompletableFuture.supplyAsync(() -> {
    // Perform some long computation
    return "Result of the computation";
});

future.thenAccept(result -> {
    System.out.println("Got result: " + result);
});
```

## Best Practices

1. Avoid unnecessary synchronization
2. Prefer higher-level concurrency utilities over low-level constructs
3. Minimize shared mutable state
4. Use thread pools instead of creating threads directly
5. Design for thread safety from the beginning
6. Consider using Java's parallel streams for data parallelism