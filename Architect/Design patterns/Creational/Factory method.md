[[Design Patterns]]
[[Creational Design Patterns]]
# Factory Method Design Pattern in Java

## Introduction

The Factory Method is a creational design pattern that provides an interface for creating objects in a superclass, but allows subclasses to alter the type of objects that will be created. It's one of the most commonly used design patterns in Java.

## Problem

Imagine you're building an application that needs to work with different types of documents (PDF, Word, Text). If your code is tightly coupled to specific document classes, adding new document types would require changes throughout your codebase.

## Solution

The Factory Method pattern suggests that you replace direct object construction calls with calls to a special factory method. Objects returned from the factory method are often referred to as "products."

## Structure

```
┌────────────┐       ┌────────────┐
│  Creator   │<----->│  Product   │
└────────────┘       └────────────┘
	      ↑                    ↑
	      │                    │
┌─────────────────┐       ┌─────────────────┐
│ ConcreteCreator │       │ ConcreteProduct │
└─────────────────┘       └─────────────────┘
```

## Components

1. **Product** - An interface or abstract class defining operations that all concrete products must implement
2. **Concrete Products** - Classes implementing the Product interface
3. **Creator** - An abstract class declaring the factory method that returns a Product
4. **Concrete Creators** - Classes that override the factory method to return specific concrete products

## Implementation in Java

### Step 1: Define the Product Interface

```java
// The Product interface defines operations all concrete products must implement
public interface Product {
    void operation();
}
```

### Step 2: Create Concrete Products

```java
// Concrete implementation of Product
public class ConcreteProductA implements Product {
    @Override
    public void operation() {
        System.out.println("Using ConcreteProductA");
    }
}

// Another concrete implementation of Product
public class ConcreteProductB implements Product {
    @Override
    public void operation() {
        System.out.println("Using ConcreteProductB");
    }
}
```

### Step 3: Create the Creator

```java
// The Creator class declares the factory method
public abstract class Creator {
    // Factory method - subclasses must implement this
    public abstract Product createProduct();
    
    // Creator may also contain some business logic
    public void someOperation() {
        // Call factory method to create a Product
        Product product = createProduct();
        
        // Use the product
        product.operation();
    }
}
```

### Step 4: Implement Concrete Creators

```java
// Creates ConcreteProductA instances
public class ConcreteCreatorA extends Creator {
    @Override
    public Product createProduct() {
        return new ConcreteProductA();
    }
}

// Creates ConcreteProductB instances
public class ConcreteCreatorB extends Creator {
    @Override
    public Product createProduct() {
        return new ConcreteProductB();
    }
}
```

### Step 5: Client Code

```java
public class Client {
    public static void main(String[] args) {
        // Application picks the creator type based on configuration or environment
        Creator creator = new ConcreteCreatorA();
        creator.someOperation();  // Output: Using ConcreteProductA
        
        creator = new ConcreteCreatorB();
        creator.someOperation();  // Output: Using ConcreteProductB
    }
}
```

## Real-World Example: Document Application

Let's implement a more realistic example of the Factory Method pattern for a document processing application.

### Step 1: Define Document Interface

```java
public interface Document {
    void open();
    void save();
    void print();
}
```

### Step 2: Create Concrete Document Types

```java
public class PDFDocument implements Document {
    @Override
    public void open() {
        System.out.println("Opening PDF document...");
    }
    
    @Override
    public void save() {
        System.out.println("Saving PDF document...");
    }
    
    @Override
    public void print() {
        System.out.println("Printing PDF document...");
    }
}

public class WordDocument implements Document {
    @Override
    public void open() {
        System.out.println("Opening Word document...");
    }
    
    @Override
    public void save() {
        System.out.println("Saving Word document...");
    }
    
    @Override
    public void print() {
        System.out.println("Printing Word document...");
    }
}

public class TextDocument implements Document {
    @Override
    public void open() {
        System.out.println("Opening Text document...");
    }
    
    @Override
    public void save() {
        System.out.println("Saving Text document...");
    }
    
    @Override
    public void print() {
        System.out.println("Printing Text document...");
    }
}
```

### Step 3: Create Application Abstract Class

```java
public abstract class Application {
    // Factory method
    public abstract Document createDocument();
    
    // Template method using factory method
    public void newDocument() {
        Document doc = createDocument();
        doc.open();
    }
    
    public void openDocument() {
        Document doc = createDocument();
        doc.open();
    }
    
    public void saveDocument() {
        Document doc = createDocument();
        doc.save();
    }
    
    public void printDocument() {
        Document doc = createDocument();
        doc.print();
    }
}
```

### Step 4: Create Concrete Applications

```java
public class PDFApplication extends Application {
    @Override
    public Document createDocument() {
        return new PDFDocument();
    }
}

public class WordApplication extends Application {
    @Override
    public Document createDocument() {
        return new WordDocument();
    }
}

public class TextApplication extends Application {
    @Override
    public Document createDocument() {
        return new TextDocument();
    }
}
```

### Step 5: Client Code

```java
public class DocumentClient {
    public static void main(String[] args) {
        // User chooses application type
        Application app = createApplicationByType("pdf");
        
        // Use the application to create and manipulate documents
        app.newDocument();
        app.saveDocument();
        app.printDocument();
    }
    
    // This could be based on user input, configuration, etc.
    private static Application createApplicationByType(String type) {
        if (type.equals("pdf")) {
            return new PDFApplication();
        } else if (type.equals("word")) {
            return new WordApplication();
        } else if (type.equals("text")) {
            return new TextApplication();
        } else {
            throw new IllegalArgumentException("Unknown document type: " + type);
        }
    }
}
```

## Full Code Example

Here's a complete runnable example that puts everything together:

```java
// Document interface
interface Document {
    void open();
    void save();
    void print();
}

// Concrete document implementations
class PDFDocument implements Document {
    @Override
    public void open() {
        System.out.println("Opening PDF document...");
    }
    
    @Override
    public void save() {
        System.out.println("Saving PDF document...");
    }
    
    @Override
    public void print() {
        System.out.println("Printing PDF document...");
    }
}

class WordDocument implements Document {
    @Override
    public void open() {
        System.out.println("Opening Word document...");
    }
    
    @Override
    public void save() {
        System.out.println("Saving Word document...");
    }
    
    @Override
    public void print() {
        System.out.println("Printing Word document...");
    }
}

class TextDocument implements Document {
    @Override
    public void open() {
        System.out.println("Opening Text document...");
    }
    
    @Override
    public void save() {
        System.out.println("Saving Text document...");
    }
    
    @Override
    public void print() {
        System.out.println("Printing Text document...");
    }
}

// Abstract creator
abstract class Application {
    // Factory method
    public abstract Document createDocument();
    
    // Business logic using the factory method
    public void newDocument() {
        Document doc = createDocument();
        doc.open();
    }
    
    public void openDocument() {
        Document doc = createDocument();
        doc.open();
    }
    
    public void saveDocument() {
        Document doc = createDocument();
        doc.save();
    }
    
    public void printDocument() {
        Document doc = createDocument();
        doc.print();
    }
}

// Concrete creators
class PDFApplication extends Application {
    @Override
    public Document createDocument() {
        return new PDFDocument();
    }
}

class WordApplication extends Application {
    @Override
    public Document createDocument() {
        return new WordDocument();
    }
}

class TextApplication extends Application {
    @Override
    public Document createDocument() {
        return new TextDocument();
    }
}

// Client code
public class FactoryMethodDemo {
    public static void main(String[] args) {
        System.out.println("Using PDF Application:");
        Application app = new PDFApplication();
        app.newDocument();
        app.saveDocument();
        app.printDocument();
        
        System.out.println("\nUsing Word Application:");
        app = new WordApplication();
        app.newDocument();
        app.saveDocument();
        app.printDocument();
        
        System.out.println("\nUsing Text Application:");
        app = new TextApplication();
        app.newDocument();
        app.saveDocument();
        app.printDocument();
    }
}
```

## When to Use the Factory Method Pattern

1. **When you don't know the exact types of objects your code will work with**
    - Factory Method lets a class defer instantiation to subclasses
2. **When you want to provide users of your library or framework with a way to extend its internal components**
    - Users can extend the factory method in your framework to add custom behavior
3. **When you want to save system resources by reusing existing objects instead of building new ones**
    - Can be combined with the object pool pattern

## Advantages

1. **Avoids tight coupling** between the creator and concrete products
2. **Single Responsibility Principle**: Product creation code is in one place
3. **Open/Closed Principle**: You can introduce new types of products without breaking existing code
4. **Creates objects without exposing the instantiation logic to the client

## Disadvantages

1. **Increased complexity**: Requires creating multiple new subclasses
2. **Might be overkill** for simple cases where direct instantiation is sufficient

## Related Patterns

- **Abstract Factory**: Provides an interface for creating families of related or dependent objects without specifying their concrete classes
- **Template Method**: Often used together with Factory Method (the Factory Method is a specialized version of Template Method)
- **Prototype**: Can be used instead of Factory Method if you have many possible product classes

## Conclusion

The Factory Method pattern is an excellent choice when your code needs to work with various product classes where the concrete types aren't known until runtime. It provides a way to delegate the instantiation logic to child classes, decoupling the client code from the concrete product classes.