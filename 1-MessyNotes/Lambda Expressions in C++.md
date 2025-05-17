[[C++]]
A lambda function, or simply “lambda”, is an anonymous (unnamed) function that is defined in place, within your source code, and with a concise syntax. Lambda functions were introduced in C++11 and have since become a widely used feature, especially in combination with the Standard Library algorithms.

## Syntax

Here is a basic syntax of a lambda function in C++:

```c++
[capture-list](parameters) -> return_type {
    // function body
};
```

- **capture-list**: A list of variables from the surrounding scope that the lambda function can access.
- **parameters**: The list of input parameters, just like in a regular function. Optional.
- **return_type**: The type of the value that the lambda function will return. This part is optional, and the compiler can deduce it in many cases.
- **function body**: The code that defines the operation of the lambda function.```
``` C
int expiresInDays = 45;
auto updateDays = [&expiresInDays](int newDays) {
    expiresInDays = newDays;
};
updateDays(30); // expiresInDays = 30
```

we can pass scope variable  reference using the &, and we can pass it by value using = (the variable name), and it can pass mixed types with different types in the capture list.
```Cpp
#include<bits/stdc++.h>
using namespace std;
int main() 
{
	vector<int> v1 = {3, 1, 7,9};
	vector<int> v2 = {4,5,7,8,5};
	auto pushInto = [&]() {
		v1.push_back()
	}
}
```