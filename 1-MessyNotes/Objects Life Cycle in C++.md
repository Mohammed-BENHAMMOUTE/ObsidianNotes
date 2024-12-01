In C++, object lifetime refers to the duration an object exists, from creation to destruction. There are four main categories of object lifetime:

1. **Static Storage Duration**: Objects live for the entire runtime of the program. These include global variables, static data members, and static local variables.

```C
int global_variable;
static int; // can be inside a different scope meaning a function or class.
```

2. **Thread Storage Duration**:
   The objects can exist for the duration of the lifetime of the thread, they will be destroyed when the lifetime of the thread ends:

```C
thread_local int count;
```

3. **Automatic Storage duration**:
   Objects are created when defined and destroyed when we get out of its scope.

```cpp
void myFunction() {
  int local_var;           // Automatic storage
}
```
4. **Dynamic Storage Duration**:
the objects are created manully during runtime using the new and malloc and must be 
excplictaly destroyed with delete or free to avoid memory leaks.
```cpp
int* ptr = new int;        // Dynamic storage
delete ptr;                // Manual destruction
```