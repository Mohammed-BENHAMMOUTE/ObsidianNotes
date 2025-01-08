[[Testes et Qualimetrie]]
# JUnit 5 Testing Framework

## Understanding JUnit
JUnit is a fundamental testing framework for Java that has evolved through several versions. Think of it as a specialized toolkit that helps developers ensure their code works as intended through systematic testing.

## Architecture Overview
JUnit 5 is structured into three main components, working together like a well-oiled machine:

### Platform
- The foundation of the testing framework
- Acts as the launching pad for all test execution
- Think of it as the "operating system" for your tests

### Jupiter
- The primary testing API for JUnit 5
- Contains all the new annotations and testing utilities
- Where you'll spend most of your time writing tests

### Vintage
- Backward compatibility layer
- Allows running JUnit 3 and 4 tests within JUnit 5
- Important for maintaining legacy code

## Essential Annotations
Let's understand the lifecycle annotations that control test execution flow:

### Setup and Teardown
```java
@BeforeAll    // Runs once before ALL tests
@BeforeEach   // Runs before EACH test
@AfterEach    // Runs after EACH test
@AfterAll     // Runs once after ALL tests
```

### Test Organization
```java
@Test         // Marks a method as a test case
@DisplayName  // Provides a custom name for test display
@Tag          // Categorizes tests (useful for filtering)
@Disabled     // Temporarily skips a test
```

## Assertions Framework
JUnit 5 provides a robust set of assertion methods to verify your code's behavior:

### Basic Assertions
```java
// Core assertions
assertEquals(expected, actual)      // Compare equality
assertTrue(condition)               // Verify true condition
assertFalse(condition)             // Verify false condition
assertNull(object)                 // Verify null
assertNotNull(object)              // Verify not null

// Object assertions
assertSame(expected, actual)       // Verify same object reference
assertEquals(expected, actual)      // Verify equal content

// Collection assertions
assertArrayEquals(expected, actual) // Compare arrays
assertIterableEquals(expected, actual) // Compare iterables
```

### Advanced Assertions
```java
// Multiple assertions in one test
assertAll(
    () -> assertEquals(expected1, actual1),
    () -> assertEquals(expected2, actual2)
);

// Exception testing
assertThrows(ExpectedException.class, 
    () -> methodThatShouldThrow());
```



with assertEquals(Object, Object), if the objects do not override the equal operator in memory then assertEquals chceks if the elements are the same in memory, it compares references.


assertSame checks if the rwo objects reference the same area in memory!!
the assertSame compares using the == comparator, on the other hand we have to use assertEquals to check for the using the equal() method, if its is not overrded in the class, then asserEquals will compare references, otherwise we can override the .equal so we can compare the actual objects.

## Advanced Testing Features

### Parameterized Tests
Allows running the same test multiple times with different inputs:

```java
@ParameterizedTest
@ValueSource(ints = {1, 2, 3, 4, 5})
void parameterizedTest(int input) {
    assertTrue(input > 0);
}
```

### Repeated Tests
Useful for testing consistency or random behavior:

```java
@RepeatedTest(value = 10, 
    name = "{displayName} #{currentRepetition}")
void repeatedTest() {
    // Test code that runs 10 times
}
```

## Best Practices

1. **Test Isolation**
   - Each test should run independently
   - Avoid test interdependencies
   - Use @BeforeEach for clean test state

2. **Naming Conventions**
   - Use clear, descriptive test names
   - Follow pattern: methodName_scenario_expectedBehavior
   - Utilize @DisplayName for readable test reports

3. **Assertion Strategy**
   - Test one concept per test method
   - Use assertAll for related assertions
   - Include meaningful failure messages

## Integration with Build Tools

### Maven Integration
```xml
<dependency>
    <groupId>org.junit.jupiter</groupId>
    <artifactId>junit-jupiter</artifactId>
    <version>5.8.2</version>
    <scope>test</scope>
</dependency>
```

### IDE Support
- Native support in major IDEs:
  - Eclipse
  - IntelliJ IDEA
  - NetBeans

## Links
Create these as separate Obsidian notes for deeper exploration:
- [[Test Driven Development with JUnit]]
- [[JUnit Best Practices]]
- [[Advanced JUnit Features]]
- [[JUnit vs Other Testing Frameworks]]
- [[Migrating from JUnit 4 to 5]]

## Resources
- Official Documentation: https://junit.org/junit5/docs/current/api/
- Source Code Examples: https://stackabuse.com/unit-testing-in-java-with-junit-5/