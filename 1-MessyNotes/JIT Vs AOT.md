java keeps a performance counter for each instruction.
each time  that particular line or method is called,  the performance counter is incremented.

when the value of it surpasses a certain level, that block is compiled and saved in the code cache, in the JVM. (native code)

we have C1 compiler or C2 compiler.

the performance counter i talked about is made by the C1.
after this is done the compiler kinds of draws the control flow of the code that will be executed alot.
the **C2** compiler will do even heavier optimizations.
the problem is that the C2 compiler is ressource hungry and slower.

this is called code profiling.  these profiles are extracted by the JVM.
**JIT IS AT RUNTIME**.

ahead of time compilation
can we not do it while we are converting our code into byte code ?