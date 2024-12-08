[[Design Patterns and Code refactoring]]
[[interview prep to do list]]

---

## SOLID Principles: A Guide to Clean Software Design

### **Introduction**

The SOLID principles are a set of design guidelines for writing maintainable, scalable, and flexible software. These principles, introduced by Robert C. Martin, help developers create systems that are easier to understand, modify, and extend.

---

### **1. Single Responsibility Principle (SRP)**

**Definition:** A class should have only one reason to change, meaning it should only have one responsibility.

**Why it matters:** When a class takes on too many responsibilities, it becomes harder to modify and test. Changes in one responsibility might inadvertently affect another.

**Example:**  
Imagine a class `Book`.

- Bad design: The `Book` class handles content storage and printing.
- Better design: Separate responsibilities into `Book` (stores content) and `Printer` (handles printing).

This separation ensures that changes to the printing logic don’t impact how content is managed.

---

### **2. Open/Closed Principle (OCP)**

**Definition:** A class should be open for extension but closed for modification.

**Why it matters:** Modifying existing code can introduce bugs. Instead, new functionality should be added by extending existing code.

**Example:**  
Suppose you have a system calculating area for different shapes.

- Bad design: Modify the class to add logic for new shapes.
- Better design: Create a base interface `Shape` with an `area()` method, then extend it for each specific shape (e.g., `Circle`, `Rectangle`).

This approach avoids altering existing code when adding new shapes.

---

### **3. Liskov Substitution Principle (LSP)**

**Definition:** Subtypes must be substitutable for their base types without altering the behavior of the program.

**Why it matters:** Violating this principle creates unexpected behavior, making systems harder to predict and debug.

**Example:**  
Imagine a `Bird` class with a `fly()` method.

- Bad design: Subclass `Penguin` inherits `Bird` but overrides `fly()` to throw an error because penguins can’t fly.
- Better design: Use separate abstractions, like `FlyingBird` and `NonFlyingBird`.

This ensures substituting a subclass won’t break functionality.

---

### **4. Interface Segregation Principle (ISP)**

**Definition:** A class should not be forced to implement interfaces it doesn’t use.

**Why it matters:** Large interfaces with unrelated functionalities lead to bloated classes and unnecessary dependencies.

**Example:**  
Imagine an interface `Vehicle` with methods like `drive()` and `fly()`.

- Bad design: A car class implements `Vehicle` but has to provide an empty `fly()` method.
- Better design: Create separate interfaces, like `Drivable` and `Flyable`.

Classes only implement the interfaces they need.

---

### **5. Dependency Inversion Principle (DIP)**

**Definition:** High-level modules should not depend on low-level modules. Both should depend on abstractions.

**Why it matters:** Hard dependencies make systems rigid and difficult to test or extend. Using abstractions allows for greater flexibility.

**Example:**  
Consider a `PaymentProcessor` class that directly depends on `PayPal`.

- Bad design: Changing or adding payment providers requires modifying the `PaymentProcessor`.
- Better design: Depend on an abstraction like `PaymentGateway` and implement `PayPal`, `Stripe`, etc., as concrete classes.

This decouples the `PaymentProcessor` from specific payment methods.

---

### **Conclusion**

The SOLID principles serve as a guide to creating robust software systems. By adhering to these principles, developers can reduce complexity, improve testability, and ensure their code is adaptable to future changes.

---
