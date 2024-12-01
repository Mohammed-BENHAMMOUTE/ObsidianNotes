[[java]]
In Java, exceptions are categorized into two main types: **checked exceptions** and **unchecked exceptions**. The distinction between them affects how they are handled during the program's compilation and runtime. Here's a detailed explanation of the differences:

### 1. **Checked Exceptions**:
- **Definition**: These are exceptions that are **checked at compile time**. The compiler ensures that checked exceptions are either caught using a `try-catch` block or declared in the method signature using the `throws` keyword.
- **Examples**: `IOException`, `SQLException`, `FileNotFoundException`, `ClassNotFoundException`.
- **Handling Requirement**: The Java compiler forces you to handle checked exceptions. If you don't handle them or declare them in the method signature, the code will not compile.
- **Purpose**: Checked exceptions are used for conditions that are **recoverable**, meaning the programmer can foresee and provide a way to recover from the exception.
  
  Example:
  ```java
  public void readFile() throws IOException {
      FileReader file = new FileReader("example.txt"); // May throw a checked exception (FileNotFoundException)
      BufferedReader reader = new BufferedReader(file);
      String line = reader.readLine();
      reader.close();
  }
  ```

  In this case, if `example.txt` does not exist, a `FileNotFoundException` (a checked exception) is thrown. The method either needs to handle it with a `try-catch` block or declare that it throws the exception.

### 2. **Unchecked Exceptions**:
- **Definition**: These are exceptions that occur during the program's execution (at **runtime**) and are **not checked at compile time**. Unchecked exceptions are derived from `RuntimeException` and its subclasses.
- **Examples**: `NullPointerException`, `ArrayIndexOutOfBoundsException`, `ArithmeticException`, `IllegalArgumentException`.
- **Handling Requirement**: The compiler does not force you to handle unchecked exceptions. You can choose to catch them or not, but your code will still compile without explicitly handling or declaring them.
- **Purpose**: Unchecked exceptions represent conditions that are typically **programming errors** (e.g., accessing a null object, dividing by zero, or array index out-of-bounds). They are often caused by logic flaws or unexpected states that the programmer didn't foresee.

  Example:
  ```java
  public void divide(int a, int b) {
      int result = a / b; // May throw an unchecked exception (ArithmeticException if b is 0)
      System.out.println(result);
  }
  ```

  Here, dividing by zero will result in an `ArithmeticException`, but the code will compile without any `try-catch` or `throws` declaration, since it's an unchecked exception.

### Key Differences:

| Feature                  | **Checked Exceptions**                                      | **Unchecked Exceptions**                                |
|--------------------------|-------------------------------------------------------------|---------------------------------------------------------|
| **Compile-Time Checking** | Checked by the compiler; must be handled or declared        | Not checked by the compiler; no need to handle or declare |
| **Class Hierarchy**       | Subclasses of `Exception` (but not `RuntimeException`)      | Subclasses of `RuntimeException`                        |
| **Type of Errors**        | Generally for **recoverable** situations (e.g., file not found) | Generally for **programming errors** (e.g., null pointer, divide by zero) |
| **Handling**              | Must be handled explicitly with `try-catch` or `throws`    | Optional; can be caught, but not mandatory               |
| **Examples**              | `IOException`, `SQLException`, `FileNotFoundException`     | `NullPointerException`, `ArithmeticException`, `ArrayIndexOutOfBoundsException` |
| **When to Use**           | When the program **can recover** from the exception        | When the program **cannot recover** from the exception   |

### Summary:
- **Checked Exceptions**: Are intended for exceptional conditions that are expected to be handled or anticipated (e.g., file not found, network issues). They are checked at compile time, and you are required to either handle or declare them.
- **Unchecked Exceptions**: Typically represent programming errors (e.g., `NullPointerException`, `IndexOutOfBoundsException`) and are not checked at compile time. You are not required to handle them, though you can choose to if necessary.

In general, checked exceptions force the developer to account for potential issues in the code, while unchecked exceptions focus on logical issues that are harder to recover from, but still important to understand and potentially handle.