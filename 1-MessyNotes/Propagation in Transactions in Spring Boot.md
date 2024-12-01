[[Transactions]]
[[Spring]]

### **Propagation in Transactions in Spring Boot**

Propagation defines how the boundaries of a transaction behave when one transactional method calls another transactional method. It dictates whether the called method should run within the existing transaction or create a new one.

---

### **Propagation Types**

Spring provides several types of propagation, each suitable for different use cases. Here's a detailed explanation of each:

---

### 1. **`REQUIRED` (Default)**

- **Behavior**:
    - If a transaction exists, the method will join the existing transaction.
    - If no transaction exists, it creates a new one.
- **Use Case**: Common for most operations where participation in an existing transaction is desirable.

**Example**:

```java
@Transactional(propagation = Propagation.REQUIRED)
public void processOrder() {
    // Joins the existing transaction or starts a new one
    orderRepository.save(order);
}
```

---

### 2. **`REQUIRES_NEW`**

- **Behavior**:
    - Suspends the current transaction (if any) and creates a new transaction.
- **Use Case**: For operations that must be executed in a separate, independent transaction (e.g., logging or audit).

**Example**:

```java
@Transactional(propagation = Propagation.REQUIRES_NEW)
public void logAudit() {
    // Independent transaction for logging
    auditRepository.save(auditEntry);
}
```

**Scenario**:

```java
@Transactional
public void processOrder() {
    orderRepository.save(order); // Main transaction
    logAudit(); // Executes in a new, independent transaction
    // Main transaction continues
}
```

---

### 3. **`NESTED`**

- **Behavior**:
    - Executes within a nested transaction if a parent transaction exists.
    - Rollbacks in the nested transaction don't affect the parent transaction.
- **Use Case**: When you need a sub-transaction within a parent transaction.

**Example**:

```java
@Transactional(propagation = Propagation.NESTED)
public void updateInventory() {
    // Sub-transaction within the parent transaction
    inventoryRepository.update(stock);
}
```

**Rollback Behavior**:

- If the nested transaction fails, the parent transaction can decide whether to rollback entirely.

---

### 4. **`SUPPORTS`**

- **Behavior**:
    - Runs within an existing transaction if available.
    - Runs non-transactionally if no transaction exists.
- **Use Case**: For optional transactional behavior, such as read-only operations.

**Example**:

```java
@Transactional(propagation = Propagation.SUPPORTS)
public List<Product> getProducts() {
    return productRepository.findAll(); // Works with or without a transaction
}
```

---

### 5. **`NOT_SUPPORTED`**

- **Behavior**:
    - Suspends any existing transaction and runs non-transactionally.
- **Use Case**: For operations that must not run in a transactional context.

**Example**:

```java
@Transactional(propagation = Propagation.NOT_SUPPORTED)
public void sendNotification() {
    // No transaction here
    notificationService.send(notification);
}
```

---

### 6. **`MANDATORY`**

- **Behavior**:
    - Requires an existing transaction; throws an exception if no transaction exists.
- **Use Case**: When the operation must always be part of a transaction.

**Example**:

```java
@Transactional(propagation = Propagation.MANDATORY)
public void validateOrder() {
    // Throws an exception if no transaction exists
    if (order.isInvalid()) {
        throw new RuntimeException("Invalid order");
    }
}
```

---

### 7. **`NEVER`**

- **Behavior**:
    - Throws an exception if a transaction exists.
- **Use Case**: For operations that must strictly not run in a transactional context.

**Example**:

```java
@Transactional(propagation = Propagation.NEVER)
public void clearCache() {
    // Error if a transaction exists
    cacheManager.clear();
}
```

---

### 8. **`DEFAULT`**

- **Behavior**:
    - Uses the default propagation behavior of the underlying transaction manager (usually `REQUIRED`).
- **Use Case**: For most common scenarios when explicit propagation isn't needed.

---

### **How Propagation Works in Nested Method Calls**

Consider the following example:

```java
@Service
public class OrderService {
    @Transactional(propagation = Propagation.REQUIRED)
    public void processOrder() {
        orderRepository.save(order); // Part of the main transaction
        inventoryService.updateInventory(); // Depends on its own propagation type
    }
}

@Service
public class InventoryService {
    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public void updateInventory() {
        inventoryRepository.update(stock); // Runs in a new, independent transaction
    }
}
```

#### Behavior:

1. `processOrder()` starts a transaction.
2. `updateInventory()` runs in a new transaction (`REQUIRES_NEW`), independent of `processOrder()`'s transaction.
3. If `updateInventory()` fails, its transaction is rolled back without affecting the transaction of `processOrder()`.

---

### **Choosing the Right Propagation**

1. Use `REQUIRED` for most operations.
2. Use `REQUIRES_NEW` for isolated operations (e.g., logging, notifications).
3. Use `NESTED` for sub-transactions that may need independent rollback.
4. Avoid using `NEVER` and `NOT_SUPPORTED` unless absolutely necessary.

---
