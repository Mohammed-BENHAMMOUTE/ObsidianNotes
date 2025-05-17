[[Design Patterns]]
[[Clean Architecture]]
[[Clean Code]]

---

## Anemic vs Rich Models

### Definitions

- **Anemic Model**: A domain model where objects mainly hold data with little or no behavior. Logic resides in services rather than the data models.
    
- **Rich Model**: A domain model where data and behavior live together. Objects are responsible for their own state and business rules.
    

---

### Comparison

|Feature|Anemic Model|Rich Model|
|---|---|---|
|Logic location|Service classes|Domain objects|
|SRP (Single Responsibility Principle)|Violates it often|Usually respects it|
|TDD-friendly|Difficult due to service logic|Easier to test in isolation|
|Encapsulation|Weak|Strong|
|Complexity|Easier to understand initially|More complex, deeper object behavior|
|Flexibility|Easy to change logic flow|Harder to change without understanding domain deeply|

---

### When to Use

#### Anemic Model

- Simple CRUD applications
    
- Projects with **procedural** or **transaction script**-like structure
    
- Teams with **less domain knowledge**
    
- You need **high control over transaction boundaries** and orchestration
    

#### Rich Model

- **Domain-Driven Design** (DDD) approach
    
- Complex business rules
    
- Systems where you want high cohesion and encapsulation
    
- Encouraged in **enterprise-grade apps**
    

---

### Positives and  Negatives

#### Anemic Model

**Pros:**

- Simpler for beginners
    
- Easier to separate concerns across layers
    
- Clear flow of logic in service layer
    

**Cons:**

- Breaks object-oriented principles
    
- Difficult to enforce business rules
    
- Low cohesion in domain layer
    

#### Rich Model

**Pros:**

- Strong encapsulation
    
- More maintainable and testable business logic
    
- Domain rules live close to the data
    

**Cons:**

- Steeper learning curve
    
- Can over-complicate simple applications
    
- Requires better object modeling skills
    

---

###  Java Examples

#### Anemic Model

```java
// Domain class
public class User {
    private String name;
    private String email;

    // Getters and setters
}

// Service class
public class UserService {
    public void registerUser(User user) {
        if (user.getEmail().contains("@")) {
            // save user to DB
        }
    }
}
```

#### 🧠 Rich Model

```java
public class User {
    private String name;
    private String email;

    public User(String name, String email) {
        if (!email.contains("@")) {
            throw new IllegalArgumentException("Invalid email");
        }
        this.name = name;
        this.email = email;
    }

    public void changeEmail(String newEmail) {
        if (!newEmail.contains("@")) {
            throw new IllegalArgumentException("Invalid email");
        }
        this.email = newEmail;
    }
}
```

---

### Rich Model Patterns

- **Factory**: Encapsulate complex object creation logic.
    
- **Builder**: Construct domain objects with many optional properties.
    
- **Strategy**: Plug in different business rules or behaviors.
    
- **Specification**: Encapsulate business rules into reusable classes.
    
- **Domain Event**: Notify other parts of the system when something important happens in a model.
    
- **Aggregate Root** (DDD): Ensure invariants inside boundaries of aggregates.
    

---

### References

- _Domain-Driven Design_ by Eric Evans
    
- Martin Fowler: [Anemic Domain Model](https://martinfowler.com/bliki/AnemicDomainModel.html)