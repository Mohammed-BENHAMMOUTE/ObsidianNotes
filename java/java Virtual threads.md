# Understanding Java Virtual Threads: A Deep Dive Tutorial

## 1. Introduction to Java Virtual Threads

Virtual threads represent a significant evolution in Java's concurrency model, introduced to streamline the development and maintenance of high-throughput concurrent applications.1 These lightweight threads are managed by the Java Virtual Machine (JVM) and stand as instances of the familiar java.lang.Thread class.1 Unlike traditional platform threads, virtual threads do not maintain a direct, one-to-one relationship with operating system (OS) threads.1 This fundamental difference underpins their efficiency and scalability. The primary objective behind their introduction is to alleviate the complexities associated with managing concurrency in modern applications, particularly those dealing with a large volume of concurrent operations.

The necessity for virtual threads arises from the inherent limitations of platform threads in high-concurrency scenarios.3 Platform threads are resource-intensive, consuming substantial memory and OS resources, which consequently restricts the total number of concurrent threads an application can effectively manage.3 This limitation becomes especially pronounced in applications designed to handle numerous concurrent requests, a common characteristic of I/O-bound workloads.2 The traditional "thread-per-request" model, while offering simplicity in programming, encounters practical scalability barriers when implemented with platform threads at elevated concurrency levels due to the depletion of system resources.2 The core challenge lies in the inefficient utilization of OS threads by platform threads, particularly when these threads are in a blocked state awaiting I/O operations, leading to underutilized CPU capacity despite substantial processing demands.2

Virtual threads offer several key advantages that address these challenges.1 They provide enhanced scalability and throughput, particularly for applications that are heavily reliant on I/O operations.1 By allowing developers to employ familiar synchronous programming paradigms, they simplify the creation of concurrent applications.8 Moreover, virtual threads contribute to a more efficient use of system resources by enabling a large number of concurrent operations to be managed by a smaller pool of underlying OS threads.2 Their lightweight nature also diminishes the likelihood of encountering OutOfMemoryError exceptions, which can occur when attempting to create a large number of platform threads.3 Fundamentally, virtual threads aim to deliver the scalability benefits often associated with asynchronous programming models while retaining a more direct and intuitive thread-based programming approach for I/O-intensive tasks.2

## 2. The Landscape of Traditional Java Concurrency: Platform Threads

Platform threads in Java serve as the traditional mechanism for achieving concurrency, acting as a thin layer over the operating system's native thread implementation.2 Each platform thread establishes a direct, one-to-one correspondence with an OS thread, meaning that the creation and management of these threads are ultimately the responsibility of the underlying operating system.9 The OS scheduler determines when and for how long each platform thread gets to execute on the system's processors.1 A notable characteristic of platform threads is the significant amount of memory they are allocated, typically several megabytes, to accommodate their stack, which stores the execution call frames.3 This inherent resource intensity makes the creation and management of a large number of platform threads a costly operation, both in terms of memory consumption and the overhead of context switching managed by the OS.3

These characteristics impose limitations when dealing with scenarios requiring high concurrency.3 The total number of platform threads that can be concurrently active is constrained by the availability of OS resources, such as memory and the number of thread handles the OS can support.3 In applications that anticipate a large volume of concurrent users or tasks, the pool of available platform threads can become quickly exhausted. This saturation leads to a bottleneck where new requests or tasks are forced to wait until an existing thread becomes free, resulting in blocked operations and a decrease in overall application throughput.2 Furthermore, when platform threads encounter blocking I/O operations, they typically remain in a blocked state, consuming OS resources without actively performing any computation.2 This can lead to a situation where a significant portion of the system's resources are tied up by idle threads, preventing other pending tasks from being executed and contributing to lower CPU utilization. The overhead associated with context switching between a large number of platform threads, a process managed by the OS, can also become a performance bottleneck, especially when the time spent switching between threads outweighs the actual execution time of the tasks.9

In response to the scalability challenges posed by platform threads, alternative concurrency models such as asynchronous and reactive programming have emerged.2 These models often rely on non-blocking I/O operations and event-driven architectures to handle a large number of concurrent tasks with a smaller number of underlying threads.2 While effective in achieving high concurrency, these approaches can introduce their own set of complexities, including intricate callback structures (often referred to as "callback hell"), increased difficulty in debugging, and a steeper learning curve for developers accustomed to traditional thread-based programming.2 Virtual threads present a potential simplification in this landscape by offering a more direct, thread-based programming style that can achieve similar scalability benefits as asynchronous models for I/O-bound workloads without the added complexity.2

## 3. Unveiling Virtual Threads: A Lightweight Approach

The core innovation of virtual threads lies in their implementation of a many-to-few (M:N) threading model.2 In this model, a multitude of virtual threads are multiplexed onto a smaller, more manageable number of platform threads, which are referred to as carrier threads.2 This decoupling from the direct one-to-one mapping of platform threads to OS threads allows the JVM to efficiently manage a significantly larger number of concurrent tasks within the same application process.2 This architectural choice is fundamental to the lightweight nature and enhanced scalability that virtual threads provide.

A key characteristic that distinguishes virtual threads is their significantly reduced memory footprint compared to platform threads.3 While platform threads typically require megabytes of memory for their stacks, a virtual thread can start with a memory allocation as small as a few hundred bytes.3 This is achieved because the stack frames of virtual threads are not stored in contiguous, OS-allocated memory blocks but rather in the Java heap.3 The JVM can dynamically adjust the size of these heap-based stacks as needed, allowing them to grow and shrink based on the depth of the call stack at any given time.3 This efficient memory management enables the creation of potentially millions of virtual threads within a single JVM instance without exhausting system resources, a stark contrast to the limitations faced with platform threads.2

The JVM assumes responsibility for the scheduling and management of virtual threads onto the underlying carrier threads.1 This scheduling mechanism operates differently from the OS-level scheduling of platform threads.1 A crucial aspect of this management is how virtual threads handle blocking I/O operations.1 When a virtual thread initiates a blocking I/O operation, instead of the underlying OS thread becoming blocked and idle, the JVM can suspend the virtual thread, effectively unmounting it from its current carrier thread.1 This releases the carrier thread, making it available for the JVM to mount and execute other virtual threads that are ready to run.1 Once the blocking I/O operation completes, the suspended virtual thread is then remounted onto an available carrier thread and its execution resumes from where it left off.1 This ability of the JVM to orchestrate the suspension and resumption of virtual threads during blocking operations is fundamental to achieving efficient resource utilization and high throughput in applications with significant I/O activity.1

  
  
  
  

|   |   |   |
|---|---|---|
|Feature|Platform Threads|Virtual Threads|
|Creation Cost|High (OS-level resource allocation)|Low (JVM-managed object creation)|
|Memory Footprint|Large (Megabytes per thread)|Small (Hundreds of bytes initially)|
|Lifecycle|Tied to OS thread for entire duration|Unmounts from carrier thread during blocking I/O|
|Scalability|Limited by OS resources (tens of thousands)|High (Millions possible)|
|Resource Usage|Can lead to idle OS threads during I/O wait|Efficiently utilizes carrier threads|
|Scheduling|Managed by the Operating System|Managed by the Java Virtual Machine|
|Best Suited For|CPU-bound, long-running tasks|I/O-bound, high-concurrency tasks|

## 4. Dissecting the Mechanics: Carrier Threads and Continuations

Carrier threads serve as the essential execution context for virtual threads.1 These are standard platform threads that the JVM utilizes to run the code associated with virtual threads.1 When the JVM scheduler determines that a virtual thread is ready to execute, it "mounts" or assigns that virtual thread to one of the available carrier threads.1 From the operating system's perspective, it is only aware of and schedules these carrier threads in the same way it manages any other platform thread.1 A key aspect of this architecture is that a relatively small pool of carrier threads can efficiently support a very large number of virtual threads.2 This is because when a virtual thread encounters a blocking operation, it can be unmounted from its carrier, freeing the carrier thread to be used by another virtual thread.1

Continuations are a low-level programming concept that provides the foundational mechanism for the suspend and resume capabilities of virtual threads.16 A continuation can be thought of as a snapshot of a program's execution state at a particular point in time, allowing the execution to be paused and later resumed from that exact point.17 When a virtual thread is created, the JVM also instantiates a corresponding Continuation object that encapsulates the virtual thread's current execution state.17 This Continuation object plays a critical role in the mount and unmount process. When a virtual thread is about to be unmounted from a carrier thread due to an impending blocking operation, its current execution state, including the call stack and local variables, is saved within its associated Continuation object.17 Upon the completion of the blocking operation, the virtual thread can then be resumed, potentially on a different carrier thread, by restoring its execution state from the Continuation object.17 This mechanism allows for a fine-grained control over the execution flow of virtual threads, enabling the JVM to manage concurrency at a higher level of abstraction than what is possible with traditional OS threads.17

The process of mount and unmount is central to the efficiency of virtual threads.1 When a virtual thread begins its execution, it is mounted onto a carrier thread, allowing its code to be executed by the underlying OS.1 If the virtual thread then performs a blocking I/O operation, the JVM steps in to unmount the virtual thread from the carrier thread.1 The complete state of the virtual thread at this point is saved in the heap, primarily within its Continuation object.8 The carrier thread, now freed from the blocked virtual thread, becomes available for the JVM to mount and execute other virtual threads that are ready to proceed.1 Once the blocking operation that caused the suspension of the virtual thread completes, the JVM scheduler will remount the virtual thread onto an available carrier thread.1 The execution of the virtual thread then resumes from the saved state, effectively continuing from the point where it was suspended.1 This efficient and rapid switching between numerous virtual threads on a limited number of carrier threads is the key to the high throughput achieved by virtual threads, particularly for workloads that involve significant amounts of blocking I/O.1

## 5. The Advantages of Embracing Virtual Threads

The introduction of virtual threads brings forth several significant advantages for Java developers, particularly in the realm of building highly concurrent and scalable applications. One of the most notable benefits is the enhanced concurrency and scalability they offer.2 Due to their lightweight nature, applications can handle a far greater number of concurrent tasks compared to what is feasible with traditional platform threads.2 This capability is particularly valuable for applications that experience high levels of concurrency, such as web servers designed to handle numerous simultaneous client requests and microservices that may need to manage many concurrent operations.2 The ability to create and manage potentially millions of virtual threads allows applications to scale more effectively to meet increasing demands without being constrained by the limitations of OS thread resources.2

Virtual threads also lead to improved throughput, especially for applications that are predominantly I/O-bound.1 These are tasks where a significant portion of the execution time is spent waiting for I/O operations, such as network requests, database queries, or file system interactions, to complete.1 By employing the unmount mechanism during blocking I/O, virtual threads prevent the underlying carrier threads from becoming idle while waiting.1 This allows the carrier threads to be utilized by other virtual threads that are ready to execute, thus increasing the overall throughput of the application.1 This efficient resource utilization in I/O-bound scenarios results in a higher volume of work being processed within a given timeframe compared to platform threads, where a large number of threads might remain blocked and inactive.2

Furthermore, virtual threads offer a simplified concurrent programming model.2 Developers can write concurrent code using the familiar thread-per-request style, utilizing standard blocking I/O APIs, which are generally more straightforward to understand, write, and debug.2 This can potentially reduce the need to resort to more complex asynchronous or reactive programming models that were often adopted to achieve scalability when working with platform threads.2 By bridging the gap between the simplicity of traditional threading and the scalability demands of modern applications, virtual threads can lead to more efficient development processes and easier maintenance of concurrent systems.2

Finally, virtual threads contribute to a more efficient utilization of system resources.2 Their lightweight nature, coupled with the JVM's efficient management of their execution on carrier threads, allows for better exploitation of the underlying hardware, especially in applications with a high degree of concurrency.2 By multiplexing a large number of virtual threads onto a smaller number of carrier threads, the JVM can keep the CPU engaged without the substantial overhead associated with managing a large pool of OS threads.2 This approach ensures that the underlying platform threads are actively processing tasks rather than remaining idle while waiting for I/O operations initiated by virtual threads to complete.2

## 6. Navigating the Limitations and Considerations

While virtual threads offer numerous advantages, it is important to acknowledge their limitations and considerations for effective use. One key point is that virtual threads are not ideally suited for CPU-bound tasks.1 They do not inherently make code execute faster; their primary strength lies in enhancing scalability and throughput, not in reducing the latency of individual, computationally intensive operations.1 For tasks that involve long-running CPU-intensive computations without significant blocking, traditional platform threads might still be the more appropriate choice as they are directly mapped to OS threads and can fully utilize the available processor cores.1 In such scenarios, the overhead of managing virtual threads might not be offset by any significant benefits, and could even introduce a slight performance penalty.7

Another crucial consideration is the phenomenon of thread pinning.1 In certain situations, a virtual thread can become "pinned" to its underlying carrier platform thread, preventing it from being unmounted even when it encounters a blocking operation.1 Common causes of pinning include executing code within a synchronized block or method, or when the virtual thread calls a native method or interacts with foreign functions.1 If pinning occurs frequently or for extended durations, it can diminish the scalability advantages of virtual threads because the carrier thread remains occupied by the pinned virtual thread, unable to serve other virtual threads.1 This is a significant concern, especially for applications that make extensive use of synchronized constructs or rely on native code, as it can limit the efficiency gains expected from using virtual threads.1

The usage of ThreadLocal variables also warrants careful consideration when working with virtual threads.1 While virtual threads do support thread-local variables, their per-thread nature can lead to increased memory consumption in the Java heap if a very large number of virtual threads are created and each uses thread-local storage.1 Developers should therefore evaluate their reliance on ThreadLocal variables in high-concurrency scenarios involving virtual threads.1 Alternatives like Scoped Values, introduced in later Java versions, might offer a more memory-efficient way to share immutable, context-specific data across virtual threads.11 This highlights the need to re-examine traditional patterns when adopting virtual threads to ensure optimal resource utilization.1

Finally, while virtual threads are designed to be largely compatible with existing Java code, there might be instances where certain libraries or frameworks, especially those that make assumptions based on the characteristics of platform threads, may not interact optimally with virtual threads.23 For example, libraries that depend on thread identity or OS-level thread priorities might exhibit unexpected behavior when used with virtual threads.23 Additionally, monitoring and debugging tools might require updates to fully support and provide insights into applications running with a massive number of virtual threads.13 Therefore, developers should be aware of potential compatibility issues, particularly with older or less actively maintained libraries, and should conduct thorough testing to ensure their applications function as expected with virtual threads.23

## 7. Practical Guide: Creating and Managing Virtual Threads

Creating and managing virtual threads in Java is designed to be straightforward, building upon the familiar java.lang.Thread API. One of the primary ways to create a virtual thread is by using the factory methods provided by the Thread class, specifically through Thread.ofVirtual().1 For instance, to create and immediately start a virtual thread that executes a simple task, you can use the following code: Thread.ofVirtual().start(() -> System.out.println("Hello from a virtual thread!"));.1 This approach mirrors the way platform threads are created and started, making the transition relatively seamless for developers. Furthermore, it is possible to create a virtual thread in an unstarted state using Thread.ofVirtual().unstarted(Runnable task). This allows for further configuration of the thread before its execution is initiated by calling the thread.start() method.1 This offers more control over the thread's lifecycle, such as setting properties or adding it to a thread group before it begins execution.

The Executors class provides another convenient mechanism for managing virtual threads through the newVirtualThreadPerTaskExecutor() method.1 This method returns an ExecutorService that is specifically designed to create a new virtual thread for each task submitted to it.1 A typical usage pattern looks like this:

  

Java

  
  

try (ExecutorService executor = Executors.newVirtualThreadPerTaskExecutor()) {  
    executor.submit(() -> System.out.println("Task running in a virtual thread"));  
}  
  

This approach is highly recommended for managing the execution of multiple virtual threads, particularly in server-like applications where numerous independent tasks need to be processed concurrently.1 The try-with-resources statement ensures that the ExecutorService is properly shut down after use, managing the lifecycle of the underlying resources.

For developers who require more control over the creation of virtual threads, the Thread.Builder interface offers a way to configure various properties, such as setting the name of the thread or associating it with a specific thread group.1 An example of using Thread.Builder to create and start a virtual thread with a custom name is as follows:

  

Java

  
  

Thread.Builder builder = Thread.ofVirtual().name("my-virtual-thread-", 0);  
Thread virtualThread = builder.start(() -> System.out.println("Running with custom name"));  
virtualThread.join();  
  

The join() method is used here to wait for the virtual thread to complete its execution before the main thread proceeds.1 This level of control can be beneficial for monitoring and organizing virtual threads, especially in more complex applications.

Similar to platform threads, virtual threads have a defined lifecycle.10 The join() method can be used to wait for a virtual thread to finish its task, ensuring that subsequent operations are performed only after the virtual thread has completed.1 When using Executors.newVirtualThreadPerTaskExecutor(), virtual threads are typically designed to be short-lived, created and discarded as needed for each submitted task.7 This transient nature simplifies their management compared to the often long-lived platform threads in traditional thread pools.

Consider a simple client-server application as a conceptual example.1 A server could utilize a ServerSocket to listen for incoming client connections. Upon receiving a new connection, the server can then spawn a new virtual thread to handle the communication with that specific client.1 This approach allows the server to manage a large number of concurrent client connections without being limited by the number of platform threads available. The lightweight nature of virtual threads makes the "thread-per-request" model a viable and scalable solution for high-concurrency server applications.1

## 8. Real-World Applications: Common Use Cases

Virtual threads are particularly well-suited for a variety of real-world applications, especially those that demand high concurrency and efficient resource management. One prominent use case is in web servers that need to handle a large volume of simultaneous HTTP requests.1 By assigning each incoming request to a dedicated virtual thread, the server can manage these connections more effectively, simplifying the programming model and significantly improving scalability compared to traditional thread pool management.1 This approach reduces the overhead and complexity associated with managing large pools of platform threads, allowing the server to handle more concurrent users with the same hardware resources.12

Microservices, which often involve a significant amount of I/O operations such as making network calls to other services or querying databases, can also greatly benefit from virtual threads.12 Virtual threads can handle these I/O-bound operations more efficiently by unmounting from their carrier threads while waiting for responses. This allows the underlying platform threads to be utilized by other virtual threads, improving the overall responsiveness and throughput of the microservice.12 The ability to manage concurrency at a finer-grained level makes virtual threads an excellent choice for the distributed nature of microservice architectures.

Applications that process large datasets concurrently can also leverage the scalability of virtual threads.12 By dividing the data processing task into smaller, independent units and assigning each unit to a virtual thread, the application can achieve a higher degree of parallelism.12 This can lead to significant improvements in the overall processing time for data-intensive workloads. Virtual threads offer a simpler way to achieve this parallelism compared to managing complex thread pools or using other concurrency utilities, making it easier for developers to write efficient data processing applications.12

Any application that involves waiting for external resources, such as databases, network APIs, or message queues, is a potential candidate for using virtual threads.1 In these scenarios, threads often spend a considerable amount of time in a blocked state. Virtual threads can efficiently handle these waiting periods without tying up the underlying OS threads, leading to better resource utilization and improved application performance.1 This makes them particularly advantageous in building responsive and scalable applications that rely on interacting with external systems.

## 9. Best Practices for Effective Virtual Thread Utilization

To maximize the benefits of virtual threads, several best practices should be considered. One key recommendation is to embrace blocking I/O operations.1 Virtual threads are designed to work efficiently with familiar blocking I/O APIs, allowing developers to write more straightforward code without the need for complex asynchronous patterns for many I/O-bound tasks.1

However, it is advisable to avoid using synchronized blocks or methods for long-duration blocking operations.1 Such usage can lead to thread pinning, which negates the primary advantage of virtual threads by preventing them from unmounting during blocking, thus tying up the underlying carrier thread.1 For critical sections that might involve potentially long I/O operations, consider using java.util.concurrent.locks.ReentrantLock as an alternative, as it provides more flexibility in how blocking is managed with virtual threads.1

Be mindful of excessive usage of ThreadLocal variables.1 While they function with virtual threads, the potential for creating a very large number of virtual threads means that the memory overhead associated with each ThreadLocal instance can accumulate. In high-concurrency scenarios, it might be beneficial to explore alternative ways of managing thread-specific data, such as using Scoped Values if appropriate for sharing immutable data.1

It is also important to monitor for thread pinning.1 Tools like JDK Flight Recorder (JFR) can be used to detect VirtualThreadPinned events, which indicate when a virtual thread remains pinned for longer than a specified threshold.1 Analyzing these events can help identify the causes of pinning, allowing developers to adjust their code to minimize it and ensure that virtual threads are providing the expected scalability benefits.1

Avoid using traditional thread pools to manage virtual threads.12 Virtual threads are designed to be lightweight and can be created and discarded as needed with minimal overhead. Using a traditional thread pool can introduce unnecessary complexity and might not leverage the full potential of virtual threads. The Executors.newVirtualThreadPerTaskExecutor() method is the recommended approach for managing the execution of tasks using virtual threads.1

Finally, consider exploring and utilizing structured concurrency features as they become more mature and widely available.3 Structured concurrency aims to simplify the management of groups of related concurrent tasks, providing better error handling and lifecycle management, which can complement the use of virtual threads in complex applications.3

## 10. Conclusion: The Future of Concurrent Programming with Virtual Threads

In summary, virtual threads represent a significant advancement in Java concurrency, offering a lightweight and highly scalable alternative to traditional platform threads, particularly for applications that are I/O-bound. They simplify concurrent programming by enabling a thread-per-request style without the resource limitations inherent in platform threads. Understanding the underlying mechanisms of virtual threads, such as carrier threads and continuations, as well as their limitations, including their suitability for CPU-bound tasks and the potential for pinning, is crucial for their effective utilization.

Virtual threads have the potential to revolutionize how Java developers approach concurrent programming, making it easier to build highly scalable and responsive systems.4 They can reduce the reliance on complex asynchronous and reactive programming models in many scenarios, offering a more intuitive and manageable approach to concurrency.2

As virtual threads and related features like structured concurrency continue to evolve 3, developers should stay informed about these advancements. Future improvements are expected to address current limitations and enhance integration with existing frameworks.11 The introduction of virtual threads marks a pivotal moment in the Java concurrency landscape, offering the promise of building more efficient, scalable, and maintainable applications in the years to come.4

#### Works cited

1. Virtual Threads - Oracle Help Center, accessed April 1, 2025, [https://docs.oracle.com/en/java/javase/21/core/virtual-threads.html](https://docs.oracle.com/en/java/javase/21/core/virtual-threads.html)
    
2. Exploration of Java Virtual Threads and Performance Analysis ..., accessed April 1, 2025, [https://www.alibabacloud.com/blog/exploration-of-java-virtual-threads-and-performance-analysis_601860](https://www.alibabacloud.com/blog/exploration-of-java-virtual-threads-and-performance-analysis_601860)
    
3. The Ultimate Guide to Java Virtual Threads | Rock the JVM, accessed April 1, 2025, [https://rockthejvm.com/articles/the-ultimate-guide-to-java-virtual-threads](https://rockthejvm.com/articles/the-ultimate-guide-to-java-virtual-threads)
    
4. Threads and Virtual Threads: Demystifying the World of Concurrency In Modern Times, accessed April 1, 2025, [https://www.zymr.com/blog/threads-and-virtual-threads-demystifying-the-world-of-concurrency-in-modern-times](https://www.zymr.com/blog/threads-and-virtual-threads-demystifying-the-world-of-concurrency-in-modern-times)
    
5. Exploring the Power of Virtual Threads in Java 21 | by coffee and tips - Medium, accessed April 1, 2025, [https://medium.com/@coffeeandtips.tech/exploring-the-power-of-virtual-threads-in-java-21-29f83c88367c](https://medium.com/@coffeeandtips.tech/exploring-the-power-of-virtual-threads-in-java-21-29f83c88367c)
    
6. JEP 425: Virtual Threads (Preview) - OpenJDK, accessed April 1, 2025, [https://openjdk.org/jeps/425](https://openjdk.org/jeps/425)
    
7. When to use platform Threads over Virtual Threads - Stack Overflow, accessed April 1, 2025, [https://stackoverflow.com/questions/79130627/when-to-use-platform-threads-over-virtual-threads](https://stackoverflow.com/questions/79130627/when-to-use-platform-threads-over-virtual-threads)
    
8. A Comprehensive Guide to Java Virtual Threads (Part 1) | Foojay.io, accessed April 1, 2025, [https://foojay.io/today/unleashing-the-power-of-lightweight-concurrency-a-comprehensive-guide-to-java-virtual-threads-part-1/](https://foojay.io/today/unleashing-the-power-of-lightweight-concurrency-a-comprehensive-guide-to-java-virtual-threads-part-1/)
    
9. Understanding Java Virtual Threads: A Beginner's Guide | by Sachintha Hewawasam, accessed April 1, 2025, [https://sachinthah.medium.com/understanding-java-virtual-threads-a-beginners-guide-7ad4c14304e7](https://sachinthah.medium.com/understanding-java-virtual-threads-a-beginners-guide-7ad4c14304e7)
    
10. Java Virtual Threads — Easy introduction | by Ram Lakshmanan - Medium, accessed April 1, 2025, [https://medium.com/@RamLakshmanan/java-virtual-threads-easy-introduction-44d96b8270f8](https://medium.com/@RamLakshmanan/java-virtual-threads-easy-introduction-44d96b8270f8)
    
11. Virtual Threads in Java – The Future of Scalability - Sky Careers, accessed April 1, 2025, [https://careers.sky.com/cz/blog/virtual-threads-in-java-the-future-of-scalability](https://careers.sky.com/cz/blog/virtual-threads-in-java-the-future-of-scalability)
    
12. Virtual Threads: A Game-Changer for Concurrency - DZone, accessed April 1, 2025, [https://dzone.com/articles/deep-dive-into-java-virtual-threads-a-game-changer](https://dzone.com/articles/deep-dive-into-java-virtual-threads-a-game-changer)
    
13. What exactly makes Java Virtual Threads better - Stack Overflow, accessed April 1, 2025, [https://stackoverflow.com/questions/72116652/what-exactly-makes-java-virtual-threads-better](https://stackoverflow.com/questions/72116652/what-exactly-makes-java-virtual-threads-better)
    
14. How to Optimize Java Performance With Virtual Threads, Reactive Programming, and MongoDB, accessed April 1, 2025, [https://www.mongodb.com/developer/languages/java/virtual-threads-reactive-programming/](https://www.mongodb.com/developer/languages/java/virtual-threads-reactive-programming/)
    
15. Do Java 21 virtual threads address the main reason to switch to reactive single-thread frameworks? - Stack Overflow, accessed April 1, 2025, [https://stackoverflow.com/questions/78318131/do-java-21-virtual-threads-address-the-main-reason-to-switch-to-reactive-single](https://stackoverflow.com/questions/78318131/do-java-21-virtual-threads-address-the-main-reason-to-switch-to-reactive-single)
    
16. Virtual Threads in Java: Unlocking High-Throughput Concurrency | by Hiten Pratap Singh, accessed April 1, 2025, [https://medium.com/hprog99/virtual-threads-in-java-unlocking-high-throughput-concurrency-55606100b6be](https://medium.com/hprog99/virtual-threads-in-java-unlocking-high-throughput-concurrency-55606100b6be)
    
17. The Basis of Virtual Threads: Continuations | Foojay.io Today, accessed April 1, 2025, [https://foojay.io/today/the-basis-of-virtual-threads-continuations/](https://foojay.io/today/the-basis-of-virtual-threads-continuations/)
    
18. Embracing Virtual Threads - Spring, accessed April 1, 2025, [https://spring.io/blog/2022/10/11/embracing-virtual-threads/](https://spring.io/blog/2022/10/11/embracing-virtual-threads/)
    
19. What are some use cases to explicitly create platform threads versus virtual ones? : r/java, accessed April 1, 2025, [https://www.reddit.com/r/java/comments/1ip6vge/what_are_some_use_cases_to_explicitly_create/](https://www.reddit.com/r/java/comments/1ip6vge/what_are_some_use_cases_to_explicitly_create/)
    
20. Performance of Java virtual threads compared to native threads : r/java - Reddit, accessed April 1, 2025, [https://www.reddit.com/r/java/comments/199wsil/performance_of_java_virtual_threads_compared_to/](https://www.reddit.com/r/java/comments/199wsil/performance_of_java_virtual_threads_compared_to/)
    
21. Java Virtual Threads - Jenkov.com, accessed April 1, 2025, [https://jenkov.com/tutorials/java-concurrency/java-virtual-threads.html](https://jenkov.com/tutorials/java-concurrency/java-virtual-threads.html)
    
22. Virtual Threads —With an use case | by KV Perumal - Medium, accessed April 1, 2025, [https://indianakv.medium.com/virtual-threads-with-an-use-cases-2c945c5112a4](https://indianakv.medium.com/virtual-threads-with-an-use-cases-2c945c5112a4)
    
23. What are reasons not to use virtual threads? : r/java - Reddit, accessed April 1, 2025, [https://www.reddit.com/r/java/comments/1jcpp3f/what_are_reasons_not_to_use_virtual_threads/](https://www.reddit.com/r/java/comments/1jcpp3f/what_are_reasons_not_to_use_virtual_threads/)
    
24. Java Virtual Threads Explained: Benefits and Code Examples - Pinnacle Solutions Group, accessed April 1, 2025, [https://pinnsg.com/java-virtual-threads-explained/](https://pinnsg.com/java-virtual-threads-explained/)