[[Spring]]
[[Spring Boot]]
# Spring Boot Validation Guide

## Overview
Spring Boot Validation provides robust mechanism for validating input data using Java Bean Validation (JSR 380) annotations and custom validation logic.

## Dependencies
Add the following to your `pom.xml`:
```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-validation</artifactId>
</dependency>
```

## Basic Validation Annotations

### @NotNull
- Ensures the annotated field is not null
```java
@NotNull(message = "Username cannot be null")
private String username;
```

### @Size
- Validates the size of strings, collections, maps, arrays
```java
@Size(min = 3, max = 50, message = "Name must be between 3 and 50 characters")
private String name;
```

### @NotBlank
- Validates that the annotated string is not null and contains at least one non-whitespace character
```java
@NotBlank(message = "Email cannot be blank")
private String email;
```

### @Email
- Validates that the annotated string is a valid email format
```java
@Email(message = "Invalid email format")
private String emailAddress;
```

### @Pattern
- Validates against a regular expression
```java
@Pattern(regexp = "^\\+?\\d{10,14}$", message = "Invalid phone number")
private String phoneNumber;
```

## Numeric Validations

### @Min and @Max
- Validates numeric ranges
```java
@Min(value = 18, message = "Age must be at least 18")
@Max(value = 100, message = "Age must not exceed 100")
private int age;
```

### @Positive and @Negative
- Ensures numeric values are positive or negative
```java
@Positive(message = "Price must be positive")
private BigDecimal price;
```

## Collection Validations

### @NotEmpty
- Ensures collections are not empty
```java
@NotEmpty(message = "User roles cannot be empty")
private List<String> roles;
```

### @Size for Collections
- Validates collection size
```java
@Size(min = 1, max = 5, message = "Must have 1-5 skills")
private List<String> skills;
```

## Date and Time Validations

### @Past and @Future
- Validates date/time is in the past or future
```java
@Past(message = "Birth date must be in the past")
private LocalDate birthDate;

@Future(message = "Appointment date must be in the future")
private LocalDateTime appointmentDate;
```

## Custom Validation

### Creating a Custom Validator
```java
@Target({ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = UniqueUsernameValidator.class)
public @interface UniqueUsername {
    String message() default "Username already exists";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}

public class UniqueUsernameValidator implements ConstraintValidator<UniqueUsername, String> {
    @Override
    public boolean isValid(String username, ConstraintValidatorContext context) {
        // Custom validation logic
        return !userRepository.existsByUsername(username);
    }
}
```

## Controller-Level Validation

### Using @Valid
```java
@PostMapping("/users")
public ResponseEntity<User> createUser(@Valid @RequestBody User user) {
    // Validation happens automatically
    return ResponseEntity.ok(userService.createUser(user));
}
```

### Global Exception Handling
```java
@ControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<Object> handleValidationExceptions(MethodArgumentNotValidException ex) {
        Map<String, String> errors = new HashMap<>();
        ex.getBindingResult().getFieldErrors().forEach(
            error -> errors.put(error.getField(), error.getDefaultMessage())
        );
        return new ResponseEntity<>(errors, HttpStatus.BAD_REQUEST);
    }
}
```

## Best Practices
- Always provide meaningful error messages
- Use groups for complex validation scenarios
- Combine multiple validations when needed
- Handle validation errors gracefully

## Performance Considerations
- Validation can impact performance for large requests
- Use selective validation with groups
- Consider using @Validated for method-level validations
```java
@Validated
public class UserService {
    public void processUser(@Valid User user) {
        // Method-level validation
    }
}
```

## Common Pitfalls
- Forgetting to add @Valid in controllers
- Not handling validation errors properly
- Overusing complex custom validators
- Neglecting to add validation dependency

## Pro Tips
1. Use validation groups for different scenarios
2. Combine multiple annotations for comprehensive validation
3. Create custom validators for complex business logic
4. Always validate user inputs to prevent security issues