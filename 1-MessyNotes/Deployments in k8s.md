[[Kubernetes]]
deployments provide a declarative way of updating the pods and ReplicaSet. You describe your _desired state_ in a Deployment, and the Deployment Controller's job is to make the _current state_ match the _desired state_. You declare your hopes and dreams, and it's Kubernetes' job to make them come true.

to get the deployment yaml file in the terminal without having to enter to the code editor you can use:
```
kubectl get deployment <name of the deployment> -o yaml
```

to edit the deployment yaml file you can use the following command:

```
kubectl edit deployment synergychat-web
```
to download the deployment yaml file you can run:
```
kubectl get deployments <name depl> -o yaml > deployment.yaml
```

there are 5 top level fields in this file:
1. apiVersion: apps/v1  Specifies the version of the Kubernetes API you're using to create the object.
2. `kind: Deployment` - Specifies the type of object you're configuring
3. `metadata` - Metadata about the deployment, like when it was created, its name, and its ID
4. `spec` - The desired state of the deployment. Most impactful edits, like how many replicas you want, will be made here.
5. `status` - The current state of the deployment. You won't edit this directly, it's just for you to see what's going on with your deployment.
to modify the deployment that yaml file  we can do the following:

```
kubectl apply -f web-deployment.yaml
```