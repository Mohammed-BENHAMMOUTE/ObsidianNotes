[[Spring Boot]]

## How are our requests are handled in Spring boot
Spring boot uses what is called the DispatcherServelet (Front Controller Pattern).
DispatcherServelet is configured through springs Auto Configuration( DispatcherServeletAutoConfiguration ) that looks into the class path and detect the corresponding files that handles the incoming requests.

## How are objects returned in the Rest Controller are converted to Json?

When using the `@RestController` annotation on a class, it automatically applies the `@ResponseBody` behavior to all the methods within the class. This ensures that any object returned from the controller methods is automatically serialized into JSON (or another format like XML, depending on the client’s request).

Spring uses **Jackson's `MappingJackson2HttpMessageConverter`** by default to convert Java objects into JSON. You don’t need to manually configure this unless you want to use a different converter.

Here’s an example of a method in a `@RestController`:

```java
@RestController
public class MyController {

    @GetMapping(path = "/hello-world")
    public HelloWorldBean getHelloWorldBean() {
        // The returned HelloWorldBean will automatically be converted to JSON
        return new HelloWorldBean("Hey there");
    }
}

```