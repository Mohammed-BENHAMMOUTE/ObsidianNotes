[[C++]]
Pointers and dynamic memory:
how to work with it?
the memory assigned to a program can be divided into three parts.
1. Code(Text) : Instructions
2. Static/Global
3. Stack
4. Heap

the size of the stack frame in the stack of each method is calculated when the program is compiling.
at any time , the function at the top of the stack  is executing and the others bellow it are paused.

if we surpass the memory allocated to the stack we will get a **stack overflow** and the program will crash.
for example infinite recursion.

when the functions starts its added to top of the stack , and when it finishes(returns) then its popped.

**Heap:**
the size of the heap is not fixed and can vary depending on the program and the memory used by it.
heap = Free pool of memory / Dynamic memory.
using the heap  is called dynamic memory allocation.
Heap is also a data structure. it has nothing to do with this pool of memory.
but the stack is actually a stack.

### To use dynamic memory in C or C++:
**C:**
malloc
calloc
realloc
free
// can also be used in C++(Backward Compatibility)
 **C++:**
new 
delete
```Cpp
#include<stdio.h>
#include<stdlib.h>
int main()
{
	int a;
	int* p;
	p = (int*) malloc(sizeof(int));//malloc returns a void pointer.
	*p = 10;
	free(p);
	p = (int*)
	
}
```
when we allocate something to the heap its not automatically deallocated like in the stack. we have ti deallocate them using free();
the pointer will point to the base address.
if the malloc cannot allocate memory then it will return null.
in c++ we can you new and delete.

```Cpp
#include<stdio.h>
#include<stdlib.h>
int main()
{
	int a;
	int* p;
	p  = new int;
	*p = 10;
	delete p;
	p = new int[10];
	delete[] p;
}
```

## Libraries for memory allocations:
+ malloc `void* malloc(size_t size)`, size_t is unsigned integer.

+ calloc `void* calloc(size_t num , size_t size)` 
the difference between the malloc and calloc is that one initializes the the memory allocated to 0 (calloc) while the other doesnt initialize the memory allocated there. so you will find some garbage there.

+ realloc `void* realloc(void* ftr , size_t size)`,  
its purpose is to realocate memory in the heap , we give it the pointer to the memory we created using malloc or calloc, and the new size of it.


```Cpp
#Include<Stdio.h>
int main() {
	int n; 
	printf("Enter size of array\n");
	scanf("%d" , &n);
	int* A = (int*) malloc(n*sizeof(int));
	for(int i = 0 ; i <n ; i++) {
		A[i] = i+1;
	}
	for(int i = 0; i < n ;i++) {
		printf("%d", A[i]);
	}
	// we can also do something like this:
	int* A = (int*) calloc(n , sizeof(int));
	// we will get an initialized array of int with the value 0;
	for(int i = 0; i < n ; i++) 
	{
		printf("%d" , A[i]);
	}
}
```

How the reallocate method works?
if the new size is greater than the previous size then if possible the memory area is extended directly. otherwise the content of the memory is copied and passed to the another block of memory using the new desired size and the previous memory will be deallocated.
if we use `int *B = (int*) realloc(A,0)` then the entire block will be deallocated, it will beequivilant to `free(A)`.

if we do `int* B = (int*) realloc(NULL, n.sizeof(int))`, this is equivalent to `malloc`
