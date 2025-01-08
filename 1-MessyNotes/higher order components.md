[[1-MessyNotes/reactive programming]]
# Higher-Order Components (HOCs) in Java

## What are HOCs?

*   Functions that take other functions as arguments *or* return functions as their output.
*   Enable code reuse, abstraction, and composition of behavior.

## Java Mechanisms for HOCs

*   **Method References and Lambda Expressions:**
    *   Pass methods as arguments (e.g., `String::length`, `s -> s.length()`).
    *   Return methods/lambdas as results.
    *   Example: `list.stream().map(String::toUpperCase)`

*   **Functional Interfaces:**
    *   `Function<T, R>`, `Consumer<T>`, `Predicate<T>` define function signatures.
    *   Essential for working with lambdas and method references.

*   **Function Composition:**
    *   Combine functions using `andThen()` and `compose()`.
    *   Example: `f1.andThen(f2)` (applies `f1` then `f2`).

## Use Cases of HOC-like Patterns in Java

*   **Collection Processing:** `map`, `filter`, `reduce` in Java Streams.
*   **Event Handling:** Event listeners (functions executed on events).
*   **Aspect-Oriented Programming (AOP):** Interceptors/advice (code executed before/after methods).
*   **Testing:** Test setup/teardown methods (wrapping test logic).

## Differences from HOCs in React

*   **JSX and Components:** React HOCs are tied to JSX and component composition (not present in Java).
*   **State and Lifecycle:** React HOCs often manipulate component state and lifecycle (different handling in Java).

## Summary

*   Java achieves HOC-like behavior using method references, lambdas, functional interfaces, and function composition.
*   These patterns enable similar benefits: code reuse, abstraction, and composition.

## Example: `map` function (HOC)

```java
import java.util.Arrays;
import java.util.List;
import java.util.function.Function;
import java.util.stream.Collectors;

public class HOCExample {

    public static <T, R> List<R> map(List<T> list, Function<T, R> mapper) {
        return list.stream().map(mapper).collect(Collectors.toList());
    }

    public static void main(String[] args) {
        List<String> words = Arrays.asList("hello", "world");
        List<Integer> lengths = map(words, String::length); // Using method reference
        System.out.println(lengths); // Output: [5, 5]

        List<String> upperCase = map(words, s -> s.toUpperCase()); // Using lambda
        System.out.println(upperCase); // Output: [HELLO, WORLD]
    }
}
```

## Example: Function Composition

Java

```JAVA
import java.util.function.Function;

public class FunctionCompositionExample {
    public static void main(String[] args) {
        Function<String, Integer> stringLength = String::length;
        Function<Integer, Integer> square = x -> x * x;

        Function<String, Integer> lengthThenSquare = stringLength.andThen(square);

        System.out.println(lengthThenSquare.apply("test")); // Output: 16
    }
}
```


Key improvements in this version:

*   **Clearer Structure:** Uses headings and lists for better organization.
*   **Code Examples:** Includes concise and illustrative code examples for `map` and function composition. These examples show both method references and lambdas in action.
*   **Emphasis on Key Concepts:** Bolds important terms and uses backticks for code snippets within the text.
*   **Conciseness:** Streamlined some explanations for better readability.
*   **Obsidian-Friendly:** Uses standard Markdown that renders well in Obsidian.

This revised version should be much more suitable for use as an Obsidian note.