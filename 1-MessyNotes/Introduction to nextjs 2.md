[[exam web]]
# Next.js Exam Preparation Summary

## Environment Variables Management in Next.js

### Loading and Priority

- Next.js loads environment variables from different files based on environment:
    - `.env.local`
    - `.env.development`
    - `.env.production`
    - `.env`
- `.env.local` has highest priority but is ignored during deployment (should be in `.gitignore`)

### Usage and Best Practices

- Undefined variables return 'undefined' both server-side and client-side
- Use `||` for default values: `const value = process.env.value || '12';`
- Only variables with `NEXT_PUBLIC_` prefix are accessible client-side
- Best practices:
    - Add `.env.local` to `.gitignore`
    - Don't store API keys or sensitive URLs client-side
    - Define default values to avoid errors
    - Use `console.log(process.env)` to verify environment variables
    - Use `NEXT_PUBLIC_` prefix only for variables that need client access

## Next.js Components and Structure

### Core Components

1. **Head** - Manages meta tags in `<head>` of each page
    
    ```jsx
    <Head>
      <title>Mon Site Next.js</title>
      <meta name="description" content="Next.js avec SSR" />
    </Head>
    ```
    
2. **Image** - Optimized image component
    
    ```jsx
    <Image
      src="/mon-image.jpg"
      alt="Description de l'image"
      width={500}
      height={300}
    />
    ```
    
    - Advantages over HTML `<img>`:
        - Automatic optimization
        - Built-in lazy loading
        - Responsive scaling
        - Intelligent preloading
        - Automatic dimension handling
3. **Script** - Manages third-party scripts
    
    ```jsx
    <Script
      src="https://example.com/script.js"
      strategy="lazyOnload"
    />
    ```
    
4. **Link** - For internal navigation without page reload
    
    ```jsx
    <Link href="/about" prefetch={true}>
      Aller à la page "à propos"
    </Link>
    ```
    
    - Benefits:
        - Instant navigation without reload
        - Automatic preloading
        - SEO optimization
        - Intelligent caching
        - Partial DOM updates

### Application Structure

- **Routing**: Next.js supports automatic routing based on file structure
    
    - Static pages: `/about`, `/contact`
    - Dynamic routes: `/blog/[id]`
- **Special Files**:
    
    - `_app.js`: Used for global theme, user context, and layout
    - `_document.js`: Custom document structure
    - `pages/api/`: For API routes integrated directly in Next.js project

## Styling in Next.js

Next.js supports multiple approaches for styling:

### 1. CSS Modules

- Locally scoped CSS styles for components
- Prevents class conflicts
- Example:
    
    ```css
    /* styles/Home.module.css */.title {  color: blue;  font-size: 2rem;}
    ```
    
    ```jsx
    // pages/index.jsimport styles from '../styles/Home.module.css';export default function Home() {  return <h1 className={styles.title}>Bienvenue sur Next.js</h1>;}
    ```
    

### 2. Global CSS

- Defined in `styles/globals.css` and imported in `pages/_app.js`
- Applies to the entire application
- Example:
    
    ```css
    /* styles/globals.css */body {  margin: 0;  font-family: Arial, sans-serif;  background-color: #f5f5f5;}
    ```
    
    ```jsx
    // pages/_app.jsimport '../styles/globals.css';
    ```
    

### 3. Styled Components

- CSS-in-JS approach for dynamic styles
- Example:
    
    ```jsx
    import styled from 'styled-components';const Button = styled.button`  background-color: ${(props) => (props.primary ? 'blue' : 'gray')};  color: white;  padding: 10px;  border: none;  cursor: pointer;`;export default function StyledButton() {  return <Button primary>Cliquez-moi</Button>;}
    ```
    

### Comparison of Styling Approaches

|Feature|CSS Modules|Global CSS|Styled Components|
|---|---|---|---|
|Scoped|Yes|No|Yes|
|Dynamic|No|No|Yes|
|Performance|Very good|Very good|Less optimized|
|Main Use|Reusable components|Global styles, external libraries|Dynamic styles, theming|

## Data Fetching Methods

### 1. getServerSideProps (SSR)

- Renders pages on server for each request
- Ideal for frequently updated data (dashboards, real-time data)
- Example:

```javascript
    // pages/dashboard.js
export async function getServerSideProps() {  
	const res = await fetch('https://api');  
	const data = await res.json();  
	return {    props: { data },  }
;}
function Dashboard({ data }) {  
return (    
<div>
	<h1>Tableau de bord</h1>      
	<p>{data.views} vues aujourd'hui</p>   
</div>  );}
export default Dashboard;
```


### 2. getStaticProps (SSG)

- Generates static pages at build time
- Ideal for content that doesn't change frequently (blogs, documentation)
- Can use `revalidate` to update at intervals without full rebuild
- Example:
    
    ```jsx
    // pages/blog.jsexport async function getStaticProps() {  const res = await fetch('https://api/');  const posts = await res.json();  return {    props: { posts },    revalidate: 60, // Re-generate page every 60 seconds  };}function Blog({ posts }) {  return (    <div>      <h1>Blog</h1>      <ul>        {posts.map(post => (          <li key={post.id}>{post.title}</li>        ))}      </ul>    </div>  );}export default Blog;
    ```
    

### SSR vs SSG Comparison

|Feature|SSR (getServerSideProps)|SSG (getStaticProps)|
|---|---|---|
|Render Time|At each request|At build time|
|Performance|Slower (real-time rendering)|Ultra fast (pre-generated static files)|
|Data Updates|Always up-to-date|Requires rebuild or revalidation|
|SEO|Excellent for dynamic content|Excellent if content doesn't change often|
|Use Cases|Dynamic content, dashboards, news|Static content, blogs, landing pages|

## How SSR Works

1. User accesses a URL (e.g., `/products`)
2. Server executes React code, fetches necessary data, generates complete HTML
3. Server sends the filled HTML page to the user's browser
4. Once displayed, React takes over to add interactive functionality

## How SSG Works

1. Build process starts, Next.js generates all static pages
2. Server prepares HTML for all pages at build time
3. Static pages are stored and can be served immediately
4. When a user accesses a page, they immediately get the static page without calculation delay

## API in Next.js

### Creating an Internal API

```jsx
// pages/api/hello.js
export default function handler(req, res) {
  if (req.method === 'GET') {
    res.status(200).json({ message: 'Hello' });
  } else if (req.method === 'POST') {
    const { name } = req.body;
    if (!name) {
      return res.status(400).json({ error: 'Name is required' });
    }
    res.status(200).json({ message: `Hello, ${name}!` });
  } else {
    res.status(405).json({ error: 'Method Not Allowed' });
  }
}
```

### Consuming External APIs

1. Server-side with `getServerSideProps`:
    
    ```jsx
    export function getServerSideProps() {
      return fetch('https://api/')
        .then(res => res.json())
        .then(posts => {
          return { props: { posts } };
        })
        .catch(error => {
          console.error('Error fetching data:', error);
          return { props: { posts: [] } };
        });
    }
    ```
    
2. Client-side with `useEffect`:
    
    ```jsx
    function Post() {
      useEffect(() => {
        // Fetch call here
      }, []);
      return (
        // Component rendering
      );
    }
    ```
    

## Error Handling in Next.js

### Custom Error Pages

```jsx
// pages/404.js
export default function Custom404() {
  return (
    <div style={{ textAlign: 'center', marginTop: '50px' }}>
      <h1>404 - Page non trouvée</h1>
      <p>Oups ! La page n'existe pas.</p>
    </div>
  );
}
```

### Error Handling in Data Fetching

```jsx
export function getServerSideProps() {
  return fetch('https://api/')
    .then(res => {
      return res.json();
    })
    .then(data => {
      return { props: { data } };
    })
    .catch(error => {
      return { notFound: true }; // Redirects to 404 page
    });
}
```

### Important Return Values for Data Fetching Methods

|Attribute|Description|Example|Supported Methods|
|---|---|---|---|
|notFound|Indicates page doesn't exist, redirects to 404|`return { notFound: true };`|getServerSideProps, getStaticProps|
|props|Passes data to the page|`return { props: { data } };`|getServerSideProps, getStaticProps|
|redirect|Redirects user to another URL|`return { redirect: { destination: '/new-url'} };`|getServerSideProps, getStaticProps|
|revalidate|Revalidates static page at intervals|`return {props: { data }, revalidate: 60};`|getStaticProps|

## Import Aliases in Next.js

### Problem with Relative Imports

```jsx
import Button from "../../../../components/ui/Button";
import Card from "../../../../components/ui/Card";
```

- Hard to read and maintain
- If a file is moved, all imports must be updated

### Solution with Aliases

```jsx
// With aliases
import Button from "@/components/ui/Button";
import Card from "@/components/ui/Card";
```

### Configuration in jsconfig.json or tsconfig.json

```json
{
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@components/*": ["src/components/*"]
    }
  }
}
```

### Common Alias Conventions

- `@/*` - Absolute paths to specific folders
- `~/*` - Internal modules
- `$/assets/*` - Static files (images, styles)

### Recommended Configuration

```json
{
  "compilerOptions": {
    "baseUrl": "./",
    "paths": {
      "@/components/*": ["src/components/*"],
      "~/lib/*": ["src/lib/*"],
      "$/assets/*": ["src/assets/*"]
    }
  }
}
```

### Example Usage

```jsx
import Button from "@/components/Button";
import { fetchData } from "~/lib/api";
import logo from "$/assets/logo.png";
```

## Common Exam Questions

1. **Question**: You're developing a Next.js application with static pages (/about, /contact) and a blog section with dynamic URLs (/blog/[id]). You want each URL to automatically correspond to a file without manually managing navigation. What type of routing should you use?  
    **Answer**: Dynamic routing
    
2. **Question**: You're working on a Next.js application where you need to apply a global theme and manage a user context across the entire application. Which file should you use for each need?  
    **Answer**: _app.js
    
3. **Question**: You need to create an API that manages users and is only consumed by your Next.js application. This API should be directly integrated into your project without requiring an external server. Where should you place these API routes?  
    **Answer**: pages/api/
    
4. **Question**: You're developing a Next.js application that displays a list of products from a database. These products must be displayed with always up-to-date data, as inventory can change at any time. Additionally, SEO is a key factor for this page. What content generation technique should you use?  
    **Answer**: SSR (Server-Side Rendering)