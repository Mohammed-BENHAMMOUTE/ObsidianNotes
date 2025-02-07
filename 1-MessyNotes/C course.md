
+ C gives us a way to check the size of a type or a variable: [`sizeof`](https://en.cppreference.com/w/c/language/sizeof).

+ The [`size_t` type](https://en.cppreference.com/w/c/types/size_t) is a special type that is guaranteed to be able to represent the size of the largest possible object in the target platform’s address space. It’s also the type that `sizeof` returns.

## Pragma once:
If the same header file gets included more than once, you can end up with some nasty errors caused by redefining things like functions or structs.

One simple solution (and the one we’ll use for the rest of this course) is `#pragma once`. Adding this line to the top of a header file tells the compiler to include the file only once, even if it’s referenced multiple times across your program.


1. how to avoid multiple inclusion of the same header file, which causes some bad errors: 
+  two options either use `#pragma once`.
`#pragma once`. Adding this line to the top of a header file tells the compiler to include the file only once, even if it's referenced multiple times across your program.

```c
// my_header.h
#pragma once
struct Point {
    int x;
    int y;
};
```
+ using header guards.
This method works by defining a unique [macro](https://gcc.gnu.org/onlinedocs/cpp/Macros.html) for the header file. If it’s already been included, the guard prevents it from being processed again.
``` c
#ifndef MYHEADER_H
#define MYHAEDER_H
#endif
```


## Designated Initializer

**This is my (generally) preferred way to initialize a struct.** Why?

- It’s easier to read (has the field names)
- If the fields change, you don’t have to worry about breaking the ordering

```c
int main() {
  struct City c = {
    .name = "San Francisco",
    .lat = 37,
    .lon = -122
  };
```

instead of writing structs over and over again we can simply use 
```c
struct Pastry {
	char *name;
	float weight;
};
typedef struct {
	char* name;
	float wight;
} pastry_t; // and now we can use pastry_t instead of struct Pastry
```
## memory padding:
![[Pasted image 20250206183017.png]]
There are a bunch of complicated rules and heuristics that different compilers use to determine how to lay out your structs. But to oversimplify:

1. The fields of a struct are laid out in memory contiguously (next to each other)
2. Structs can vary in size depending on how they are laid out.

As it turns out, your code probably doesn’t have direct access to the physical RAM in your computer.

Instead, your operating system provides a layer of abstraction called **virtual memory**. Virtual memory makes it seem like your program has direct access to all the memory on the machine, even if it doesn’t.

- **Physical Memory**: The actual RAM sticks in your computer.
- **Operating System**: The software that manages access to the physical memory.
- **Your Program**: When it runs, it becomes a [`process`](https://en.wikipedia.org/wiki/Process_\(computing\)) and is given access to a chunk of virtual memory by the operating system.
- **Virtual Memory**: This abstracted chunk of memory that your program can use.

_There are exceptions to this, for example if you’re using C to build embedded firmware that runs without an operating system, your code might interact directly with physical memory._
![[Pasted image 20250206191517.png]]

By only giving processes access to a chunk of virtual memory, the operating system can do some cool things:

1. **Isolation**: One process can’t access the memory of another process.
2. **Security**: The operating system can prevent processes from accessing certain parts of memory.
3. **Simplicity**: Developers don’t have to worry about managing physical memory and the memory of other processes.
4. **Performance**: The operating system can optimize memory access depending on the hardware and needs of the program. For example, by moving data between physical memory and the hard drive.

+ A pointer is declared with an asterisk (`*`) after the type. For example, `int *`.

```c
int age = 37;
int *pointer_to_age = &age;
```

+ Remember, to get the address of a variable so that we can store it _in_ a pointer variable, we can use the address-of operator (`&`).

when we have a pointer to a struct we have to use the -> operator. and not the `.` operator.
It effectively dereferences the pointer and accesses the field in one step. To be fair, you can also use the dereference and dot operator (`*` and `.`) to achieve the same result (it’s just more verbose and less common):
```c
coordinate_t point = {10, 20, 30};
coordinate_t *ptrToPoint = &point;
printf("X: %d\n", (*ptrToPoint).x);
```
**Pointer Arithmetic**:
When you add an integer to a pointer, the resulting pointer is offset by that integer times the size of the data type.
```c
int *p = numbers + 2;  // p points to the third element
int value = *p;        // value is 3
```