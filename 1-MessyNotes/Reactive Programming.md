## 1. Introduction[](https://www.baeldung.com/cs/reactive-programming#introduction)

In this tutorial, we’ll start with the basic principles and origins of reactive programming. **Reactive programming is a declarative programming paradigm that is based on the idea of asynchronous event processing and data streams.** Today, reactive programming is used in many different areas, such as GUI programming, web programming, microservices, or reactive systems in general.

We’ll discuss the basics of reactive programming and show an example of how reactive programming can be used in practice.

## 2. Origins of Reactive Programming[](https://www.baeldung.com/cs/reactive-programming#origins-of-reactive-programming)

As we already pointed out in the introduction, reactive programming is based on the idea of asynchronous event processing. **Asynchronous processing means that the processing of an event does not block the processing of other events.**

In the first GUI applications, the user interface was updated only after some user action, like clicking a button. The heart of the application was a so-called event loop. It was an endless loop and was responsible for handling user input and updating the user interface. But as the program was waiting synchronously (i.e., blocking) for the user input, nothing else could happen. And waiting synchronously for an event that doesn’t come means that the whole application hangs and the GUI becomes unresponsive.

The solution is to decouple the event handling from the GUI update. The decoupling is done by **introducing an event queue and parallel event processing. This approach is well known as the producer and consumer pattern.** A thread handling user input puts events into the queue, and a consumer thread takes events from the queue’s head and processes them. The consumer thread may also act as a producer by putting GUI update requests into a queue processed by a GUI update thread. Such producer/consumer chaining then leads to reactive streams.

**Today, the reactive programming paradigm has also spread to cloud applications.** Cloud-based services are often implemented as a set of microservices. **These are small components that are loosely coupled and communicate with each other via asynchronous message passing.** The reactive programming paradigm is a perfect fit for such microservices.

## 3. Reactive Programming Frameworks[](https://www.baeldung.com/cs/reactive-programming#reactive-programming-frameworks)

Currently, there are several reactive programming frameworks available. The first reactive programming library was RxJava which was introduced in 2013. A good introduction to this library is available in this [Introduction to RxJava](https://www.baeldung.com/rx-java). For exploring reactive programming libraries, it’s good to start at [ReactiveX](https://reactivex.io/intro.html). It offers the library for major [programming languages](https://reactivex.io/languages.html) while keeping the same API.

There’s also an initiative to standardize the reactive streams API. The initiative is called [Reactive Streams](https://www.reactive-streams.org/). It defines a set of rules for asynchronous stream processing with non-blocking back pressure.

## 4. The Observer Pattern[](https://www.baeldung.com/cs/reactive-programming#the-observer-pattern)

As stated above, reactive systems make use of asynchronous communication. In contrast to a synchronous procedure call, where parameters are passed to the procedure, and the program flow doesn’t continue until the procedure returns the result, the caller doesn’t wait for the result in asynchronous communication. Instead, the caller registers a callback procedure that is called when the result is available. The caller can continue his work, and the callback procedure is called when the result is available. In other words, the caller passes to the asynchronous procedure also “what should happen in the future when the result is available”.

Moreover, the caller can register multiple callback procedures. This is useful when the caller wants to be notified about the result of the asynchronous procedure but also when the asynchronous procedure fails. In this case, the caller can register two callback procedures, one for the success case and one for the failure case. And lastly, the caller itself may be a callee, perform some processing on the result and pass it back to the caller.

The callback pattern is usually implemented in object-oriented programming using the Observer pattern. In the observer pattern, the return value of the asynchronous procedure call is called the _Observable_, and the callback procedure is called the _Observer_:

![rx pattern](https://www.baeldung.com/wp-content/uploads/sites/4/2023/02/rx_pattern.png)

From the programmer’s view, a code making use of the callback or observer pattern may be hard to read. And it even gets worse when the callback procedure calls another asynchronous procedure. In this case, the callback procedure is called when the result of the first procedure is available and calls the second procedure. The second procedure then registers its callback procedure, and so on. This is aptly called the callback hell.

## 5. Reactive Streams[](https://www.baeldung.com/cs/reactive-programming#reactive-streams)

In reactive applications, handling simply one event doesn’t do the job. Instead, the application has to handle a stream of events. **In the case of reactive streams, the _Observable_ is not just a single event but an event stream. The _Observer_ then has to provide “callbacks” for success and failure and for the end of the stream.**

Reactive streams may also differ in how the stream flow is controlled. There are two approaches: push and pull. In the push approach, the consumer doesn’t know exactly when a new event is emitted. In this case, the consumer may easily be overwhelmed by the stream of events. So, the consumer has to be able to control the stream flow somehow. This is called back pressure. In the pull approach, the consumer explicitly decides when to get the next event from the stream.

## 6. Reactive Streams Operators[](https://www.baeldung.com/cs/reactive-programming#reactive-streams-operators)

**The main benefit of libraries providing the reactive streams API is also in provided operators.** For example, the RxJS provides over one hundred operators! **These operators are functions that can be applied to a stream of data. They already implement common problems in processing reactive streams, such as filtering, mapping, aggregating, etc.**

**Moreover, these operator functions are designed to be composable, which means that they can be chained together to form a complex processing pipeline.** Each operator function takes an Observable as an input and returns another Observable as an output. This way, the output of one operator function can be passed as an input to another operator function. This is called operator chaining. But let’s first look at the categories of operators in the following subsections.

For better understandability, we’ll also provide diagrams and Java code examples based on RxJava.

### 6.1. Creation Operators[](https://www.baeldung.com/cs/reactive-programming#1-creation-operators)

As the name suggests, these operators are used to create a stream of data. For example, **the _fromArray()_ operator creates a stream from an array of values**, because when you want to process data with reactive streams, it is more convenient to transform the data into a stream and represent them as _Observables_:

_**![marble from](https://www.baeldung.com/wp-content/uploads/sites/4/2023/02/marble-from.png)**_

Java language example:

```java
Observable<String> workdays = Observable.fromArray( "Monday", "Tuesday", "Wednesday", "Thursday", "Friday");
workdays.subscribe(
  day -> System.out.println(day),
  error -> System.out.println("Error: " + error),
  () -> System.out.println("Stream completed.")
);
```

### 6.2. Join Creation Operators[](https://www.baeldung.com/cs/reactive-programming#2-join-creation-operators)

These operators are used to create a stream from multiple other streams. For example, **the _concat()_ operator concatenates multiple streams into one**:

![marble concat](https://www.baeldung.com/wp-content/uploads/sites/4/2023/02/marble-concat.png)

This example shows the concatenation of three streams into one:

```java
Observable<String> source1 = Observable.just("10", "20", "30", "40", "50");
Observable<String> source2 = Observable.just("11", "21", "31", "41", "51");
Observable<String> source3 = Observable.just("12", "22", "32", "42", "52");

Observable<String> source = Observable.concat(source1, source2, source3);
source.subscribe(
  s -> System.out.println(s),
  error -> System.out.println("Error: " + error),
  () -> System.out.println("Stream completed.")
);
```

### 6.3. Transformation Operators[](https://www.baeldung.com/cs/reactive-programming#3-transformation-operators)

These operators are used to transform the data in a stream. For example, **the _map()_ operator transforms each value in the stream** by applying a function to it:

![marble map](https://www.baeldung.com/wp-content/uploads/sites/4/2023/02/marble-map.png)

Let’s see an example using RxJava:

```java
Observable<Integer> source = Observable.just(1, 2, 3, 4, 5);
source.map(x -> 10 * x).subscribe(
  n -> System.out.println("Value: " + n),
  error -> System.out.println("Error: " + error),
  () -> System.out.println("Stream completed.")
);
```

### 6.4. Filtering Operators[](https://www.baeldung.com/cs/reactive-programming#4-filtering-operators)

These operators are used to filter the data in a stream. For example, **the _filter()_ operator filters out values in the stream that don’t satisfy a predicate**:

![marble filter](https://www.baeldung.com/wp-content/uploads/sites/4/2023/02/marble-filter.png)

we can see in this example how to use this operator in RxJava:

```java
Observable<Integer> source = Observable.just(2, 30, 22, 5, 60, 1 );
source.filter(x -> x > 10).subscribe(
  n -> System.out.println("Value: " + n),
  error -> System.out.println("Error: " + error),
  () -> System.out.println("Stream completed.")
);
```

### 6.5. Join Operators[](https://www.baeldung.com/cs/reactive-programming#5-join-operators)

These operators are used to join two streams into one. For example, **the _zip()_ operator combines two streams into one by applying a function to the values from each stream. The _merge()_ operator merges two streams into one by interleaving the emitted items**:

![marble merge](https://www.baeldung.com/wp-content/uploads/sites/4/2023/02/marble-merge.png)

In this example, we create two sources emitting items at different intervals and then merge them into one:

```java
Observable<String> numbersSource = createStreamFrom("1 2 3 4 5" /* data */, 0 /* initial delay */, 200 /* interval */, TimeUnit.MILLISECONDS);
Observable<String> lettersSource = createStreamFrom("A B C", 500, 500, TimeUnit.MILLISECONDS);

Observable<String> source = Observable.merge(lettersSource, numbersSource);
source.subscribe(
  x -> System.out.println("Merge value: " + x),
  error -> System.out.println("Error: " + error),
  () -> System.out.println("Stream completed.")
);
```

### 6.6. Multicasting Operators[](https://www.baeldung.com/cs/reactive-programming#6-multicasting-operators)

**Multicasting operators are used for sharing a stream among multiple subscribers.** They can be either “cold” or “hot”. **Cold publishers publish the items from the beginning to each subscriber**, like the _replay()_ operator:  
![marble replay](https://www.baeldung.com/wp-content/uploads/sites/4/2023/02/marble-replay.png)  
This Java code creates a stream of numbers with two subscribers. The second subscriber connects to the stream one second later but receives all items emitted from the start:

```java
Observable<String> numbersSource = createStreamFrom("0 1 2 3 4 5" /* data */, 0 /* initial delay */, 300 /* interval */, TimeUnit.MILLISECONDS);
Observable<String> coldPublisher = numbersSource.replay().autoConnect();

coldPublisher.subscribe(
  x -> System.out.println("Subscriber 1 value: " + x),
  error -> System.out.println("subscriber 1 error: " + error),
  () -> System.out.println("Stream completed.")
);

TimeUnit.SECONDS.sleep(1);

coldPublisher.subscribe(
  x -> System.out.println("Subscriber 2 value: " + x),
  error -> System.out.println("subscriber 2 error: " + error),
  () -> System.out.println("Stream completed.")
);
```

**Hot publishers publish the items to each subscriber as they go**, like the _publish()_ operator. Any subscriber joining later won’t already receive previously emitted values:  
_**![marble publish](https://www.baeldung.com/wp-content/uploads/sites/4/2023/02/marble-publish.png)**_  
This Java code creates a stream of numbers with two subscribers. The second subscriber connects to the stream one second later, but it doesn’t receive items emitted previously:

```java
Observable<String> numbersSource = createStreamFrom("0 1 2 3 4 5" /* data */, 0 /* initial delay */, 300 /* interval */, TimeUnit.MILLISECONDS);
Observable<String> hotPublisher = numbersSource.publish().autoConnect();

hotPublisher.subscribe(
  x -> System.out.println("Subscriber 1 value: " + x),
  error -> System.out.println("subscriber 1 error: " + error),
  () -> System.out.println("Stream completed.")
);

TimeUnit.SECONDS.sleep(1);

hotPublisher.subscribe(x -> System.out.println("Subscriber 2 value: " + x),
  error -> System.out.println("subscriber 2 error: " + error),
  () -> System.out.println("Stream completed.")
);
```

### 6.7. Error Handling Operators[](https://www.baeldung.com/cs/reactive-programming#7-error-handling-operators)

These operators are used to handle errors in a stream. For example, **the _onErrorReturnItem()_ operator catches an error and emits a defined item instead**, whereas **the _onErrorResumeWith()_ resumes the flow with a given source,** as shown in the examples below:

![marble on error item](https://www.baeldung.com/wp-content/uploads/sites/4/2023/02/marble-on-error-item.png)

This example shows how to handle an exception when dividing by zero and returning a value instead using this operator in RxJava:

```java
Observable<Integer> numbers = Observable.just(1, 2, 0, 4, 5);
Observable<Integer> result = numbers.map(x -> 20 / x).onErrorReturnItem(-1);
result.subscribe(
  x -> System.out.println("Value: " + x),
  error -> System.out.println("Error: " + error),
  () -> System.out.println("Stream completed.")
);
```

The _onErrorResumeWith()_ is available in RxJava as well:

```java
Observable<Integer> numbers = Observable.just(1, 2, 0, 4, 5).publish().autoConnect();
Observable<Integer> result = numbers.map(x -> 20 / x).onErrorResumeWith(numbers.map(x -> 20 / x));
result.subscribe(
  x -> System.out.println("Value: " + x),
  error -> System.out.println("Error: " + error),
  () -> System.out.println("Stream completed.")
);
```

More examples of error handling in RxJava are provided in the [RxJava and Error Handling article](https://www.baeldung.com/rxjava-error-handling).

## 7. A Reactive Programming Example[](https://www.baeldung.com/cs/reactive-programming#a-reactive-programming-example)

**Let’s now show the use of reactive programming in the example of an incremental search. Incremental search is a feature that is often used in web applications. It allows the user to search for items in a list as he types.**

**The stream’s source is a GUI component that emits the current search term each time the user types a character.** For example, if the user types _“astro”_, the stream will emit the values _“a”_, _“as”_, _“ast”_, _“astr”_ and _“astro”_. If we must send a query request to a remote service for each character typed, the service will be overloaded. So as the user keeps typing, we do not send a request. But as soon as the user stops for a while, we take the latest input and send it in a request. We can achieve this by using the _debounce()_ operator. which takes a delay in milliseconds as an argument.

Further, it can also easily happen that the user types another character before completing the previous request. In this case, we want to cancel the previous request and send a new one. We can achieve this by using the _switchMap()_ operator, which takes a function as an argument. This function takes the value emitted by the source stream and returns a new stream. The operator subscribes to the new stream and emits the values emitted by this stream. If a new value is emitted by the source stream, the operator unsubscribes from the previous stream and subscribes to the new one.

Finally, we want to display the results of the search. We can achieve this by using the _subscribe()_ operator, which takes two functions as arguments. The first function is called when a new value is emitted by the stream. The second function is called when an error occurs.

**In order to have an idea of how a reactive code implements this example, we provide two code snippets of an imaginary search application using RxJava. The first snippet shows how a stream of user input can be created.** Let’s use Java AWT for the GUI and a _TextField_ component for the search term input. In order to receive changes in the user’s input, we have to add a _TextListener_. Now we’re in the “callback-style world”, we’ve talked about in the introduction. How do we now get to the “reactive-style” world? Simply. **We create an _Observable_ using an emitter, which emits new values in the callback of an input text GUI component:**

```java
TextField textfield = new TextField("", 20);
frame.add(textfield);

Observable<String> userInput = Observable.create(emitter -> {
  textfield.addTextListener(new TextListener() {
    public void textValueChanged(TextEvent e) {
      emitter.onNext(textfield.getText());
    }
  });
});
```

**The second Java code snippet shows how to create a pipeline by chaining reactive operators. We assemble the pipeline from the following stages:**

- _**debounce**_ – we do not send a search request each time the user types a character, but only after 500 milliseconds of inactivity. This is because we don’t want to overload the search service
- _**filter**_ – we further do not want to send too short query strings. Only strings longer than three characters will pass this stage
- _**distinctUntilChanged**_ – this stage avoids sending the same query string in subsequent requests. This can happen if the user types a character and immediately deletes it
- _**switchMap**_ – this stage sends requests to a search service but returns replies only to the most recent requests and cancels previous pending requests. The search service’s _search()_ method is implemented also using the reactive approach. Its return type is _Observable<String>_

Lastly, the final code that creates the described pipeline using _RxJava_:

```java
userInput.debounce(500, TimeUnit.MILLISECONDS)
  .filter(query -> query.length() > 3)
  .distinctUntilChanged()
  .switchMap(query -> searchService.search(query))
  .subscribe(
    results -> parseAndDisplayResults(listBox, results),
    error -> System.out.println("Error: " + error)
  );
```

**A subscriber at the end of the pipeline parses and displays the results in a list box in the application’s GUI:**

![rxjava awt](https://www.baeldung.com/wp-content/uploads/sites/4/2023/02/rxjava-awt.png)

## 8. Testing and Debugging Reactive Applications[](https://www.baeldung.com/cs/reactive-programming#testing-and-debugging-reactive-applications)

Testing an application using reactive streams is slightly different from testing a traditional one. Still, in general, the approach is the same: we want to test whether the application emits the expected output for a given input**.** In a traditional application, we can easily test the application by calling the methods of the classes. But in a reactive application, we cannot call the methods of the classes directly. Instead, we must use the reactive streams API.

The testing strategy for reactive applications is to test whether the stream processing pipeline emits expected results for a given stream of inputs. Of course, we must test the pipeline for three cases: when the stream completes normally when the stream completes with an error, and when the stream is canceled. A nice example of testing a Reactive application is available in [Testing Reactive Streams Using _StepVerifier_ and _TestPublisher_](https://www.baeldung.com/reactive-streams-step-verifier-test-publisher)_._

**Debugging reactive streams is hard.** While in a synchronous and blocking system, an error stack trace points to the root cause of the issue, in an asynchronous reactor stream, the error is logged in the subscriber but has been raised in an operator in stream processing.

## 9. [Summary](https://www.baeldung.com/cs/reactive-programming#summary)

Let’s now briefly summarize the benefits and drawbacks of reactive programming in the table below:

|Pros|Cons|
|---|---|
|Clear and concise code of asynchronous applications|Steep learning curve|
|Implementations provide “pre-fabricated” stages (operator functions) for reactive streams processing|The application is hard to debug|
|A reactive application is more resilient, scalable, and responsive|Higher memory consumption because stream values must be held in memory|

## 10. Conclusion[](https://www.baeldung.com/cs/reactive-programming#10-conclusion)

In this article, we discussed what reactive programming is and how it can be used to build reactive applications. We also introduced the reactive streams concept, stream processing operators and showed how to use some of them in an incremental search example. Finally, we provided an overview of reactive programming frameworks and showed what it means to test and debug a reactive application.