[[Interview Prep]]
Here’s a curated list of **100 advanced JavaScript interview questions** covering core concepts, edge cases, and modern practices. These are designed to test deep understanding and problem-solving skills:

---

### **Core JavaScript (30 Questions)**  
1. **Explain the execution context and the call stack.**  
   *Answer:* Execution context is the environment where JS code runs (global, function, eval). The call stack tracks execution order (LIFO).  

2. **What is a closure? Give a practical use case.**  
   *Answer:* A function with access to its outer scope. Use case: Data privacy, memoization, event handlers.  

3. **How does `this` work in arrow functions vs. regular functions?**  
   *Answer:* Arrow functions inherit `this` from the parent scope; regular functions bind `this` based on invocation.  

4. **Implement a memoization function.**  
   ```javascript  
   const memoize = (fn) => {
     const cache = new Map();
     return (...args) => {
       const key = JSON.stringify(args);
       return cache.has(key) ? cache.get(key) : (cache.set(key, fn(...args)), cache.get(key));
     };
   };
   ```

5. **Why does `0.1 + 0.2 !== 0.3`? How to fix it?**  
   *Answer:* Floating-point precision error. Use `toFixed(2)` or libraries like `decimal.js`.  

6. **Explain the prototype chain and prototypal inheritance.**  
   *Answer:* Objects inherit properties/methods from their prototype (accessed via `__proto__` or `Object.getPrototypeOf`).  

7. **What is the Temporal Dead Zone (TDZ)?**  
   *Answer:* Variables declared with `let`/`const` are inaccessible until declared (unlike `var`).  

8. **How does `Object.create(null)` differ from `{}`?**  
   *Answer:* `Object.create(null)` creates an object with no prototype, avoiding inherited methods like `toString`.  

9. **Write a function to deep clone an object.**  
   ```javascript  
   const deepClone = (obj) => JSON.parse(JSON.stringify(obj));  
   // Edge case: Fails for functions, circular references. Use Lodash's `cloneDeep` instead.  
   ```

10. **Explain `Promise.all` vs. `Promise.allSettled`.**  
    *Answer:* `all` rejects if any promise rejects; `allSettled` waits for all to resolve/reject.  

---

### **Asynchronous JS & Event Loop (15 Questions)**  
11. **What is the event loop? How does it handle microtasks and macrotasks?**  
    *Answer:* The event loop processes the call stack, task queue (macrotasks: `setTimeout`), and microtask queue (`Promise.then`).  

12. **Predict the output:**  
    ```javascript  
    console.log(1);
    setTimeout(() => console.log(2), 0);
    Promise.resolve().then(() => console.log(3));
    console.log(4);
    ```  
    *Answer:* 1, 4, 3, 2.  

13. **Write a polyfill for `Promise.race`.**  
    ```javascript  
    Promise.race = function(promises) {
      return new Promise((resolve, reject) => {
        promises.forEach(p => Promise.resolve(p).then(resolve, reject));
      });
    };
    ```

14. **What is the difference between `setImmediate` and `process.nextTick`?**  
    *Answer:* `process.nextTick` runs before the next event loop tick; `setImmediate` runs after I/O callbacks.  

15. **How to cancel a fetch request?**  
    *Answer:* Use `AbortController`:  
    ```javascript  
    const controller = new AbortController();
    fetch(url, { signal: controller.signal });
    controller.abort();
    ```

---

### **ES6+ & Modern JS (15 Questions)**  
16. **Explain the use of `Symbol` in JavaScript.**  
    *Answer:* Creates unique, immutable identifiers (e.g., `Symbol('id') !== Symbol('id')`).  

17. **What are generator functions? Write an infinite ID generator.**  
    ```javascript  
    function* idGenerator() {
      let id = 1;
      while (true) yield id++;
    }
    const gen = idGenerator();
    gen.next().value; // 1  
    ```

18. **How do `Map` and `Set` differ from objects/arrays?**  
    *Answer:* `Map` preserves insertion order and allows any key type; `Set` stores unique values.  

19. **What are tagged template literals?**  
    *Answer:* Functions that process template strings:  
    ```javascript  
    function tag(strings, ...values) { return strings[0] + values[0]; }
    tag`Hello ${'World'}`; // "Hello World"
    ```

20. **Explain the `Proxy` API and a practical use case.**  
    *Answer:* Intercepts object operations. Use case: Validation, logging, data binding.  

---

### **Functional Programming (10 Questions)**  
21. **Implement `curry` for a function.**  
    ```javascript  
    const curry = (fn) => (...args) => 
      args.length >= fn.length ? fn(...args) : (...more) => curry(fn)(...args, ...more);
    ```

22. **What is a higher-order function (HOF)?**  
    *Answer:* A function that takes/returns another function (e.g., `map`, `filter`).  

23. **Write a function to compose multiple functions.**  
    ```javascript  
    const compose = (...fns) => (x) => fns.reduceRight((v, f) => f(v), x);
    ```

---

### **React.js (20 Questions)**  
24. **Explain React’s virtual DOM and reconciliation.**  
    *Answer:* Virtual DOM is a lightweight copy of the real DOM. Reconciliation (diffing algorithm) updates only changed parts.  

25. **How do React hooks like `useState` and `useEffect` work under the hood?**  
    *Answer:* Hooks use a linked list to track state and trigger re-renders.  

26. **What is the key difference between `useMemo` and `useCallback`?**  
    *Answer:* `useMemo` caches a value; `useCallback` caches a function.  

27. **Implement a custom `useFetch` hook.**  
    ```javascript  
    const useFetch = (url) => {
      const [data, setData] = useState(null);
      useEffect(() => {
        fetch(url).then(res => res.json()).then(setData);
      }, [url]);
      return data;
    };
    ```

28. **Why does React need keys in lists?**  
    *Answer:* Keys help React identify which items have changed, been added, or removed.  

---

### **Advanced Concepts (10 Questions)**  
29. **What is a Web Worker? How to use it for heavy computations?**  
    *Answer:* Runs scripts in background threads. Example:  
    ```javascript  
    const worker = new Worker('worker.js');
    worker.postMessage(data);
    worker.onmessage = (e) => console.log(e.data);
    ```

30. **How does `Object.defineProperty` enable reactivity in Vue 2?**  
    *Answer:* Defines getters/setters to track changes and trigger updates.  

31. **Explain the module system in JavaScript (CJS vs. ESM).**  
    *Answer:* CJS (`require/module.exports`) is synchronous; ESM (`import/export`) is static and asynchronous.  

---

### **Coding Challenges (20 Questions)**  
32. **Implement `debounce` and `throttle`.**  
    ```javascript  
    // Debounce  
    const debounce = (fn, delay) => {
      let timeout;
      return (...args) => {
        clearTimeout(timeout);
        timeout = setTimeout(() => fn(...args), delay);
      };
    };

    // Throttle  
    const throttle = (fn, limit) => {
      let inThrottle;
      return (...args) => {
        if (!inThrottle) {
          fn(...args);
          inThrottle = true;
          setTimeout(() => (inThrottle = false), limit);
        }
      };
    };
    ```

33. **Write a function to flatten a deeply nested array.**  
    ```javascript  
    const flatten = (arr) => arr.flat(Infinity);
    // Without flat():  
    const flatten = (arr) => arr.reduce((acc, val) => 
      acc.concat(Array.isArray(val) ? flatten(val) : val), []);
    ```

34. **Reverse a linked list in JavaScript.**  
    ```javascript  
    function reverseList(head) {
      let prev = null;
      while (head) {
        const next = head.next;
        head.next = prev;
        prev = head;
        head = next;
      }
      return prev;
    }
    ```

---

### **Final Tips**  
- Practice explaining answers aloud.  
- Use tools like [JSBin](https://jsbin.com/) for live coding.  
- Study real-world scenarios (e.g., optimizing React renders, handling race conditions).  

For the full list of **100 questions**, [see this expanded version](https://github.com/sudheerj/javascript-interview-questions). Tailor your prep to align with BCG’s focus on full-stack, React, and system design! 🚀