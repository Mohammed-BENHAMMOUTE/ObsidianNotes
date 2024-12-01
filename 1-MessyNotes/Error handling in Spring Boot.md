[[Spring]]
we  can use predefined classes that extends Runtime exception.
and here is an example:
```java 
public findOne(int id) {
	Predicate< ? super User> predicate = user -> user.getId().equals(id);
	return users.stream().filter(predicate).getFirst().orElse(null);
}
```

the orElse() if the element is present then it returns it otherwise it returns the object taken as parameter.

``` java 
//userRessource.java(rest controller)
@GetMapping("users/{id}")
public User getUser(@PathVariable int id) throws UserNotFoundException {
	User user = service.findOne(id);
	if(user == null) {
		throw new UserNotFoundException("id: " + id);
	};
	return user;
}
```

```java
@ResponseStatus(code = HttpStatus.NOT_FOUND)
public class UserNotFoundException extends RunTimeException {
	public UserNotFoundException(String message) {
		super(message);
	}
}
```

we can make this simpler by doing the following:

```java
@GetMapping("users/{id}")
public User getUser(@PathVariable int id) throws UserNotFoundException {
	return service.findOne(id).orElseThrow(()-> new UserNotFoundException("message"));
}
```

