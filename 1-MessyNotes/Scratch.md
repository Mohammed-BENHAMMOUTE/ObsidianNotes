why do we need Kubernetes, doesnt docker only suffice?
no, it doesnt, when the number of docker containers become big enough, its almost impossible to manage docker alone, also docker doesnt address failures in case one of the containers goes down or the container runtime goes down.

so the two main problems that docker has are maintainability and scalability.  which kubernetes solves.

one of the cool things Kubernetes achieves is the zero down time updates, which is achieved by creating new pods for the new updated version and then scaling them up, and at the same time scaling down old pods with the previous version. all that while maintaining minimum number of pods available and needed.

another feature is the detection of problems and solving them.


## Kubernetes architecture:

1. **Cluster**: is a set of virtual or physical  machines used by Kubernetes to run an application.
2. **Node**: c'est une machine physique or virtuelle utilise par le cluster, et contient le Container runtime.
3. **POD**: smallest unit of deployment in Kubernetes. Kubernetes pods contain 1-2 containers - a primary application container and potentially a supporting sidecar container.
4. Kubectl: CLI application that allows interaction with the Kubernetes Clusters.


Kubernetes uses the master worker design pattern , we have one node which is the master node that controls all other nodes, meaning worker nodes.

**Master node**: responsible for managing load management and Cummunication between the worker nodes.

has mainly four elements in it:
1. **etcd**:key value database , used as a the only source of truth for all information about the kubernetes cluster state of being.
2. **API SERVER**: In essence, the API Server acts as the _heart_ of the Kubernetes control plane. It manages access, handles resource operations, enforces cluster policies, and maintains communication between all Kubernetes components, ensuring that the cluster stays in sync with its desired state.
3. **Scheduler**: 



objects in kuernetes are? :
which are persistent entities representing the state of your cluster.
services solves for us the problem of the service discovery.


liveness prod ready ness prod?

