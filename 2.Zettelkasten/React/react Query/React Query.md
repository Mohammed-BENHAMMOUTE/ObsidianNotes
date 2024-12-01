[[REACT]]
[[React Query]]

you need to wrap you application in a react query provider and instantiate a new react query client
```
const queryClient = new QueryClient();
ReactDOM.createRoot(document.getElementById("root").reder(
	<QueryClientProvider client = {queryClient}>
		<App />
	<QueryClientProvider />
))
```
using react query u can do two types of things,  query and a mutation.
we can use two custom hooks {useQuery, useMutation} frmo "@tanstack/react-query",
```
const postQuery = useQuery({
	queryKey: ["posts"], //a unique identifier for the query, its allways an array//
	queryFn: () => wait(1000).then(() =>[...post]);
})
```
and then we can chain other methods to these instence variables, like isLoading boolean attribute, also isError...
```
if (postQuery.isLoading) return <h1> LOading .. </h1>
if (postQuery.isError) return <pre>{JSON.Stringify(postsQuery.error)} </pre>
```
it has automatic retries built in.
in case of succes u vcan find the data in the query.data
```
postQuert.data.map({
	<div>
		<p>Hello there</p>
	</div>
})
```
## Mutation:

we us the mutation hook for mutations:
`const newPostMutation = useMutaion({
		mutautionFn: title => {
			return wait(1000).then(() => {
				POSTS.push({id: crypto.randomUUID(), title })
			})
		}
}) `

we can use the dev tools.
if we only use the code above the new value of posts will not be rendered, we need to invalidate the queries so it feches using the array identifier, to refetch the data. and we use `the useQueryClient` hook and we call on an instance of it this hook, and we add to the mutation function declared on `useMutation` the function `invalidateQueries(["posts"])` here the ["posts"] is the identifier of the query, so we use the query on the mutation.