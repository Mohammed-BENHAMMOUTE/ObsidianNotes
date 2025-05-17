when a funciton is called it is pushed into the call stack. when a function finishes executing it is popped from the call stack, javascript is single threaded so each instruction is executed once.
#### **How it Works:**

- When a function is called, it is **pushed onto the call stack**.
- When a function finishes executing, it is **popped off the stack**.
- JavaScript is **single-threaded**, meaning it executes one operation at a time using the call stack.


The event loop is a mechanism that manages asynchronous tasks and ensures that javascript continues running smoothly.

#### **How it Works:**

1. JavaScript executes synchronous code first (using the call stack).
2. If an asynchronous operation (like a timer, network request, or file read) is encountered:
    - It is **delegated to the browser’s APIs** or **Node.js’s thread pool**.
    - The function execution **does not block the call stack**.
3. When the asynchronous operation completes:
    - The callback function is placed in the **event queue** (or **Microtask Queue** for Promises).
4. The **event loop** constantly checks:
    - If the **call stack is empty**, it moves a callback from the **event queue** to the **call stack**.
    - If the stack is busy, the callback waits.
