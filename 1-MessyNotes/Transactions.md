[[Spring]]

---

# Transactions in Spring Boot

## Introduction

Spring Boot provides robust transaction management to ensure data consistency in applications. You can manage transactions declaratively using annotations or programmatically using the `TransactionTemplate`.

---

## Key Annotations

### 1. `@Transactional`

- Declares a method or class as transactional.
- Attributes:
    - `propagation`: Defines transaction boundaries.
        - Common options:
            - `REQUIRED` (default): Joins an existing transaction or creates a new one.
            - `REQUIRES_NEW`: Suspends the current transaction and starts a new one.
    - `isolation`: Manages isolation levels.
        - Options: `DEFAULT`, `READ_COMMITTED`, `REPEATABLE_READ`, `SERIALIZABLE`, etc.
    - `rollbackFor`: Rollback for specified exceptions (e.g., `rollbackFor = Exception.class`).
    - `readOnly`: Marks the transaction as read-only.

---

## Example 1: Declarative Transaction Management

### Basic Usage

```java
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class MyService {
  
  @Transactional
  public void performTransaction() {
      // Business logic here
  }
}
```

### Handling Rollback

```java
@Transactional(rollbackFor = Exception.class)
public void performTransaction() {
    try {
        // Business logic
    } catch (SpecificException e) {
        throw new RuntimeException(e); // Ensures rollback
    }
}
```

---

## Example 2: Programmatic Transaction Management

### Using `TransactionTemplate`

```java
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.support.TransactionTemplate;

@Service
public class MyService {

    @Autowired
    private TransactionTemplate transactionTemplate;

    public void performTransaction() {
        transactionTemplate.execute(status -> {
            // Business logic here
            // Rollback manually with status.setRollbackOnly();
            return null;
        });
    }
}
```

---

## Advanced Topics

### Nested Transactions

- Achieved using `Propagation.NESTED`.
- Useful for rollback of inner operations without affecting the outer transaction.

### Exception Handling

- **Checked Exceptions**: Won't trigger rollback unless explicitly declared.
- **Unchecked Exceptions**: Automatically trigger rollback.

### Read-Only Transactions

- Improves performance for queries.

```java
@Transactional(readOnly = true)
public List<Entity> fetchEntities() {
    return repository.findAll();
}
```

---

## Troubleshooting

1. **Transaction Not Working?**
    
    - Ensure the annotated class/method is a Spring-managed bean.
    - Verify `@EnableTransactionManagement` is enabled in the configuration (automatically enabled in Spring Boot).
2. **LazyInitializationException?**
    
    - Ensure the transaction boundary is properly defined around lazy-loaded entities.

---

## Best Practices

1. Minimize transaction duration.
2. Use `@Transactional` at the service layer, not the controller.
3. Always test for edge cases (e.g., rollback scenarios).
4. Log transaction behavior for debugging and auditing.

---

Feel free to tweak this structure in Obsidian for personal preferences!