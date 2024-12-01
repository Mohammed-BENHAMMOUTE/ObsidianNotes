[[C++]]
### Ampersand Reference:
a reference is a constant pointer which always points to references a the same object.They are declared using the ampersand &.
```C
int a = 10;
int& ref = a;
```

a reference variable is an alias, that is another name for an already existing variable. A reference, like a pointer, is also implemented by storing the address of an object. 

as said before, A reference can be thought of as a constant pointer (not to be confused with a pointer to a constant value!) with automatic indirection, the compiler will apply the * operator for you. note that in C, there was no references , just pointers, so C++ introduced references to handle the de-referencing problem.

we have to declare and initialise a reference in tha same step:

```C
int a = 10;  
int &p = a; // It is correct  
// but  
int &p;  
p = a; // It is incorrect as we should declare and initialize references at single step
```

a reference cannot be re-assigned, and must be assigned at initialization.
### Pointers:
a pointer is variable that holds the memory address of another variable. A pointer needs to be dereferenced with the* operator to access the memory location it points to.
```C
int i = 9;
int* ptr = &i;
int& ref = i;
```
![[Pasted image 20241015172935.png]]