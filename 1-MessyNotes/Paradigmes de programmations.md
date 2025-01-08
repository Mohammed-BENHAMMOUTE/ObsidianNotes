[[Paradigmes de programmations]]
# Programming Paradigms
Created: 2025-01-08

## Course Structure
- TP (Practical Work): 20%
  - Real-world use cases
  - Individual evaluation
- Exam: 80%
  - Duration: 45-90 minutes
  - 30-60 questions
  - Format: MCQ or Case Study

## Key Quote
> "The tools we use have a profound and devious influence on our thinking habits, and therefore on our thinking abilities" - Dijkstra

## Programming Paradigm Definition
A programming paradigm is a specific approach to problem-solving in programming, characterized by:
- Defines how to write and structure code
- Shapes programmer's vision of the solution
- Includes specific concepts, methods, and techniques

## Programming Styles
### Compilation Approaches
- **Compiled**: Translates source code to binary (C, C++)
- **Interpreted**: Directly executed by engine (Python, JavaScript)

### Type Systems
- **Static Typing**: Type checking at compilation (Java, C#)
- **Dynamic Typing**: Type checking at runtime (Python, Ruby)

### Memory Management
- **Unmanaged**: Manual memory management (C, C++)
- **Managed**: Automatic memory management (Java, C#)

## Major Paradigms

### 1. Imperative Programming
#### Core Concepts
- Sequential execution
- Mutable state
- Explicit control structures (loops, conditionals)

#### Advantages
- Simple syntax
- Flexible
- Easy debugging

#### Disadvantages
- Complex at scale
- Difficult concurrency
- Mutable state risks

#### Use Cases
- Operating systems
- Embedded programming
- Sorting/searching algorithms

### 2. Functional Programming
#### Core Concepts
- Pure functions
- Immutability
- Lazy evaluation

#### Advantages
- Predictable code
- High expressiveness
- Fewer errors

#### Disadvantages
- Complex interoperability
- Higher memory usage
- Overkill for simple tasks

#### Use Cases
- Immutable data processing
- Parallel applications
- Data-driven programming

### 3. Logic Programming
#### Core Concepts
- Rule-based
- Inference mechanisms
- Declarative approach

#### Advantages
- High abstraction
- Formal verification
- Automatic resolution

#### Disadvantages
- Integration difficulties
- Performance limitations
- Limited practical applications

#### Use Cases
- Artificial Intelligence
- Automated reasoning
- Puzzle generators

### 4. Event-Driven Programming
#### Core Concepts
- Event handling
- Listeners
- Asynchronous operations

#### Advantages
- Reactive
- Decoupled components
- Easy decomposition

#### Disadvantages
- Control flow complexity
- Concurrency challenges
- Bottleneck risks

#### Use Cases
- GUIs
- Interactive web apps
- Video games

### 5. Reactive Programming
#### Core Concepts
- Data streams
- Automatic propagation
- Backpressure management

#### Advantages
- Scalability
- Resilience
- Adaptability

#### Disadvantages
- Specialized tools needed
- Complex architecture
- Difficult debugging

#### Use Cases
- Real-time applications
- Interactive UIs
- Distributed systems

## Choosing the Right Paradigm

### Scenario Guidelines
1. **Sequential Operations with Intermediate Results**
   - Choose: Imperative
   - Why: Best for step-by-step operations and state management

2. **Complex Problems Requiring No Side Effects**
   - Choose: Functional
   - Why: Ensures data immutability and mathematical function approach

3. **Interactive UI with User Actions**
   - Choose: Event-Driven
   - Why: Efficient handling of user interactions and screen updates

4. **Relationship-Based Systems (e.g., Family Trees)**
   - Choose: Logic
   - Why: Excellent for representing facts and rules with inference capabilities

## Links and Resources
- [[Imperative Programming]]
- [[Functional Programming]]
- [[Logic Programming]]
- [[Event-Driven Programming]]
- [[Reactive Programming]]

#programming #paradigms #computer-science #exam-prep