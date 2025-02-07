[[Interview Prep]]

### what is function declaration ? 
```js
function square(num) { // this also called function statement
	return num*num;
}
```
### what is function expression ?
when store a function inside a variable, it then called a function expression.
```js
const squre = function square(num) { // this also called function statement
	return num*num;
}
```

### what are fist class functions?
in language that allow function to be treated  as variables, their functions are called first class functions. 
can be be passed to other functions,manipulated and returned by other functions.

```js
function displaySquare(fn) {
	console.log("Square is " + fn(5));
}
```


### what is IIFE? 
Immediatly invoked function expressions.
```js
(
function square(num) {
	return num * num;
})(5);
```
the ability of a function to access variables that are out of its scoped are called closures.
so closures are created whenever a new function is created. a function has a reference to its outer scope.
### function scope: var vs let vs const

//Scope
what is scope? is a certain region on our code where a defined variable exists and can be recognized, beyond that area it cant recognized.
there are different types of scopes:
global , function scope , block scope ...


var is functional scope but const and let are block scope.

// what is variable shadowing?

if you try to shadow let by var , you get error of illgal shodwing.
we can go down in the scope but not up.
we cant go for a broader scope.
```js
function test() {
	var a = "Hello";
	let b = "Bye";
	if(true){
		let a = "Hi"; // this is fine
		var b = "Goodbye"; // this is not fine
		console.log(a);
		console.log(b); //this is illegal shadowing
	}
}
```

redeclarations:
```js
var a;
var a;
// this is fine for var

let b; // or const b;
let b; // or const b;
// this is not ok, we cannot redecalre the let variables in the same scope.

// but this is Ok:
let a = 1;
{
	let a = 2;
}
```
 //declaration without initialization.
```js
var a; // this is fine
let a; // this is also fine 
const a; // this will get us an error we cant decalre an unitialized const 
```


### what is Hoisting?
first lets understand how js execution context works.
when we try to execute a js code , there are two phases, the first is Creation Phase , the second is Exection Phase.

in the creation phase, it:
1. creates a global or window object. 
2. set up a memory heap for storing variables and memory references.
   all variable and functions are stored in this window object.
3. it initializes them with undefined, except for functions where all of the function code is stored with the  function.

// execution phase:
.., complete this for me claude!!!



js uses callstack which is a mechanism to keep track of all function calls.
### Hoisting:
```js
console.log(count); // this will output undefinned but will not throw any error
var count = 1;
```

so js declares these vars in the top of the code in the creation phase, in the execution phase it gives them their values.

