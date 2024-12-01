[[C++]]
smart pointers are made so that we you call new you don't have to call delete, and in many cases we dont even have to call new.
so in a way smart pointer is wrapper around raw pointers.

## Unique Pointers (`unique_ptr` )
uses the concept of exclusif ownership meaning only one unique_ptr is allowed to own an object at a time. This ownership can be transferred or moved, but it cannot be shared or copied.

This concept helps to prevent issues like dangling pointers, reduce memory leaks, and eliminates the need manual memory management . when th e`unique_ptr` goes out of scode it automatically deletes the object it owns. lets take a look at some basic examples of using `unique-ptr`:
#### Creating a unique pointer:
``` c
#include <iostream>
#include <memory>

int main() {
    std::unique_ptr<int> p1(new int(5)); // Initialize with pointer to a new integer
    std::unique_ptr<int> p2 = std::make_unique<int>(10); // Preferred method (C++14 onwards)

    std::cout << *p1 << ", " << *p2 << std::endl;
    return 0;
}
```

#### transferring Ownership:
```C
#include <iostream>
#include <memory>

int main() {
    std::unique_ptr<int> p1(new int(5));

    std::unique_ptr<int> p2 = std::move(p1); // Ownership is transferred from p1 to p2

    if (p1) {
        std::cout << "p1 owns the object" << std::endl;
    } else if (p2) {
        std::cout << "p2 owns the object" << std::endl;
    }

    return 0;
}
```
#### Using Unique pointers with Custom Deleters:

``` C
#include <iostream>
#include <memory>

struct MyDeleter {
    void operator()(int* ptr) {
        std::cout << "Custom Deleter: Deleting pointer" << std::endl;
        delete ptr;
    }
};

int main() {
    std::unique_ptr<int, MyDeleter> p1(new int(5), MyDeleter());
    return 0; // Custom Deleter will be called when p1 goes out of scope
}
```



# Shared Pointers:

A shared poiter is a type of pointer that allows multople pointers to share ownership of a dynamically allocated object . The object will be dynamically deaalocated only when the last shared_ptr that points to it is destroyed.

When using a `shared_ptr`, the reference counter is automatically incremented every time a new pointer is created, and decremented when each pointer goes out of scope. Once the reference counter reaches zero, the system will clean up the memory.
```c
#include <iostream>
#include <memory>

class MyClass {
public:
    MyClass() { std::cout << "Constructor is called." << std::endl; }
    ~MyClass() { std::cout << "Destructor is called." << std::endl; }
};

int main() {
    // create a shared pointer to manage the MyClass object
    std::shared_ptr<MyClass> ptr1(new MyClass());
    
    {
        // create another shared pointer and initialize it with the previously created pointer
        std::shared_ptr<MyClass> ptr2 = ptr1;

        std::cout << "Inside the inner scope." << std::endl;
        // both pointers share the same object, and the reference counter has been increased to 2
    }

    std::cout << "Outside the inner scope." << std::endl;
    // leaving the inner scope will destroy ptr2, and the reference counter is decremented to 1
    
    // the main function returns, ptr1 goes out of scope, and the reference counter becomes 0
    // this causes the MyClass object to be deleted and the destructor is called
}
```

Output:

```
Constructor is called.
Inside the inner scope.
Outside the inner scope.
Destructor is called.
```

# Weak Pointer:

a weak pointer is also a smart pointer that doesn't increase the reference count, opposed to the shared_ptr.
meaning it does not increase the ownership reference count of the object it points to, which is key difference between weak_ptr and shared_ptr.
