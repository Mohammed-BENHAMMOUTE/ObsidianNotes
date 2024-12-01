[[Kubernetes]]
A [ReplicaSet](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/) maintains a stable set of replica Pods running at any given time. It's the thing that makes sure that the number of Pods you want running is the same as the number of Pods that are actually running.

You might be thinking, "I thought that's what a Deployment does." Well...yes.

A Deployment is a higher-level abstraction that manages the ReplicaSets for you. You can think of a Deployment as a wrapper around a ReplicaSet. Here's the rub:

_You will probably never use ReplicaSets directly._ I just need to mention what they are because you'll hear the term thrown around, and might even see them referenced in logs and such.

to get the number of replicaset you can run the following command:
```
kubectl get replicasets
```
Just like with pods, notice that _we never directly created the replica set_. We created a deployment, and the deployment created the replica set.

