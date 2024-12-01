understand the core features of spring frameworks:
	tightly coupled code?
	what is lose coupling?
	 Spring Beans?
	 spring framework will manage objects and wiring?
	 Group id and Artifact id are similar to package name and clase name;
	 
	 
	 tight coupling?
Tight coupling in Java refers to a scenario where classes or components are heavily dependent on each other's implementations, making them difficult to modify or extend independently. This often leads to reduced flexibility and increased difficulty in maintaining and testing the code.

	Lose coupling ?
Loose coupling using interfaces in Java means classes depend on interfaces rather than concrete implementations, improving flexibility and maintainability.

1) we have to create a configuration class with @configuration:



![[Pasted image 20240610173815.png]]
then in that configuartaion class we must add a Beans. what are beans?
after that in the app class where we have main method we have to Launch  a spring context :
![[Pasted image 20240610174029.png]]
after that we need to configure things that will be managed by precising @Bean on methods.
to retrieve those Beans managed by spring we can use:
context.getBean(name:" here should be the name of the bean"); by default its the name of the method, we can overide that by specifing the of Bean to be the name we choose.
in the method getBean we can also use classes instead of name, to get an object(use a function that returns an instance of that class). here is an example:
![[Pasted image 20240610174745.png]]
here adress is a class and i have a method attached to a bean that returns an instance of the class or record Adress.
what is a record in Java? how is it different from a class snd what are its uses?
>when we want to have an object or bean be dependant on other beans we have two choices, either we call those bean method on the return statement:
>![[Pasted image 20240610180341.png]] 
or we can pass the actual names of the beans managed by spring as arguments and just call the like they are variables and not actual functions:
![[Pasted image 20240610180504.png]]
name age address2 are the adresses of the different Spring Beans. 

DIfferent questions?
what is a spring container/spring context /IOC Container?
manages spring beans and their life cycles.
![[Pasted image 20240610185536.png]]
two popular types of  IOC Containers:
1. Bean FActory: Basic Container.
2. Application context: Advanced spring container with enterprise specific features. 
   use Application context in all cases. if you have some IOT stuff use Bean Factory instead because it consumes less memory. 

What is the difference between Java bean and Spring Bean and POJO:
POJO: plain old java object, every object is a pojo.

JavaBean? it should have a no argument constructor.(public no arg constructor).
you also need getters and setters.
it should also be serializable.
an instance of this type is called a JavaBean.


![[Pasted image 20240610190755.png]]
**How can i list all beans managed by spring framework:**
to list them and print them to the console:
we use the ``context.getBeanDefinitionNames()``. it returns an array of strings: 
we use a stream (functional programming):
![[Pasted image 20240610191514.png]]
to solve the problem of multiple candidates when using getBeans we can set a certein bein to primary so it becomes the default bean when we use the name of the class .class:
![[Pasted image 20240610192410.png]]
another solution is to use the Qualifier in the method or the bean instead of the Primary:
@Qualifier("address3qualifier");
if we pass this bean as argument and we want this bean with this exact qualifier then must pass the qualifier alongside the argument:
![[Pasted image 20240610193120.png]]
as you can see in the arguments we also pass the qualifier.

Actually the context of the spring app should be closed, there for we can use try-with resources. to automatically close the context.
![[Pasted image 20240610194507.png]]
 