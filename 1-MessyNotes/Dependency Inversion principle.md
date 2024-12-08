[[Design Patterns and Code refactoring]]
# Dependency Inversion Principle (DIP)

## Definition
> High-level modules should not depend on low-level modules. Both should depend on abstractions. Abstractions should not depend on details. Details should depend on abstractions.
\- Robert C. Martin

## Key Concepts
- Part of the SOLID principles
- Promotes loose coupling between components
- Relies heavily on the use of interfaces or abstract classes
- Dependencies should be passed in (injected) rather than created internally

## Real-World Analogy 🔌
Think of electrical outlets:
- Bad Design: Each device needs its own specific outlet
- Good Design: Standard outlet interface that any device can plug into
- The outlet (abstraction) doesn't depend on the device (detail)
- Both the outlet and device depend on the agreed interface

## Before vs After DIP

### Without DIP ❌
```java
class EmailService {
    void sendEmail() { }
}

class OrderProcessor {
    private EmailService emailService = new EmailService(); // Tightly coupled!
}
```

### With DIP ✅
```java
interface MessageService {
    void sendMessage();
}

class EmailService implements MessageService {
    void sendMessage() { }
}

class OrderProcessor {
    private MessageService messageService; // Depends on abstraction
    
    OrderProcessor(MessageService service) { // Dependency injection
        this.messageService = service;
    }
}
```

## Benefits
1. [[Loose Coupling]] between components
2. Enhanced [[Code Flexibility]] and maintainability
3. Easier [[Unit Testing]] with mock objects
4. Better code reusability
5. Supports [[Plugin Architecture]]

## Common Examples in Software

### 1. Notification Systems
- Interface: `NotificationService`
- Implementations:
  - EmailNotification
  - SMSNotification
  - PushNotification

### 2. Data Storage
- Interface: `Repository`
- Implementations:
  - SQLRepository
  - MongoRepository
  - RedisRepository

### 3. Payment Processing
- Interface: `PaymentGateway`
- Implementations:
  - StripePayment
  - PayPalPayment
  - SquarePayment

## Warning Signs (Code Smells) 🚩
1. `new` keyword in constructors
2. Static/singleton references
3. Concrete class dependencies
4. High-level modules with direct dependencies on low-level modules

## Implementation Tips
1. Start with interfaces/abstractions
2. Use constructor injection for required dependencies
3. Apply [[Dependency Injection]] patterns
4. Follow [[Interface Segregation Principle]]
5. Keep interfaces focused and cohesive

## Common Misconceptions ⚠️
1. "It means no concrete classes" - False
2. "It's just dependency injection" - DIP is broader
3. "It always requires a DI framework" - Can be done manually

## Testing Benefits
```java
// Easy to mock for testing
class OrderProcessorTest {
    @Test
    void testOrderProcessing() {
        MockMessageService mockService = new MockMessageService();
        OrderProcessor processor = new OrderProcessor(mockService);
        // Test with mock service
    }
}
```

## Related Patterns
- [[Factory Pattern]]
- [[Strategy Pattern]]
- [[Observer Pattern]]
- [[Dependency Injection]]
- [[Inversion of Control]]

## Best Practices
1. Design for interfaces
2. Use constructor injection
3. Keep abstractions stable
4. Follow [[Single Responsibility Principle]]
5. Create meaningful interfaces

## Anti-Patterns to Avoid
1. ❌ Service Locator Pattern
2. ❌ Singleton abuse
3. ❌ God interfaces
4. ❌ Concrete class inheritance

## Further Reading
- [[1-MessyNotes/SOLID Principles]]
- [[Clean Architecture]]
- [[Dependency Injection Patterns]]
- [[Interface Design Patterns]]

#software-principles #SOLID #design-patterns #clean-code