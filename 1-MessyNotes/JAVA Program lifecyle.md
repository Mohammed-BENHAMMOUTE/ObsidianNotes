first we have the .java code 
the javac compiler to compile java into byte code
if no error we get the byte code.

after that we call java so that we can interpret the bytecode within the JVM.
now the first part is that the byte code is loaded in memory.

after thet the byte code is verified by the bytecode verifier, if there are no errors:
the code will be interpreted.

the byte code verifier might either transfer the code to the interperter or to the JIT compiler.
the interpreter interprets the code line by line and uses the JIT compiler for optimization.

![[Drawing 2025-03-20 03.55.06.excalidraw]]

