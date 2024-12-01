[[C++]]
C++ is a statically typed language which means that the data type of its variables is determined at compile time, However C++ provides tools that offers a level of dynamic typing, which means determining the datatype of a variable at runtime.

we have the main two tools that c++ uses for dynamic typing are `void*` and `std::any`

#### Void Pointers `void*`:
void pointers are generic type of pointers that are couple of referencing any type. They can be used to store a reference to any type of object without knowing the specific type of the object.

```cpp
#include <iostream>

int main() {
    int x = 42;
    float y = 3.14f;
    std::string z = "Hello, world!";

    void* void_ptr;

    void_ptr = &x;
    std::cout << "int value: " << *(static_cast<int*>(void_ptr)) << std::endl;

    void_ptr = &y;
    std::cout << "float value: " << *(static_cast<float*>(void_ptr)) << std::endl;

    void_ptr = &z;
    std::cout << "string value: " << *(static_cast<std::string*>(void_ptr)) << std::endl;

    return 0;
}
```

####  Any: `std::any`
C++17 introduced the `std::any` class which represents a generalized type-safe container for single values of any type.
```Cpp
#include <iostream>
#include <any>

int main() {
    std::any any_value;

    any_value = 42;
    std::cout << "int value: " << std::any_cast<int>(any_value) << std::endl;

    any_value = 3.14;
    std::cout << "double value: " << std::any_cast<double>(any_value) << std::endl;

    any_value = std::string("Hello, world!");
    std::cout << "string value: " << std::any_cast<std::string>(any_value) << std::endl;

    return 0;
}
```
