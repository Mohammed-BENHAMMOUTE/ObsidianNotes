[[System design]]
## Definition
N-Tier architecture (also known as Multi-Tier architecture) is a client-server software design pattern where presentation, application processing, and data management functions are physically separated.

## Key Characteristics
- **Logical Separation**: Divides an application into distinct layers
- **Scalability**: Allows independent scaling of individual layers
- **Maintainability**: Easier to modify or replace specific layers without affecting others

## Common Tier Configurations

### 3-Tier Architecture (Most Common)
1. **Presentation Tier** (UI Layer)
   - Handles user interactions
   - Displays data to the user
   - Collects user inputs

2. **Application/Business Logic Tier**
   - Processes business rules
   - Manages application logic
   - Coordinates between presentation and data layers

3. **Data Tier**
   - Manages data storage
   - Handles database operations
   - Provides data access methods

### 4-Tier Architecture
Adds an additional service tier between application and data tiers for more complex systems.

## Advantages
- Enhanced security
- Better performance through distributed computing
- Improved modularity
- Easier maintenance and updates

## Challenges
- Increased complexity
- Potential performance overhead
- More challenging initial design

## Best Practices
- Keep layers loosely coupled
- Define clear interfaces between layers
- Minimize direct dependencies
- Use appropriate design patterns

## Example Technologies
- **Presentation**: React, Angular, Vue.js
- **Business Logic**: Spring Boot, .NET Core, Express.js
- **Data**: MySQL, PostgreSQL, MongoDB

## When to Use
- Enterprise-level applications
- Systems requiring high scalability
- Applications with complex business logic
- Projects needing clear separation of concerns

## Related Patterns
- Microservices Architecture
- Clean Architecture
- Hexagonal Architecture

## References
- Domain-Driven Design by Eric Evans
- Clean Architecture by Robert C. Martin