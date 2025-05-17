[[java]]
[[Interview Prep]]

There are 4 different types of references in java:

### 1. Strong reference:
A strong reference is the default reference in Java, the memory used cannot be garbage collected as long as there is a strong reference pointing to it. 

`The object can’t be garbage collected if it’s reachable through any strong reference.`
example:
```java
List<String> list = new ArrayList<>;
```
the garbage collector cant collect this list because we have a strong reference pointing to it.

```java
list = null; // now the arraylist object can be garbage collected.
```

so as long as the reference still holds a non null object, and the reference is reachable, the object is not garbage collected.


#### but is this enough?
sometimes we need to garbage collect objects and deallocate memory even if a reference to that object still exists.


# Soft References:

a soft reference gives the garbage collector the power to choose when this object is collected, the object can stay in memory for some time until the collector decides that he needs ro collect it. That'll happen, especially when JVM is at risk of running out of memory. 


to declare a softreference we can use the following syntax:
```java 
SoftReference<List<String>> listReference = new SoftReference<List<String>>(new ArrayList<String>());
```

to retrieve this object we have to check for it:

```java
List<String> list = listReference.get();
if(list == null) 
{
	// object was already cleared.
}
```

`use case:`
we can use soft references to make our applications resilient to errors connected to insufficient memory. for example we can create a memory-sensitive cache that automatically evicts objects when memory is scarce. We wouldnt need to manage as the garbage collector would do it for us.


# Weak references:
Objects referenced only by weak references aren't prevented from being collected. From the perspective of the garbage collection. they could not exist at all. if a weakly referenced object should be protected then it should be referenced by some hard reference.


so the key take a way here is that weak references are collected at the next GC() cycle,
if the objects has no other strong reference to it.

### **Key Differences**

|**Aspect**|**Soft References**|**Weak References**|
|---|---|---|
|**Garbage Collection**|Collected only when the JVM is low on memory.|Collected eagerly, during the **next GC cycle** (if no strong references exist).|
|**Use Case**|Memory-sensitive caching.|Avoiding memory leaks in metadata or auxiliary data.|
|**Aggressiveness**|Retained longer (until memory pressure).|Collected immediately when no strong references.|
|**Class**|`java.lang.ref.SoftReference`|`java.lang.ref.WeakReference`|
