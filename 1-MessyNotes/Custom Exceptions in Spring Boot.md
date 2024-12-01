[[Spring]]
when we want to have custom expections with different json structure than the difault one. remember  its bad to send 500 code to the user so its better to use custom exceptions.

So what we do is :
1. we define a class that extends the runtimeException and use the runtime exception constructor to pass in the massage, there are multiple constructors that can be used. 
2. Define the the class ExceptionDetails with the new structure of the error message.
3. Create a class for exception handling. with annotaion `@ControllerAdvice`
4. in that class create a method that returns the response entity of with that new object , this method must be annotated with `@ExceptionHandler(value = {ApiRequestException.class})`
5. in this method you will have to return the object of the class where you defined the schema of the new Error.
## Example

```java
public class ApiException {
	private final string name;
	private final Throwable throwable; // don  use this in actual Exception calsses
	private final HttpStatus httpStatus;
	private final ZonedDateTime timestamp;
	// getter and ALlARgsConstructor
}
```

``` java
@ControllerAdvice
public class ApiExceptionHandler(ApiRequestException e){
	@ExceptionHandler(value = {ApiRequestException.class})
	public ResponseEntity<Object> handleApiRequestException(ApiRequestException){
// 1. Create payload creating exception details
		ApiException error = new ApiException(
			e.getMessage(), 
			e,
			HttpStatus.BAD_REQUEST, 
			ZonedDateTime.now(ZoneId.of("Z"))
		)
	// 2. REturn the response Entity
			return new ResponseEntity<ApiException>(apiException , badRequest);
	
	}
}
```