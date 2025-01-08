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