[[Spring]]
[[Spring Boot]]

1. **@Transactional**:
	   when we want a method to have a transaction behavior of a method we can, annotate that method with the @transactional, if we annotate a class as transactional then all the methods inside of it will be annotated transactional automatically.
2. **@Param**:
   we can pass named params to our queries using the @Param annotation.
```java
@Query("FROM person p WHERE p.name= :name")
Person findByName(@Param("name") String name);
```
3. @Id:
	
	```java
	
	```
