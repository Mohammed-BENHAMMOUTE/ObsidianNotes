[[Testes et Qualimetrie]]
# Black Box Testing (Software Testing)

## Core Concept
Black box testing is a software testing method that examines program functionality without looking at internal code. Think of it like testing a TV remote - you press buttons and check if it works, without knowing the electronics inside.

## Key Characteristics
- Tests are based on specifications rather than implementation
- Can begin testing before code is written
- Ensures alignment between specifications and actual behavior
- Limited in detecting subtle programming issues
- Tests focus on inputs and outputs rather than internal logic

## When to Use Black Box Testing
1. System testing
2. Integration testing
3. Unit testing
4. Early planning stages (as soon as specifications are available)

## Equivalence Partitioning

### Basic Principle
Divide input domain into finite classes where program behaves similarly for all values within each class. This reduces the number of test cases needed while maintaining effectiveness.

### Example: Age Verification Program
```markdown
Input Classes:
- Valid minors: [0-18]
- Valid adults: [18-130]
- Invalid inputs: outside [0-130] or non-integers

Output Classes:
- "Minor"
- "Adult"
- "Invalid Input"
```

### General Rules for Creating Equivalence Classes
1. **For Range Inputs:**
   - Below valid range
   - Within valid range
   - Above valid range

2. **For Set Inputs:**
   - Empty set
   - Valid values
   - Invalid values

3. **For Conditional Inputs:**
   - Condition met
   - Condition not met

## Boundary Testing

### Core Concept
Focus on testing at and around boundary values, where errors often occur.

### Key Points
- Test exactly at boundaries
- Test just inside boundaries
- Test just outside boundaries

### Common Boundary Scenarios
1. **Arrays:** Test with:
   - Empty array
   - Single element
   - n-1 elements
   - n elements
   - n+1 elements (invalid)

2. **Strings:**
   - Empty string
   - Single character
   - Maximum length -1
   - Maximum length
   - Maximum length +1

## Pairwise Testing

### Core Concept
Test combinations of input parameters in pairs rather than testing all possible combinations. This significantly reduces test cases while catching most issues.

### Benefits
- Drastically reduces number of test cases
- Catches majority of defects (most bugs involve interaction of two variables)
- More practical than exhaustive testing

### Example
```markdown
Parameters:
OS: Windows, Linux, MacOS
Browser: Chrome, Firefox
Database: MySQL, PostgreSQL

Instead of testing all 12 combinations:
Test minimum number of cases that cover all pairs of values
```

### Tools for Pairwise Testing
- Online tool: https://pairwise.yuuniworks.com/
- More tools listed at: http://www.pairwise.org

## Limitations and Considerations
1. Quality depends heavily on test case selection
2. Complete testing is impossible
3. Must balance between:
   - Test coverage
   - Cost of testing
   - Time constraints
   - Storage requirements
