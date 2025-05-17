[[java]]
[[Interview Prep]]

virtual threads are built on top of platform threads.

platform threads are executed by a platform thread (Os Thread).

the virtual threads are fist unmounted, waiting for a free platform thread to be mounted on.

when the platform thread is available, the virtual threads start executing withing the platform thread, if in the virtual threads we get a blocking opertion, like IO, the virtual threads are unmounted from the platform thread until the I/O operation finishes.

the join method blocks the thread that calls join until the joined thread finishes executing.


## How can we declare a virtual thread ?

it's simple:
```java
public static void main(String[] args){
	// create a virtual thread and start it:
	Runnable runnable = () => {
		Thread.sleep(4000);
		System.out.println("hello from the runnable Lambda");
	}
	Thread thread  = Thread.ofVirtual().start(runnable);
}
```

# Virtual Threads in Java

Virtual threads were introduced as a feature in Java 19 (as a preview) and became standard in Java 21. They're a key component of Project Loom, which aims to make concurrent programming in Java simpler and more efficient.

## Core Concept

Virtual threads are lightweight threads managed by the JVM rather than directly by the operating system. Unlike platform threads (traditional Java threads) which map 1:1 to OS threads, virtual threads use a "many-to-few" model, where many virtual threads are multiplexed onto a small number of carrier threads (which are platform threads).

## Under the Hood Implementation

### Carrier Threads and Thread Pool

1. **ForkJoinPool as the Default Scheduler**: Virtual threads run on a special ForkJoinPool known as the "scheduler". By default, this pool has approximately the same number of threads as CPU cores.
    
2. **Carrier Threads**: The platform threads in this pool are called "carrier threads" because they carry the execution of virtual threads.
    
3. **Mounting and Unmounting**: When a virtual thread needs to run, it gets "mounted" on a carrier thread. The carrier thread executes the virtual thread's code. When a virtual thread blocks or yields, it gets "unmounted" from the carrier thread.

### Continuation-Based Implementation

Virtual threads use a mechanism similar to continuations:

1. **Continuation Capturing**: The JVM can capture the execution state of a virtual thread (its stack, program counter, etc.) as a "continuation" object.
    
2. **Thread State Storage**: When a virtual thread blocks (e.g., on I/O or when sleeping), the JVM stores its continuation, then unmounts it from the carrier thread.
    
3. **Thread Resumption**: When the blocking operation completes, the virtual thread's continuation is restored, and it gets scheduled to run again on an available carrier thread.
    

### Memory Efficiency

1. **Small Footprint**: Virtual threads use much less memory than platform threads. While a platform thread typically requires ~1MB for its stack, virtual threads have dynamically-sized stacks that start very small (often a few KB).
    
2. **Stack Chunks**: Virtual threads store their stacks as linked lists of small memory segments called "stack chunks." As the stack grows, new chunks are added dynamically.
    
3. **Heap-Based Stacks**: Unlike platform threads with native stacks, virtual thread stacks are allocated on the Java heap, allowing for more efficient memory management.
    

## Pinning and Blocking Behavior

### Synchronized Blocks and Pinning

1. **Thread Pinning**: When a virtual thread enters code that uses the `synchronized` keyword, it gets "pinned" to its carrier thread. This means it cannot be unmounted until it exits all synchronized blocks.
    
2. **Reason for Pinning**: This happens because the JVM implementation of synchronized locks relies on the identity of the native thread. Unmounting a virtual thread inside a synchronized block could break the lock semantics.
    
3. **Performance Impact**: Pinning can reduce the scalability advantage of virtual threads. For this reason, Java recommends using `java.util.concurrent` locks (like ReentrantLock) instead of synchronized blocks with virtual threads.
    

### Blocking Operations

1. **Native Methods**: When a virtual thread calls a blocking native method (like a traditional I/O method), it pins the carrier thread too.
    
2. **Virtual Thread-Aware APIs**: Java's NIO and modern I/O APIs are virtual thread-aware. When a virtual thread uses these APIs, the JVM knows it can unmount the virtual thread without pinning the carrier.
    
3. **Thread.sleep()**: Even simple operations like sleep() are optimized. When a virtual thread sleeps, it gets unmounted from its carrier thread so the carrier can run other virtual threads.
    

## Scheduling and Fairness

1. **FIFO Scheduling**: Virtual threads use a first-in, first-out scheduling policy by default.
    
2. **Yielding**: A virtual thread can voluntarily yield using `Thread.yield()`, allowing other virtual threads to run.
    
3. **Time-Sharing**: Unlike platform threads, virtual threads don't use preemptive time-slicing. A virtual thread runs until it blocks, yields, or completes.
    

## Implementation Specifics

1. **Thread Local Variables**: Each virtual thread has its own independent set of ThreadLocal variables, just like platform threads.
    
2. **Identity Preservation**: Each virtual thread has a unique identity, with its own thread ID, name, and reference.
    
3. **JNI Integration**: Virtual threads are integrated with Java Native Interface (JNI), allowing native code to interact with them similarly to platform threads.
    

## Example of How it Works

Let's consider what happens when a virtual thread makes a network request:

```
1. Virtual thread VT1 starts running on carrier thread CT1
2. VT1 calls Socket.read() to read data from network
3. JVM recognizes this is a blocking operation
4. JVM captures VT1's continuation (stack state, etc.)
5. JVM unmounts VT1 from CT1
6. CT1 is now free to run another virtual thread (e.g., VT2)
7. JVM registers interest in the socket with OS (using non-blocking NIO)
8. When data is available, JVM schedules VT1 to continue
9. VT1 gets mounted on an available carrier thread (maybe CT2)
10. VT1's continuation is restored and it continues execution
```

This mechanism allows a small number of OS threads to efficiently support millions of virtual threads, most of which might be waiting for I/O or other blocking operations at any given time.

## Practical Impact

The true power of virtual threads comes from the ability to use a simple thread-per-task programming model without worrying about the resource constraints of platform threads. You can create thousands or even millions of virtual threads with minimal overhead, allowing for highly concurrent applications without the complexity of asynchronous programming models.