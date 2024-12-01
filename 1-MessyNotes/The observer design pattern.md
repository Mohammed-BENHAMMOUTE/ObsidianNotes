[[Design Patterns and Code refactoring]]

```txt
Definition:
 The observer pattern defines a one to many dependency between objects  so that one object changes state all of its dependents are notified and updated automatically.
```

Imagine you have two things, one of these things changes state. the other thing needs to know about the state of the first thing.

the first element is a publisher the second one is a subscriber.

this pattern is about moving from a poll architecture to a push architecture.

instead of the subscriber having to ask the publisher over and over if it has changed its state over and over again to stay updated, we can inverse the control and give this task to the the publisher hence the push strategy.

so the startegy of polling the publisher is bad especially at scalling, when we have multiple subscibers.

 To use the observer pattern all the subscribers need to register to the publisher, so the publisher has knowledge of the subscribers, that he needs to push to.

the publisher is a observable object so when his state changes, it notifies the the observers(subscribers) of the change that happened.




