[[NextJs]] [[authentication]]
1. install nextjs Auth
``` shell
npm install next-auth
```

2. we should create the route using the app route handler in nextjs:
   `/app/api/auth/[...nextauth]/route.js`

```javascript
import NextAuth from 'next-auth'
import {options}  from ./options


const handler = NextAuth()

export { handler as GET, handler as POST}
```

In the same directory create a `options.ts`file

in this file we have to have the providers that we are going to be using(Github), we can also use a credetials provider.
we are going to need also a `NEXTAUTH_SECRET` in the .env.local:


```javascript
// OPTIONS.TS
import type {NextAuthOptions} from 'next-auth'
import GitHubProvider from 'next-auth/providers/github'
import CredentialsProvider from 'next-auth/providers/credentials'
export const options: NextAuthOptions = {
	providers: [
		GitHubProvider({
			clientId: process.env.GITHUB_ID as string,
			clientSecret: process.env.GITHUB-SECRET as string
		}).
		CredetialsProvider({
			name:"Credentials",
			credentials: {
				username: {
					label: "Username:",
					type: "text",
					placeholder: "your-cool-username"			
				},
				password:{
					label: "Password:"
					type:"text",
					placeholder: "Your-cool-username"
				}
			},
			async authorize(credentials){
				// This is where you need to retrieve user data
				// to verify with credentials
				// Docs: https://next-auth.js.org/configuration/credentials
				const user = {id:"42", name: "Dave", password: "nextauth"}
			if(credentials?.username === user.name && credentials?.password === user.password){
				return user;
			}else{
				return null;
			}
			}
		})
	
	],

}
```

the command to generate the secret key for us is :
```shell
openssl rans -base64 32
```

```.env
NEXTAUTH_SECRET = // generate it with the previous command.
```


to specify which files to protect you can do the following :
to protect all of the website you have to first create a middleware file called middleware in the app folder so its in the same directory as the `api` file.

``` javascript
//without a defined matcher this one line applies next-auth to the entire project
export {default} from "next-auth/middleware"

// applies next-auth only to matching routes - can be regex
// Ref: visit the documentation about this part on nextjs middleware matcher

export const config = {matcher: ["/extra", "/dashboard"]}

```


3 protection approaches :
1. Home page component :


```jsx
import {options} from "./api/auth/[...nextauth]/options"
import {getServerSession} from "next-auth/next"
import UserCard from "./components/UserCard"

export default async function Home() {
	const session = await getServerSession(options);
	return (
		<>
			{session? (
				<UserCard user={session?.user} prototype={"Home"}/> ) : (
					<h1 className="text-5xl">
						You shall Not Pass
					</h1>
				)}
		</>
	)
}
```


2. Using the redirect:
``` jsx
...
import {redirect} from "next/navigation"

export default async function ServerPage() {
	const session = await getServerSession(options)
	if(!session){
		redirect('api/auth/signin?callbackUrl=/server')
		//using that callback Url it will take us to that url after logging in.
	}

	return (
		//content of the page if the user has a jwe cookie.
	)

}
```


3. the final one is not using the protect in the component layer but using the next middleware:
```jsx
export default async function ExtraPage() {

		return <h1 className="text-5xl">Extra Page!<h1>
}
```