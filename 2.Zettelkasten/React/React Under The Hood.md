[[REACT]]


**Understanding React's Building Blocks:**

- **Components:** Think of components as reusable building blocks for your UI. They define what appears on the screen and how it behaves. Each component acts like a blueprint, specifying how a part of your interface should look and function.
- **Instances:** Imagine components as cookie cutters, and instances as the actual cookies you bake. When you use a component in your app, React creates an instance of that component. Each instance has its own state (data) and props (properties received from its parent). These instances are arranged in a hierarchical structure called the component tree.
- **Component Lifecycle:** This refers to the series of stages a component goes through during its existence. There are three main phases:
    - **Mounting:** When a component is first created and inserted into the DOM (the Document Object Model, representing the web page structure).
    - **Updating:** If a component's state or props change, React updates the component and potentially re-renders it in the DOM.
    - **Unmounting:** When a component is removed from the DOM, React calls specific methods to clean up resources.

**From JSX to the DOM:**

- **JSX:** React uses JSX syntax, which resembles HTML but allows you to write JavaScript expressions within the tags. It's a convenient way to describe the UI structure.
- **React Elements:** When you write JSX, React transforms it behind the scenes into lightweight objects called React elements. These elements encapsulate the information needed to render a DOM element, including the tag type (e.g., `div`, `p`), props (attributes), and children (content within the element).
- **DOM Elements:** These are the actual HTML elements that appear on the web page. React takes the React elements and efficiently updates the real DOM to reflect any changes in your component's state or props. This minimizes unnecessary DOM manipulations, improving performance.
  
  don't call the component by calling the function because then reacts no longer sees it as components instance.
  
  
2. **How rendering works in React**
	   ![[Pasted image 20240608180427.png]]
	   In React, rendering is NOT updating the DOM or displaying elements on the screen. Rendering only happens internally inside React, it does not produce visual changes.
	   ![[Pasted image 20240608180901.png]]
	   the first stage is when a prop/state changes, then render is triggered, and then the first part of render is when react calls the component function to figure out how the DOM should be updated . then the commit phase this change is added to the DOM. the broswer notices the Change and paints it on the UI.
	   there are two cases to trigger render:
		   1. the initial render of the application.
			2. State is updated in one or more components instances(re-render).
		Renders are not triggered  immediately, but scheduled for when JS engine has some free time. Ther is also batching of multiple setState calls in event handlers. 
		
	3. **HOW RENDERING WORKS?**
	   ![[Pasted image 20240608185525.png]]Reconciliation in React: An Overview

Reconciliation is a process in React that determines which parts of the DOM need to be updated when the state of an application changes. Directly updating the DOM with every state change is inefficient and can severely impact performance. Instead, React optimizes this by only updating the parts of the DOM that have actually changed.

### How React Knows What Changed

React uses a process called reconciliation to figure out what changes are necessary. This process involves comparing the current state of the DOM with a virtual representation of the DOM (virtual DOM) and determining the minimal set of changes needed to update the actual DOM.

### What is Reconciliation?

Reconciliation involves deciding which DOM elements need to be inserted, deleted, or updated to reflect the latest changes in the application. This task is handled by a component in React known as the reconciler. The current reconciler used by React is called **Fiber**.

### Understanding Fiber

**Fiber** is the heart of React's reconciliation process. During the initial render, Fiber creates a fiber tree from the React element tree. This fiber tree is a mutable data structure that is updated on each re-render, rather than being recreated.

#### Key Features of Fiber:

- **Fiber Tree**: A representation of the React component tree, implemented as a linked list.
- **Work Queue**: Each fiber has a queue of tasks to perform, such as updating state, handling props, and managing component lifecycle methods.
- **Asynchronous Work**: The reconciler performs work asynchronously, allowing React to manage rendering efficiently without blocking the main thread.

### Examples of Work in the Fiber Queue

The queue of work in each fiber can include a variety of tasks:

- Updating component state
- Applying props changes
- Invoking lifecycle methods (e.g., `componentDidMount`, `componentDidUpdate`)
- Handling event listeners
- Calculating derived state
- Updating refs

### Reconciliation in Action

During the reconciliation process, React generates a list of effects that contain the necessary updates for the DOM. This list is created by comparing the current fiber tree with the previous one and determining the differences.

### Steps of Reconciliation:

1. **Initial Render**: Fiber creates a fiber tree from the React element tree.
2. **State Change**: When a state change occurs, React schedules an update.
3. **Fiber Update**: The fiber tree is updated based on the new state.
4. **Effect List**: A list of effects is generated, detailing the necessary DOM changes.
5. **DOM Update**: The changes are applied to the actual DOM, updating only the parts that have changed.

### Benefits of Using Fiber

Using Fiber allows React to:

- Split rendering work into chunks, allowing for more efficient updates.
- Prioritize updates, ensuring that high-priority updates (e.g., user interactions) are handled first.
- Pause and resume work, enabling smoother animations and interactions.
- Handle errors gracefully, allowing React to recover from rendering errors without crashing the entire application.

### Conclusion

Reconciliation is a critical aspect of React's performance optimization. By using the Fiber architecture, React efficiently manages updates to the DOM, ensuring that only the necessary parts are updated. This approach minimizes the performance overhead and provides a smooth user experience. Understanding how Fiber works and the reconciliation process can help developers write more efficient and performant React applications.
	 
	![[Pasted image 20240608192952.png]]