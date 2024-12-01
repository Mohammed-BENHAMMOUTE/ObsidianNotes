[[Spring Boot]]

instead of the annotation `@Value` we can use instead `@ConfigurationProperties(prefix="greeting")` which is better and type safer.
first we have to add a scan Annotation for the in the main Spring application class:
```java
@SpringApplication
@ConfigurationPropertiesScan
public class SburRestDemoApplication {
	public static void main(String[] args){
		SpringApplication.run(SburRestDemoApplication.class, args)
	};
}
```

```java
@ConfigurationProperties(prefix= "greeting")
class Greeting  {
	private String name;
	private String coffee;
	public String getName(){};
	....
}
```

we need to add the following dependency :
enabling the IDE to connect the dots between `@ConfigurationProperties` classes and related properties defined in the _application.properties_ file:

```xml
<dependency>
	<groupId>org.springframework.boot</groupId>  <artifactId>spring-boot-configuration-processor</artifactId> <optional>true</optional> 
	</dependency>
```

now we should get something like this :
![[Pasted image 20240904124024.png]]