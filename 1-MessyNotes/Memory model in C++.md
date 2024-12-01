the memory model is how C++ stores data in the host machine.
there are generally 4 types:
1. Stack Memory
2. Heap Memory
3. Data Segment
4. Code segment

#### Stack Memory:
is generally used for automatic storage duration variables , such as local variables and function call data. The stack memory is managed by the compiler , and its allocation and deallocations are done automtically.
the call stack implements tha LIFO data structure. Meaning that the most recent data allocated is the first to be deallocated.

#### Heap Memory
Heap memory is used for dynamic storage duration variables, such as objects created using the `new` keyword. The programmer has control over the allocation and deallocation of heap memory using `new` and `delete` operators. Heap memory is a larger pool of memory than the stack, but has a slower access time.

#### Data segment
The Data segment is composed of two parts: the initialized data segment and the uninitialized data segment. The initialized data segment stores global, static, and constant variables with initial values, whereas the uninitialized segment stores uninitialized global and static variables.

#### Code Segment:
The Code segment (also known as the Text segment) stores the executable code (machine code) of the program. It’s usually located in a read-only area of memory to prevent accidental modification.
