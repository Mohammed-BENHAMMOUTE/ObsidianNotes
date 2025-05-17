[[exam web]]
# Advanced Web Development Summary: State Management Comparison & Next.js

## Comparison of State Management Solutions

|Criteria|Redux|Context API|Zustand|Recoil|
|---|---|---|---|---|
|Complexity|Moderate to high|Low|Low|Moderate|
|Performance|Moderately performant|Can cause re-renders|Very performant|Very performant|
|Ecosystem|Large (Saga, Thunk, DevTools)|Limited|Moderate|Small|
|Use Cases|Complex applications|Simple data sharing|Lightweight applications|Atomic store|
|Native React Support|No|Yes|No|No|

## Global Summary of State Management Solutions

### Local State

- **useState**: Simple and efficient for component-specific state
    - **Use Cases**: Forms, temporary or independent states
    - **Best For**: Simple, small projects
- **useReducer**: Manages complex local logic
    - **Use Cases**: When multiple actions affect a single state object

### Simple Global State

- **Context API**: Share global data with native configuration
    - **Use Cases**: App themes, logged-in user, language preferences
    - **Best For**: Small to medium projects

### Advanced Global State

- **Redux**: Centralized management for complex applications
    - **Use Cases**: E-commerce apps, complex interactions, dynamic charts
    - **Ideal For**: Complex projects
- **Zustand**: Lightweight and modular
- **Recoil**: Atomic or fine-grained store

## Choosing the Right State Management Approach

### Situation 1: Global Theme Management

**Context API** is recommended for managing a global theme (light/dark) used by multiple components while avoiding prop drilling and maintaining performance.

### Situation 2: Todo List with Complex Actions

**useReducer** is designed for complex states where multiple actions modify state in a structured way. For a todo list with adding, marking, and deleting operations, useReducer organizes these operations through a reducer for clarity and maintainability.

### Situation 3: Complex Interconnected State Modules

**Redux** simplifies configuration with tools for defining reducers and actions. In applications with multiple complex interconnected states (cart, user profile, notification system), it centralizes state management while offering tools like Thunk, Saga, and DevTools for debugging.

### Situation 4: Simple Counter Component

**useState** is ideal for simple, local component states. For a counter with increment/decrement functionality used only in one component, useState provides simplicity and direct React integration.

## Server-Side Rendering (SSR) & Next.js

### Client-Side Rendering (CSR) Challenges

- **Limited SEO**: JavaScript content isn't well-indexed by search engines
- **Resource-Limited Devices**: Less powerful devices struggle to execute JavaScript efficiently
- **Loading Time**: CSR requires loading and executing JavaScript before displaying information
- **No Pre-rendering**: Content only renders after JavaScript execution

### Content Generation Approaches

#### Server-Side Rendering (SSR)

- Generates pages on the server for each request
- Improves SEO with pre-rendered HTML content
- Reduces initial loading time
- Consumes more server resources
- Allows real-time content updates
- Requires more powerful servers for frequent requests

#### Static Site Generation (SSG)

- Generates static pages during build time
- Improves performance with pre-rendered pages
- Reduces loading time with static pages
- Ideal for primarily static content sites
- Requires fewer server resources after generation
- Easy to deploy and scale

### Comparison of Rendering Strategies

| Strategy | Principle                                                  | Advantages                                            | Disadvantages                                             |
| -------- | ---------------------------------------------------------- | ----------------------------------------------------- | --------------------------------------------------------- |
| SSR      | Page generated on server for each request                  | •Optimized SEO<br>• Dynamic data<br>• Better security | • Longer response time<br>• High server load              |
| CSR      | Rendering done on client after initial load                | • Low server load<br>• Better user experience         | • Poor SEO<br>• Requires JavaScript                       |
| SSG      | Page pre-generated at build time and served as static file | • Fast and performant<br>• Excellent SEO              | • Not suitable for dynamic content<br>• Limited use cases |

### Use Cases

#### Server-Side Rendering (SSR)

- Blogs with dynamic content
- Real-time applications (dashboards, finance)
- Sites where SEO is crucial

#### Static Site Generation (SSG)

- Showcase websites
- Static blogs
- Documentation and product guides
- Product catalogs

#### Client-Side Rendering (CSR)

- Interactive SPA applications
- Dashboards with real-time user data
- Rich interfaces with frequent interactions

## Next.js

### Introduction

Next.js, created in 2016 by Guillermo Rauch and supported by Vercel, is a React framework designed to simplify web development. It enables server-side rendering (SSR), static site generation (SSG), and optimizes performance while improving SEO and user experience.

### Next.js CLI

Popular commands in Next.js command-line interface:

- **Creation**: `npx create-next-app appname`
- **Development Mode**: `npm run dev`
- **Production Build**: `npm run build`
- **Production Mode**: `npm run start`
- **Add TypeScript**: `npm install --save-dev typescript @types/react @types/node`
- **Generate Static Pages**: `next export`

### Hello World in Next.js

```jsx
// File in "pages" folder
function HomePage() {
  return <h1>Welcome to Next.js!</h1>;
}
export default HomePage;
```

1. Create a file in the "pages" directory (use .tsx for TypeScript)
2. Declare a component using React syntax
3. The "pages" folder contains all application pages automatically associated with a route

### Next.js Project Structure

```
/
├── pages/
│   ├── api/
│   ├── index.js
│   └── about.js
├── public/
│   ├── favicon.ico
│   ├── logo.png
│   └── myfont.tff
├── styles/
│   ├── globals.css
│   └── Home.module.css
├── components/
│   ├── Navbar.js
│   └── Footer.js
├── next.config.js
├── package.json
└── .env.local
```

### Routing System in Next.js

1. **Automatic Routing**
    
    - File names automatically define application routes
    - Examples:
        - `pages/index.js` → Route: `/`
        - `pages/about.js` → Route: `/about`
        - `pages/blog.js` → Route: `/blog`
2. **Dynamic Routing**
    
    - Use files with parameters for dynamic routes
    - Syntax: `[param].js` for dynamic routes
    - Example:
        - `pages/blog/[id].js` → Route: `/blog/:id`
        - `/blog/123` will display the page for post with ID 123
    
    ```jsx
    const router = useRouter()
    <h1>ID: {router.query.id}</h1>
    ```
    
3. **Nested Routing**
    
    - Organize routes in subfolders for nested routes
    - Example:
        - `pages/dashboard/settings.js` → `/dashboard/settings`
4. **API Routes**
    
    - Create API routes in the `pages/api/` folder
    - Example:
        - `pages/api/hello.js` → Accessible via `/api/hello`
5. **Programmatic Routing**
    
    - Use `next/router` for dynamic navigation
    - Example:
    
    ```jsx
    const router = useRouter();
    router.push('/about');
    ```
    

### useRouter API

Key methods provided by useRouter:

- **push**: Navigate to a new page while preserving history
- **replace**: Replace the current URL without adding to history
- **back**: Return to the previous page in browser history
- **reload**: Refresh the current page while preserving initial state
- **query**: Get dynamic URL values as an object

### Customization with Special Files

#### _app.js

This file customizes the global behavior of the application, allowing you to add global styles and manage state between pages.

Common uses:

- Add global styles
- Provide contexts (Redux, Context API)
- Implement layouts common to all pages

```jsx
// pages/_app.js
import '../styles/globals.css';
export default function MyApp({ Component, pageProps }) {
  return <Component {...pageProps} />;
}
```

With Redux:

```jsx
// pages/_app.js
import { Provider } from 'react-redux';
import store from '../store';
export default function MyApp({ Component, pageProps }) {
  return (
    <Provider store={store}>
      <Component {...pageProps} />
    </Provider>
  );
}
```

#### _document.js

This file allows modifying the base HTML document, like customizing the `<html>` tag to specify the page language.

Common uses:

- Define the application language
- Add external fonts or scripts
- Modify the base HTML structure for specific needs

```jsx
// pages/_document.js
export default function Document() {
  return (
    <Html lang="fr">
      <body>
        <Main />
        <NextScript />
      </body>
    </Html>
  );
}
```

With external resources:

```jsx
// pages/_document.js
export default function Document() {
  return (
    <Html lang="fr">
      <Head>
        <link rel="stylesheet" href="css-blue.css" />
      </Head>
      <body>
        <Main />
        <NextScript />
      </body>
    </Html>
  );
}
```

### Comparing _app.js and _document.js

|_app.js|_document.js|
|---|---|
|Controls global page behavior|Customizes HTML structure|
|Adds global styles and contexts|Adds fonts, metadata, and external scripts|
|Executed on client and server|Executed only on server|
|Cannot modify `<html>`, `<head>`, or `<body>`|Allows modifying `<html>` and `<body>`|