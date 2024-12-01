to create a deployement with an image that is on dockerhub:

```
kubectl port-forward synergychat-web-fbdb8d849-4pdvp 8080:8080
```
the second part is from the id of the container you can get it from the `kubectl get deployment`.

to edit the configuration of the deploymet you can run:
```
kubectl edit deployment synergychat-web
```
this will open the yml file in a your default editor.
if we change the replicas under the specs we will get the number of replicas as the pods. once we changed the yaml file , then the deployments changed imediatly. as we check in the `kubectl get deployments`

to delete a pod you can use the delete option:
```
kubectl delete pod <Pod name>
```

every pod in kubernetes cluster has a unique internal to k8s IP address.
All the resources inside a k8s cluster are virtualized. So, the IP address of a Pod is not the same as the IP address of the Node it's running on. It's a virtual IP address that is only accessible from within the cluster.

to get the ip address of each pod we can use 
```
kubectl get pods -o wide
```


if you run `kubectl proxy` you will start a server thats running on pod 8081(usually) and in the browser if you visit :
`http://127.0.0.1:8001/api/v1/namespaces/default/pods`
you will get a big nasty json that describes your pods.
