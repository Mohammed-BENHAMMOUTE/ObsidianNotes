[[java]]
[[Interview Prep]]

Arrays in java are actually objects. For Primitive types arrays are stored in a contiguous memory location.
for non primitive types, references of the objects are stored in a contigues memory location but the actual objects are stored elsewhere.

`Arrays in java are stored in the heap`, since arrays are objects and objects are stored in the Heap.

we can declare an array with array literals.
```java
int[] integers = new int[]{1,3,4,5,6,7};
```


Java is passed by value:
1. for primitives we simply pass by value.
2. for Objects we pass by value the references to the object pass, so both references points to the same object in memory, and modifying the object through the second reference will cause the object to change for the first reference as well.


### Cloning an Array:

```java

class Test {
    public static void main(String args[])
    {
        int intArray[] = { 1, 2, 3 };
        int cloneArray[] = intArray.clone();
        // will print false as shallow copy is created
        System.out.println(intArray == cloneArray);
        for (int i = 0; i < cloneArray.length; i++) {
            System.out.print(cloneArray[i] + " ");
        }
    }
}
```

`One dimensional array`: shalow clone
when u clone an array, if it is made of primitive types then the cloning is complete, the new array will contain all the contents of the original array but in different memory location.

on the other hand if the array is made of Non-promitive types then when cloning, a new array is made but its content will have refenrences to the objects stored in the original array.  