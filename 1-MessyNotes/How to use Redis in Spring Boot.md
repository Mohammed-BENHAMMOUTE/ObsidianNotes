[[Spring]]
Redis is an in-memory data structure store that can be used as a database, cache, message broker, and queue. Here's a step-by-step guide to integrate and use Redis in a Spring Boot application:

1. Add Redis dependency:
   Add the following to your pom.xml (for Maven):

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-redis</artifactId>
</dependency>
```

2. Configure Redis connection:
   In your application.properties or application.yml file:

```properties
spring.redis.host=localhost
spring.redis.port=6379
```

3. Create a Redis configuration class:

```java
@Configuration
public class RedisConfig {

    @Bean
    public RedisTemplate<String, Object> redisTemplate(RedisConnectionFactory connectionFactory) {
        RedisTemplate<String, Object> template = new RedisTemplate<>();
        template.setConnectionFactory(connectionFactory);
        template.setKeySerializer(new StringRedisSerializer());
        template.setValueSerializer(new Jackson2JsonRedisSerializer<>(Object.class));
        return template;
    }
}
```

4. Create a model class to store in Redis:

```java
public class User implements Serializable {
    private String id;
    private String name;
    private String email;

    // Constructors, getters, and setters
}
```

5. Create a Redis repository:

```java
@Repository
public class UserRedisRepository {

    private final RedisTemplate<String, User> redisTemplate;
    private static final String KEY = "USER";

    @Autowired
    public UserRedisRepository(RedisTemplate<String, User> redisTemplate) {
        this.redisTemplate = redisTemplate;
    }

    public void save(User user) {
        redisTemplate.opsForHash().put(KEY, user.getId(), user);
    }

    public User find(String id) {
        return (User) redisTemplate.opsForHash().get(KEY, id);
    }

    public List<User> findAll() {
        return redisTemplate.opsForHash().values(KEY);
    }

    public void delete(String id) {
        redisTemplate.opsForHash().delete(KEY, id);
    }
}
```

6. Use the Redis repository in a service:

```java
@Service
public class UserService {

    private final UserRedisRepository userRedisRepository;

    @Autowired
    public UserService(UserRedisRepository userRedisRepository) {
        this.userRedisRepository = userRedisRepository;
    }

    public void saveUser(User user) {
        userRedisRepository.save(user);
    }

    public User getUser(String id) {
        return userRedisRepository.find(id);
    }

    public List<User> getAllUsers() {
        return userRedisRepository.findAll();
    }

    public void deleteUser(String id) {
        userRedisRepository.delete(id);
    }
}
```

7. Use the service in a controller:

```java
@RestController
@RequestMapping("/users")
public class UserController {

    private final UserService userService;

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    @PostMapping
    public void createUser(@RequestBody User user) {
        userService.saveUser(user);
    }

    @GetMapping("/{id}")
    public User getUser(@PathVariable String id) {
        return userService.getUser(id);
    }

    @GetMapping
    public List<User> getAllUsers() {
        return userService.getAllUsers();
    }

    @DeleteMapping("/{id}")
    public void deleteUser(@PathVariable String id) {
        userService.deleteUser(id);
    }
}
```

8. Using Redis for caching:
   Spring Boot makes it easy to use Redis as a cache. Add the following dependency:

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-cache</artifactId>
</dependency>
```

Then, enable caching in your main application class:

```java
@SpringBootApplication
@EnableCaching
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}
```

Now you can use caching annotations in your service methods:

```java
@Service
public class UserService {
    // ...

    @Cacheable(value = "users", key = "#id")
    public User getUser(String id) {
        // This will be cached in Redis
        return userRedisRepository.find(id);
    }

    @CachePut(value = "users", key = "#user.id")
    public User saveUser(User user) {
        userRedisRepository.save(user);
        return user;
    }

    @CacheEvict(value = "users", key = "#id")
    public void deleteUser(String id) {
        userRedisRepository.delete(id);
    }
}
```

This guide covers the basics of using Redis with Spring Boot for both data storage and caching. Remember to have a Redis server running on your local machine or configure the connection to point to your Redis instance.

Would you like me to explain any part of this in more detail?