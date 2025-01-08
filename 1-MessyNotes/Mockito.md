[[Testes et Qualimetrie]]
# Understanding Mocks in Software Testing: A Comprehensive Guide

## What are Mocks?

Mocks are simulated objects that mimic the behavior of real objects in a controlled way. Think of them as "stand-ins" or "doubles" in a movie - they perform the same actions as the real object would, but under carefully controlled conditions. This is particularly valuable when testing components that depend on other objects that might be:

1. Not yet implemented
2. Difficult to set up in a test environment
3. Slow to initialize
4. Complex to reproduce certain states (like network errors)

## Core Concepts

### The Mock Interface Principle
A fundamental concept in mocking is that a mock must share the same interface as the real object it's simulating. This means that from the perspective of the code being tested, there should be no noticeable difference between interacting with a real object or its mock.

### A Real-World Example

Let's consider a typical business application structure:

```java
public class RecordService {
    private DatabaseDAO database;
    private NetworkDAO network;

    public boolean save(String fileName) {
        database.save(fileName);
        network.save(fileName);
        return true;
    }
}
```

In this scenario, we might want to test the `RecordService` without actually connecting to a database or network. This is where mocks become invaluable.

## Working with Mockito

Mockito is one of the most popular mocking frameworks for Java. Here's a detailed look at how to use it effectively:

### Setting Up Mockito

```xml
<!-- Maven dependency -->
<dependency>
    <groupId>org.mockito</groupId>
    <artifactId>mockito-core</artifactId>
    <version>x.x.x</version>
    <scope>test</scope>
</dependency>
```

### Creating Mocks

There are two main ways to create mocks:

1. Using the `mock()` method:
```java
List listMock = mock(List.class);
```

2. Using annotations (preferred approach):
```java
@ExtendWith(MockitoExtension.class)
class TestClass {
    @Mock
    List listMock;
}
```

### Controlling Mock Behavior

Mockito provides several methods to define how your mocks should behave:

```java
// Basic return value
when(listMock.size()).thenReturn(10);

// Multiple return values in sequence
when(listMock.get(1)).thenReturn("first", "second", "third");

// Throwing exceptions
when(listMock.get(99)).thenThrow(new IndexOutOfBoundsException());

// Void methods
doThrow(new RuntimeException()).when(listMock).clear();
```

### Argument Matchers

Mockito can verify method calls with specific arguments or more flexible matching:

```java
// Exact match
when(listMock.get(1)).thenReturn("specific");

// Any integer argument
when(listMock.get(anyInt())).thenReturn("flexible");

// Any string argument
when(service.process(anyString())).thenReturn(true);
```

### Verifying Interactions

One of the most powerful features of Mockito is the ability to verify how mocks were used:

```java
// Verify a method was called exactly once
verify(databaseMock).save("test.txt");

// Verify a method was called exactly 3 times
verify(databaseMock, times(3)).save(anyString());

// Verify a method was never called
verify(databaseMock, never()).delete(anyString());

// Verify order of operations
InOrder inOrder = inOrder(databaseMock, networkMock);
inOrder.verify(databaseMock).save("test.txt");
inOrder.verify(networkMock).upload("test.txt");
```

### Spies

Spies are special types of mocks that maintain most of the real object's behavior while allowing selective overriding:

```java
// Creating a spy
List<String> realList = new ArrayList<>();
List<String> spyList = spy(realList);

// Using @Spy annotation
@Spy
List<String> spyList = new ArrayList<>();

// Selectively override behavior
when(spyList.size()).thenReturn(100); // Only size() is mocked
spyList.add("real"); // Real behavior remains
```

## Best Practices

1. **Mock Interfaces, Not Classes**
   - Mocking interfaces is cleaner and more maintainable
   - Follows the dependency inversion principle

2. **Verify Essential Interactions Only**
   - Don't verify every interaction
   - Focus on behaviors that are crucial to your test

3. **Keep Mocks Simple**
   - Avoid complex mock setups
   - If you need complex mocks, consider refactoring your design

4. **Use Meaningful Names**
   - Suffix mock objects with "Mock" or "Spy"
   - Makes test code more readable

we usually use doReturn when we wandot to return either void for example:
doNothing().when(list.clear), with spies, when we havent overrided the default behavior, that will cause it to actually run the meth