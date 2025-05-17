[[exam web]]
# Next.js and Modern Web Development Summary

## Environment Configuration in Docker for Node.js/Next.js

- **Environment Variables (.env)**:
    - Support primarily strings, can be converted to integers or booleans
    - Require explicit conversion: `parseInt()` or `JSON.parse()`
    - Example: `MAX_RETRIES=3` → `const maxRetries = parseInt(process.env.MAX_RETRIES)`
- **Docker Environment Variables**:
    - Set with `-e` or `--env` flags when launching container
    - Example: `docker run -e NODE_ENV=production`

## Next.js Project Structure Evolution

### Comparison: Pages Router vs App Router

|CRITERIA|PAGES ROUTER (/pages/)|APP ROUTER (/app/)|
|---|---|---|
|FILE STRUCTURE|File-based routing|Folder-based routing|
|PERFORMANCE|High|Very high|
|PERSISTENT LAYOUT|Not native (via _app.js & _document.js)|Native with layout.js|
|API ROUTES|pages/api/|app/api/route.js|
|LOADING MANAGEMENT|Not natively managed|With loading.js|
|ERROR HANDLING|Not natively managed|With error.js|
|DEFAULT RENDERING|Client-Side Rendering (CSR)|Server-Side (SSR/SSG)|
|STATIC GENERATION (SSG)|getStaticProps|Automatic based on usage|
|DYNAMIC (SSR)|getServerSideProps|Automatic (Server Components)|
|CLIENT COMPONENTS|By default|Requires "use client"|

### Key Files in App Router

- **layout.js**:
    
    - Maintains common structure across multiple pages
    - Replaces _app.js & _document.js
    
    ```jsx
    export default function Layout({ children }) {
      return (
        <div>
          <header>Header</header>
          <main>{children}</main>
          <footer>Footer</footer>
        </div>
      );
    }
    ```
    
- **page.js**:
    
    - Defines main content for a given route
    - Replaces index.js
    
    ```jsx
    export default function Page() {
      return <h1>Welcome to my page!</h1>;
    }
    ```
    
- **loading.js**:
    
    - Shows loading screen while page is preparing
    
    ```jsx
    export default function Loading() {
      return <p>Loading...</p>;
    }
    ```
    
- **error.js**:
    
    - Captures and displays UI in case of error
    
    ```jsx
    export default function Error({ error, reset }) {
      return (
        <div>
          <p>An error occurred: {error.message}</p>
        </div>
      );
    }
    ```
    

### Client-Side Rendering in App Router

- Add `"use client"` directive at top of file to force client-side execution
- Required for React hooks (useState, useEffect, etc.)

```jsx
"use client";
import { useState } from "react";

function ClientComponent() {
  const [count, setCount] = useState(0);
  return <button onClick={() => setCount(count + 1)}>Counter: {count}</button>;
}
```

## Next.js Configuration (next.config.js)

### Common Configuration Options

|OPTION|SETTING|PURPOSE|
|---|---|---|
|STRICT MODE|reactStrictMode: true|Detect React issues|
|SPEEDY WEB COMPILER|swcMinify: true|Improve build speed (replaces terser)|
|INTERNATIONALIZATION|i18n|Manage languages and locales|
|IMAGE OPTIMIZATION|images.domains|Allow external sources|
|REDIRECTS|redirects|Redirect URLs|
|REWRITES|rewrites|Modify internal paths|

### Example Configuration File

```javascript
const nextConfig = {
  reactStrictMode: true,
  swcMinify: true,
  images: {
    domains: ['example.com', 'cdn.example.com'],
  },
  async redirects() {
    return [
      { source: '/old-page', destination: '/new-page', permanent: true },
    ];
  },
  compress: true,
  trailingSlash: false, // Good for SEO
}
module.exports = nextConfig;
```

## Best Practices for Next.js

1. **Performance**:
    - Use Server-Side Rendering (SSR) and Static Site Generation (SSG) when necessary
2. **Security**:
    - Verify user inputs server-side
    - Protect API Routes with authentication and permissions
    - Always communicate via HTTPS
3. **Static Resources**:
    - Deliver images, CSS, and JavaScript via CDN
4. **Development**:
    - Enable reactStrictMode: true
    - Use useState and useEffect cautiously
5. **Compression**:
    - Enable response compression (Gzip or Brotli) to speed up loading time

## Advanced Next.js Concepts

1. **SEO**:
    - Improve search engine visibility using SSR, `next/Head`, next-sitemap
2. **Persistence**:
    - Manage database communication with APIs or ORMs (Prisma, Sequelize, Mongoose)
3. **I18n (Internationalization)**:
    - Handle multilingual content with next-i18next
4. **State Management**:
    - Manage application state efficiently with Redux or Zustand

## WebPack vs TurboPack

|CRITERIA|WEBPACK|TURBOPACK|
|---|---|---|
|Language|JavaScript|Rust|
|Performance|Slow on large projects|10x to 700x faster|
|Incremental compilation|No|Yes|
|Hot Module Replacement (HMR)|Yes|Yes (faster)|
|Configuration ease|Complex|Automatic|
|Ecosystem|Large (many plugins)|Still developing|

## Next.js Application Architecture

- Separation between Frontend and Backend
- UI/UX Layer: HTML, CSS, JS (pages and components)
- Business Layer: Logic via APIs and services
- Persistence Layer: Database interaction

## Jamstack Architecture

### Definition and Core Principles

- Created in 2016
- Pre-generates HTML served via CDN
- Uses JavaScript for interactivity
- Connects to APIs for dynamic data
- Eliminates backend servers

### Three Pillars

1. **Static Pages**:
    - Pre-generated HTML served quickly via CDN
2. **Serverless**:
    - No dedicated server management
3. **Scalable Deployment**:
    - Content distributed globally via CDN (Netlify, Vercel)

### Advantages of Jamstack

|CRITERIA|TRADITIONAL ARCHITECTURE|JAMSTACK|
|---|---|---|
|Performance|Response time depends on server and database|Instant loading via CDN|
|Security|Vulnerable to server attacks (SQL Injection, DDoS)|No exposed server/database|
|Scalability|Requires more servers for high traffic|Easily scalable with CDN|
|Hosting Cost|Expensive servers and maintenance|Cheaper with static hosting|
|Developer Experience|Manual, often complex deployment|Easy deployment via CI/CD|

### Popular Jamstack Technologies

1. **Static Site Generators**:
    - Next.js, Gatsby, Nuxt.js, Hugo, Jekyll
2. **Hosting and Deployment**:
    - Netlify, Vercel, Cloudflare Pages, GitHub Pages
3. **Data Providers**:
    - Firebase, Supabase, AWS Amplify, AWS Lambda, Vercel Functions

### Deployment Process

1. **Development**: Create static frontend with SSG, integrate APIs
2. **Hosting**: Store static pages on CDN
3. **Deployment**: Automate via GitHub/GitLab for instant deployment
4. **Optimization**: Distribute files via CDN for speed
5. **Maintenance**: Update via webhooks or ISR without full rebuild

## Higher-Order Components (HoC)

### Definition

- Function that enhances a component with additional functionality
- Enables code reuse without modifying original components
- Maintains separation of concerns

### Example

```jsx
const withLogger = (WrappedComponent) => {
  return (props) => {
    console.log("Rendering component with props:", props);
    return <WrappedComponent {...props} />;
  };
};

const MyComponent = (props) => <h1>Hello {props.name}!</h1>;
const EnhancedComponent = withLogger(MyComponent);

// Usage
<EnhancedComponent name="Alice" />;
// Console output: Rendering component with props: { name: "Alice" }
```

### Use Cases

1. **Authorization Management**: Display component only if user is authenticated
2. **Error Handling**: Show error page if data loading fails
3. **Loading Management**: Display spinner while data loads
4. **Tracking and Logging**: Record user interactions for analysis

### Best Practices

1. Keep HoC simple and focused
2. Pass props correctly
3. Avoid excessive nesting of HoCs
4. Use explicit names (withAuth, withLogging)

### Limitations and Alternatives

- **Wrapper Hell**: Too many nested HoCs make code unreadable
- **Props Collision**: HoCs can replace or mask props
- **Excessive Rendering**: Some HoCs cause unnecessary rerenders

**Alternatives**:

- React Hooks: Simpler logic sharing
- Render Props: Data passing via functions
- Global State Managers: State management without HoC nesting