[[Spring]]
## ApplicationContext Overview

- `ApplicationContext` is the main interface representing the Spring IoC container
- Responsible for instantiating, configuring, and assembling beans
- Gets instructions from configuration metadata

### Configuration Metadata Types
1. Annotated component classes
2. Java configuration classes
3. XML files
4. Groovy scripts

### Common ApplicationContext Implementations
- `AnnotationConfigApplicationContext`
- `ClassPathXmlApplicationContext`

## Configuration Approaches

### 1. Annotation-based Configuration
- Uses annotations on application classes
- Example:
  ```java
  @Service
  public class MyService {
      // Service implementation
  }
  ```

### 2. Java-based Configuration
- Uses Java classes with `@Configuration` and `@Bean` annotations
- Example:
  ```java
  @Configuration
  public class AppConfig {
      @Bean
      public MyService myService() {
          return new MyServiceImpl();
      }
  }
  ```

### 3. XML Configuration
- Uses XML files to define beans
- Example:
  ```xml
  <beans>
      <bean id="myService" class="com.example.MyServiceImpl"/>
  </beans>
  ```

### 4. Groovy Bean Definition DSL
- Uses Groovy syntax for bean definitions
- Example:
  ```groovy
  beans {
      myService(MyServiceImpl)
  }
  ```

## Using the Container

### Creating the ApplicationContext
```java
ApplicationContext context = new ClassPathXmlApplicationContext("config.xml");
```

### Retrieving Beans
```java
MyService service = context.getBean("myService", MyService.class);
```

## Best Practices
- Minimize direct use of `ApplicationContext` in application code
- Utilize dependency injection to avoid explicit bean retrieval
- Use component scanning and autowiring for cleaner code

## Key Concepts
- Beans: Objects managed by the Spring IoC container
- Dependencies: Relationships between beans
- Configuration: Instructions for the container on how to create and wire beans

## Advanced Container Usage
- Mix different configuration styles (XML, annotations, Java config)
- Use `GenericApplicationContext` for flexible configuration

Remember: The goal is to reduce coupling and increase modularity in your application by leveraging Spring's IoC container and dependency injection capabilities.