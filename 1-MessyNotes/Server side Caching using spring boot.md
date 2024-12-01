[[Spring]]

## What is Caching?

Caching is a process or method of storing a copy of the continuously asked data in a temporary storage location or cache to be quickly accessed when needed.

A cache is a memory reserved for storing temporary files or data from apps, servers, websites, or browsers to help load faster when requested. It includes images, videos, animation, gifs, scripts, files, etc.

## what is website caching?

its the process of storing webpages on either client's or server's memory.
there are three types of caching :
1. Server side caching
2. client side caching 
3. remote caching 
## Spring boot caching:
1. enable caching 
2. store 
3. update
4. evict/clear

the annotations used for caching:
1. `@EnableCaching`
2. `@Cachaeable`: used with the methds that are cachable

```java
@Cacheable({cacheNames="books",key="isbn"})
public Book findBook(ISBN isbn){...}
// as you can see the key has the name of the argument of the function, basically the key is a variable thats available within the function scoop.
@Cacheable(cacheNames = "Books", key = "#isbn.rawNUmber")
public Book findNumber(ISBN isbn , boolean checkWareHouse , boolean includeUsed)

@Cacheable(cacheNames = "books", condition = "#name.length() < 32")
public Book findBook(String name)

// + Synchronized Caching:
@Cacheable(cacheNames = "foos", sync = true)
public foo executeExpensiveOperation(Stirng id){...}
```
3.  `@CACHEPUT` : updates the caching 

```java
@CACHEPUT(cacheNames = "book", key = "#isbn")
public Book updateBook(ISBN isbn , BookDescriptor)
```

4. `@CACHEVICT`: evicts the cache:
```java
@CacheEvict(cacheNames = "books", allEntries = true)
public void loadBooks(InputStream batch);
```
5. `@Caching`: to specify multiple annotations of the same type:
```java
@Caching(evict = {@CAcheEvict("primary"), @CacheEvict(cacheNames="Secondary", kay = "#p0")})
public Book importBooks(String deposit , Date date)
```

6. @C