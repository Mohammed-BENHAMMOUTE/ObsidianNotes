[[Programming pradigmes]]

## Programmation AOP
seperation of concerns is the driving force.
transverse = se repete sur different application. things we need a lot for all the business applications.

before we had these functionalities inside our business code (source code).
with aop we can seprate the concerns and focus on the special functionalities that our service offers rather than rewriting a whole source code for different functionality like auth logging and monitoring.

cross cutting concerns: how why what?
why?
1. reduction de la deplication de code 
2. simplification de maintenane.
3. flexibilite
**AOP est une extension de OOP**

EXAMPLE:
```java
@LogExecution
public void processOrder() {
	//Logique metier
}

// in another file of configuration:
class config {
	@before
}
```

key concepts of AOP:
1. Aspect ?.
2. advice ?.
3. joinpoint : des information sur des methode qui declanche.
4. pointcut ?.

## proceedingJoint

different types of advice:
1. @Before.
2. @After.
3. @AfterReturning.
4. @AfterThrowing.
5. @Around bad for performance  ProceedingJointPoint.


differents types de JoinPoints: 
methode , constructeur ...?



pointcut? 
HoF ? higher order functions?
pull  in Java? why how and what ,  examples??!!
pool in java?
push methods in java?
proxy design pattern ?

