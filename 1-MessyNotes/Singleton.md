[[Creational Design Patterns]]
### what is singleton design pattern ?
is a creational design pattern a that ensure that a class has only one instance while providing  a global access point to this instance.

### What does the singleton design pattern tries to solve?
The singleton design pattern solves two problems at the same time, violating the single responsibility Principle.
1. `Ensure that a class has only one instance` : this is very common when dealing with shared ressources, database or a file.
so the general behaviour or the singleton design pattern is that if an object is already created previously, it will return a reference to that object.

this behavior is impossible to implement with a regular constructor. since constructor calls must always return a new object by design.
![[Pasted image 20241026085900.png]]

2. `Provide a global access point to that instance`:
the singleton pattern lets you access some objects from anywhere in the program. However it also protects the instance from being overwritten by other code.


### Solution:
any implementation of the singleton pattern have two essential things in Common:
1. make the default `constructor private`. to prevent any use of the new keyword, and hitherto creating objects in an  controlled manner.
2. create a static method that will act as constructor of the class. under the hood it, when this method is called for the first time, it will call the private constructor to create a new Object since there are no previous objects, after that it sets that newly created object and puts it in a static class variable. So when the method based-constructor is called again , it will return that static class variable(the object previously created).
![[Pasted image 20241026092100.png]]

The `singleton` constructor should be hidden from the client code.Calling the getInstance should be the only method to get a new singleton object.


### When to use this design pattern ?
+ Use the Singleton pattern when a class in your program should
have just a single instance available to all clients; for exam-
ple, a single database object shared by different parts of the
program.

+ when we need stricter control over the global variables we can use the singleton object, as the only object capable of modifying these variables. opposed to if we just put these global variables where there everybody can modify them.


### How to implement the singleton design pattern?
1. add a private static field to the class that will hold the instance when its created.
2. Declare a public static creation method for getting the single-
ton instance.
3. Implement “lazy initialization” inside the static method. It
should create a new object on its first call and put it into the
static field. The method should always return that instance on
all subsequent calls.
4. Make the constructor of the class private. The static method of
the class will still be able to call the constructor, but not the
other objects.
5. Go over the client code and replace all direct calls to the sin-
gleton’s constructor with calls to its static creation method.


###  Pros :
1. Only one instance of that class.
2. gain a global access point to that instance.
3. the singleton is initialized only when its requested for the first time.
### Cons:
1. Violates the single responsibilty principle, it solves two problems at the same time. 
2. The pattern requires special treatment in a multithreaded
environment so that multiple threads won’t create a singleton
object several times.
