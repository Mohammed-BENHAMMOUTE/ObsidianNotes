[[java]]
[[Interview Prep]]

what is the difference between an Error and an Exception in Java:

an Error in Java represent an Irrecoverable state, such as `jvm`running out of memory, memory leaks stack overflow , library incompatibility, infinite recursion. they are usually the control of the program and we should not try to handle them.

So basically we cannot recover from the Errors inside our program, the best course of action is to log these errors and exit the program.

Errors and Exception both extend the Throwable class that it self implements the Object class.

`here is the Hierarchy of the Error and Exceptions in Java:`
![[Pasted image 20250302121405.png]]

the difference between runtime and compile time exceptions is that checked exceptions extends the `Exception` class, but the unchecked exceptions extends the `RunTimeException` class.

we can implement our own exceptions. either runtime exception extending the Exception class, or the RunTimeException class extending the RunTimeException class.

## Try catch block:
```java
try {
    // Code that may throw an exception
} catch (ExceptionType e) {
    // Code to handle the exception
}
```

the `finally` block is executed regardless if an Exception occurs or not.