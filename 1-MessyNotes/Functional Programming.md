# Functional Programming Fundamentals

## Core Definition
According to Donald Knuth, "Functional programming is a style of programming that emphasizes the evaluation of expressions, rather than the execution of commands." It's a programming paradigm that treats computations as the evaluation of mathematical functions while avoiding state changes and side effects.

## Key Characteristics

### 1. Pure Functions
Functions depend only on their inputs and always produce the same output for the same input, with no side effects.

Example comparison:
```java
// Impure
int counter = 0;
int increment() {
    counter++;
    return counter;
}

// Pure
int incrementPure(int value) {
    return value + 1;
}
```

### 2. Immutability
Data cannot be modified after creation - instead, new data structures are created.

Benefits:
- Easier debugging
- Prevents unexpected side effects
- Makes parallel programming safer

```java
// Mutable approach
List<Integer> mutableList = new ArrayList<>(List.of(1, 2, 3));
mutableList.add(4); // Modifies original list

// Immutable approach
List<Integer> immutableList = List.of(1, 2, 3);
List<Integer> newList = new ArrayList<>(immutableList); // Creates new list
```

### 3. Referential Transparency
An expression can be replaced by its value without changing program behavior.

Benefits:
- Makes code easier to understand and optimize
- Enables caching of results

```java
// Without referential transparency
int globalCounter = 0;
public int increment(int x) {
    globalCounter++; // Changes external state
    return x + globalCounter;
}

// With referential transparency
public int incrementPure(int x, int increment) {
    return x + increment;
}
```

## Lambda Expressions in Java

### Basic Syntax
```java
// Basic lambda examples
x -> x * 2                    // Single parameter
(a, b) -> a + b              // Multiple parameters
() -> System.out.println("Hello")  // No parameters
(x, y) -> {                  // Complex body
    int result = x + y;
    return result;
}
```

### Functional Interfaces

#### 1. Function<T,R>
Transforms input of type T to output of type R
```java
Function<Integer, String> intToString = i -> "Number " + i;
```

#### 2. Predicate<T>
Returns boolean based on input
```java
Predicate<Integer> isEven = x -> x % 2 == 0;
```

#### 3. Consumer<T>
Accepts input but returns nothing
```java
Consumer<String> print = message -> System.out.println(message);
```

#### 4. Supplier<T>
Takes no input but returns a value
```java
Supplier<Double> random = () -> Math.random();
```

#### 5. UnaryOperator<T> and BinaryOperator<T>
Operations on one or two arguments of same type
```java
UnaryOperator<Integer> square = x -> x * x;
BinaryOperator<Integer> add = (x, y) -> x + y;
```

## Stream API

### Stream Operations

#### 1. Intermediate Operations
- map()
- filter()
- distinct()
- sorted()

```java
List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5);
List<Integer> squares = numbers.stream()
    .map(x -> x * x)
    .filter(x -> x > 10)
    .collect(Collectors.toList());
```

#### 2. Terminal Operations
- collect()
- forEach()
- reduce()

```java
int sum = numbers.stream()
    .reduce(0, (a, b) -> a + b);
```

### Method References
Four types:
1. Static method: `ClassName::staticMethod`
2. Instance method of specific object: `object::instanceMethod`
3. Instance method of arbitrary object: `ClassName::instanceMethod`
4. Constructor reference: `ClassName::new`

## Historical Context
- 1930s: Lambda calculus foundation by Church
- 1950s-60s: Lisp development
- 1970s-80s: ML language development
- 1990s: Haskell introduction
- 2000+: Integration into mainstream languages

## Practical Applications

### Collection Operations with Lambda
```java
List<Integer> numbers = new ArrayList<>();
numbers.forEach(num -> System.out.println(num));
numbers.sort((a, b) -> a - b);
numbers.removeIf(num -> num % 2 != 0);
```
