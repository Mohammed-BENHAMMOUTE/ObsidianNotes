RTTI is a feature in C++ that allows us to give information about the type of the element at runtime, 
there are two methods to get the Runtime type of an object, and that using:
+ `typeid` operator
+ `dynamic_cast` operator.


1. typeid operator:
```Cpp
#include <iostream>
#include <typeinfo>

class Base { virtual void dummy() {} };
class Derived : public Base { /* ... */ };

int main() {
    Base* base_ptr = new Derived;

    // Using typeid to get the type of the object
    std::cout << "Type: " << typeid(*base_ptr).name() << '\n';

    delete base_ptr;
    return 0;
}
```

2. `Dynamic_cast` Operator:
`dynamic_cast` is a type-casting operator that performs a runtime type check and safely downcasts a base pointer or reference to a derived pointer or reference. It returns null or throws a bad_cast exception (if casting references) when the casting fails.

```Cpp
#include <iostream>

class Base { virtual void dummy() {} };
class Derived1 : public Base { /* ... */ };
class Derived2 : public Base { /* ... */ };

int main() {
    Base* base_ptr = new Derived1;

    // Using dynamic_cast to safely downcast the pointer
    Derived1* derived1_ptr = dynamic_cast<Derived1*>(base_ptr);
    if (derived1_ptr) {
        std::cout << "Downcast to Derived1 successful\n";
    }
    else {
        std::cout << "Downcast to Derived1 failed\n";
    }

    Derived2* derived2_ptr = dynamic_cast<Derived2*>(base_ptr);
    if (derived2_ptr) {
        std::cout << "Downcast to Derived2 successful\n";
    }
    else {
        std::cout << "Downcast to Derived2 failed\n";
    }

    delete base_ptr;
    return 0;
}
```

