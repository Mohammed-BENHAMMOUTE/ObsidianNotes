# Part 3

## 1. **Create K8s manifests**:
create the namespace exam:
  
```yml
apiVersion: v1
kind: Namespace
metadata:
	name: exam
	labels:
		name: exam
		environment: dev
```


create the configmap:
+ backend config map:
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
	name: backend-config
	namespace: exam

	labels:
		app: backend
		component: config
data:
	DB_HOST: postgres-service
	DB_PORT: "5432"
	DB_NAME: my_database
	SPRING_PROFILES_ACTIVE: prod
```
+ frontend config map:
```yml
apiVersion: v1
kind: ConfigMap
metadata:
	name: frontend-config
	namespace: exam
	labels:
		app: frontend
		component: config
data:
	VITE_API_URL: "http://backend-service:8080"
```

 + postgres config-map:

```yml
apiVersion: v1
kind: ConfigMap
metadata:
	name: postgres-config
	namespace: exam
	labels:
		app: postgres
		component: config
data:
	POSTGRES_DB: my_database
```

+ Secrets:
```yml
apiVersion: v1
kind: Secret
metadata:
	name: db-credentials
	namespace: exam
	labels:
		app: database
		component: credentials
type: Opaque
data:
	DB_USER: cG9zdGdyZXM= # postgres (base64 encoded)
	DB_PASSWORD: cG9zdGdyZXMxMjM= # postgres123 (base64 encoded)
```

+ StatefullSet:

Postgres statefullset:
```yml
apiVersion: apps/v1
kind: StatefulSet
metadata:
	name: postgres
	namespace: exam
	labels:
		app: postgres
spec:
	serviceName: postgres-service
	replicas: 2
	selector:
		matchLabels:
			app: postgres
	template:
		metadata:
			labels:
				app: postgres
		spec:
			containers:
				- name: postgres
				  image: postgres:17-alpine
				  ports:
					- containerPort: 5432
					name: postgres
				  envFrom:
					containers:
						- configMapRef:
							name: postgres-config
						- secretRef:
							name: db-credentials
				  env:
					- name: PGDATA
					  value: /var/lib/postgresql/data/pgdata
					resources:
						requests:
							memory: "256Mi"
							cpu: "250m"
						limits:
							memory: "512Mi"
							cpu: "500m"
				  livenessProbe:
						exec:
							command:
								- pg_isready
								- -U
								- postgres
						initialDelaySeconds: 30
						periodSeconds: 10
						timeoutSeconds: 5
				  readinessProbe:
						exec:
						command:
							- pg_isready
							- -U
							- postgres
						initialDelaySeconds: 5
						periodSeconds: 5
						timeoutSeconds: 1
					volumeMounts:
						- name: postgres-storage
						  mountPath: /var/lib/postgresql/data
	:
			- metadata:
				name: postgres-storage
			spec:
				accessModes: [ "ReadWriteOnce" ]
				resources:
				requests:
				storage: 1Gi
```


**summery of the statefullset**:
	1. I'm loading the environment variables from the Configmap :
	   `Postgres-config` ConfigMap (database name), and the secrets from secret  `db-credentials` (username/password).
	2. `env` specifies the Postgres data directory:
	   `/var/lib/postgresql/data/pgdata`
	3. Resource management:
	   in the `resources` i specified int `requests` the minimum needed resources, and in `limits` the maximum allowed resources.
	3. Health Monitoring:
	   divided into two parts the `liveness` probing to check if the container is alive and `readiness` probing to check if the pod can receive traffic. In both cases we are going to execute the command `command: ["pg_isready", "-U", "postgres"]`, 
	   this command effectively checks of the container is Healthy. the difference between `liveness` and `readiness` probing is in, the `initialDelaySeconds` for the liveness is set to 30s, to give time to the container to build and start, before checking its health. However for the `readiness` probing the `initialDelaySeconds` is set to 5s, to ensure minimum down time, and give `K8s` the opportunity to recover as quickly as possible.
	   #Note:
		   the Health Monitoring that I implemented will do the Job for this application, but for more sophisticated application (more data intensive), we need more robust Health checks. an example i found in this amazing article by [Bibin Wilson](https://devopscube.com/author/bibinwilson/ "View all posts by Bibin Wilson"), you can check it out from here: [article](https://devopscube.com/deploy-postgresql-statefulset/).
		   so what he did (among other things) is to Actually connecting to database using proper authentication and adding failure thresholds more robust health checks.



```yml
livenessProbe:
	exec:
		command:
			- bash
			- -ec
			- 'PGPASSWORD=$POSTGRES_PASSWORD psql -w -U "postgres" -d "postgres" -h 127.0.0.1 -c "SELECT 1"'
	initialDelaySeconds: 30
	periodSeconds: 10
	timeoutSeconds: 5
	successThreshold: 1
	failureThreshold: 6
readinessProbe:
	exec:
		command:
			- bash
			- -ec
			- 'PGPASSWORD=$POSTGRES_PASSWORD psql -w -U "postgres" -d "postgres" -h 127.0.0.1 -c "SELECT 1"'
	initialDelaySeconds: 5
	periodSeconds: 5
	timeoutSeconds: 1
	successThreshold: 1
	failureThreshold: 6
```


4. volumeClaimTemplate:
	Kubernetes will dynamically create a **Persistent Volume Claim (PVC)** for each pod in the StatefulSet. Each PVC requests **1Gi of storage** with access mode **ReadWriteOnce** (one pod can write to the storage at a time).


+ **Create a headless service for the statefullset:**
Normal Kubernetes services act as load balancers and **follow round-robin logic** to distribute loads. Headless services don’t act like load balancers. Also, normal services are assigned IPs by Kubernetes whereas Headless services are not.

In the case of Postgres servers, we require a headless service because it is a requirement for the PostgresSQL statefulset.

```yml
apiVersion: v1
kind: Service
metadata:
	name: postgres-service
	namespace: exam
	labels:
		app: postgres
spec:
	clusterIP: None
	selector:
	app: postgres
	ports:
		- port: 5432
		targetPort: 5432
		name: postgres
```

 + frontend / backend services:
   1. frontend:
```yaml
apiVersion: v1
kind: Service
metadata:
	name: frontend-service
	namespace: exam
spec:
	type: LoadBalancer
	selector:
		app: frontend
		ports:
		 - name: http
		   port: 80
		   targetPort: 80
		   protocol: TCP
```

2. backend:
```yml
apiVersion: v1
kind: Service
	metadata:
	name: backend-service
	namespace: exam
	labels:
		app: backend
spec:
	type: ClusterIP
	selector:
		app: backend
		ports:
			- name: http
			port: 8080
			targetPort: 8080
			protocol: TCP
```


+ Deployments:
		1. backend:
```yml
apiVersion: apps/v1
kind: Deployment
metadata:
	name: backend
	namespace: exam
	labels:
		app: backend
spec:
	replicas: 2
	selector:
		matchLabels:
		app: backend
	template:
		metadata:
			labels:
				app: backend
		spec:
			containers:
				- name: backend
				  image: mohammedbenhammoute/backend:1.0
				  ports:
				- containerPort: 8080
				  name: http
			envFrom:
				- configMapRef:
				  name: backend-config
				- secretRef:
				  name: db-credentials
		resources:
			requests:
				cpu: "250m"
				memory: "512Mi"
			limits:
				cpu: "500m"
				memory: "1Gi"
		livenessProbe:
			httpGet:
				path: /actuator/health
				port: 8080
			initialDelaySeconds: 60
			periodSeconds: 10
		readinessProbe:
			httpGet:
				path: /actuator/health
				port: 8080
			initialDelaySeconds: 30
			periodSeconds: 5
```
2. frontend:
``` yml

apiVersion: apps/v1
kind: Deployment
metadata:
	name: frontend
	namespace: exam
	labels:
		app: frontend
	spec:
		replicas: 2
		selector:
			matchLabels:
			app: frontend
		template:
			metadata:
				labels:
					app: frontend
			spec:
				containers:
					- name: frontend
					image: mohammedbenhammoute/frontend:1.0
				ports:
					- containerPort: 80
					name: http
				envFrom:
					- configMapRef:
						name: frontend-config
				resources:
					requests:
						cpu: "200m"
						memory: "256Mi"
					limits:
						cpu: "400m"
						memory: "512Mi"
					livenessProbe:
						httpGet:
							path: /
							port: 80
						initialDelaySeconds: 30
						periodSeconds: 10
					readinessProbe:
						httpGet:
							path: /
							port: 80
						initialDelaySeconds: 15
						periodSeconds: 5
```
1. starting minikube:
![[Pasted image 20241214180550.png]]
2.creating the exam namespace:
![[Pasted image 20241214180620.png]]
3.creating the configmaps:
![[Pasted image 20241214180711.png]]
4.creating the secrets:
![[Pasted image 20241214180743.png]]
5.creating the Postgres Headless service: 
![[Pasted image 20241214180910.png]]
6.creating the postgres StatefullSet:
![[Pasted image 20241214180953.png]]
5.creating the backend service:
![[Pasted image 20241214181030.png]]
6.creating the beckend deployment:
![[Pasted image 20241214181124.png]]
7.creating the frontend service:
![[Pasted image 20241214185752.png]]
8.creating the frontend deployment:
![[Pasted image 20241214181212.png]]
8. making sure everything works:
![[Pasted image 20241214182003.png]]


## Quotas for the memory and CPU:
added the directory and file  **`/quotas/exam-quotas.yml`**  and **`/limit-range/exam-limit-range.yml`**:

**ResourceQuota (Namespace Level)**
```yml
apiVersion: v1
kind: ResourceQuota
metadata:
	name: exam-quota
	namespace: exam
	spec:
		hard:
			requests.cpu: "4"
			requests.memory: 8Gi
			limits.cpu: "8"
			limits.memory: 16Gi
			pods: "20"

```
**LimitRange (Container Level)**
```yml
apiVersion: v1
kind: LimitRange
metadata:
	name: exam-limits
	namespace: exam
	spec:
		limits:
		- default:
			cpu: 500m
			memory: 512Mi
			defaultRequest:
			cpu: 200m
			memory: 256Mi
			type: Container
```
 **ResourceQuota (Namespace Level)**
- Sets maximum resources for entire namespace:
    - Total CPU requests: 4 cores
    - Total Memory requests: 8GB
    - Total CPU limits: 8 cores
    - Total Memory limits: 16GB
    - Maximum 20 pods allowed
 
**LimitRange (Container Level)**
- Sets default limits for containers:
    - Default CPU limit: 500 milliCores (0.5 CPU)
    - Default Memory limit: 512MB
    - Default CPU request: 200 milliCores (0.2 CPU)
    - Default Memory request: 256MB

after updating we check :
![[Pasted image 20241214190921.png]]

![[Pasted image 20241214190956.png]]

## 3. RBAC roles:

1. **ServiceAccount (exam-serviceaccount.yml)**

- Creates identity for applications/users
- Named "exam-user"
- Scoped to "exam" namespace
```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
	name: exam-user
	namespace: exam
```

2. **Role (exam-role.yml)**

- Defines permissions:
    - Core Resources (`""` apiGroup):
        - pods
        - services
        - configmaps
        - secrets
    - Apps Resources (`apps` apiGroup):
        - deployments
        - statefulsets
- Allows read-only operations:
    - get: retrieve single resource
    - list: retrieve multiple resources
    - watch: stream updates

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
	name: exam-role
	namespace: exam
	rules:
		- apiGroups: [""]
		  resources: ["pods", "services", "configmaps", "secrets"]
		  verbs: ["get", "list", "watch"]
		- apiGroups: ["apps"]
		  resources: ["deployments", "statefulsets"]
		  verbs: ["get", "list", "watch"]
```

3. ** RoleBinding (exam-rolebinding.yml)**:
- Links ServiceAccount to Role
- Maps "exam-user" to "exam-role"
- Activates permissions in "exam" namespace

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
	name: exam-rolebinding
	namespace: exam
subjects:
 - kind: ServiceAccount
   name: exam-user
   namespace: exam
roleRef:
  kind: Role
  name: exam-role
  apiGroup: rbac.authorization.k8s.io
```

to test this we run the following commands:
![[Pasted image 20241214215729.png]]
in the configuration i gave the user a read-only permissions, thats why when we run can-i get we get `yes`, but when i run can i `delete` we get no.

## 4. Disruption Budget
Kubernetes offers features to help you run highly available applications even when you introduce frequent voluntary disruptions.

A PDB specifies the number of replicas that an application can tolerate having, relative to how many it is intended to have. For example, a Deployment which has a `.spec.replicas: 5` is supposed to have 5 pods at any given time. If its PDB allows for there to be 4 at a time, then the Eviction API will allow voluntary disruption of one (but not two) pods at a time.


first, let's create a directory that will contain the necessary yaml files:
![[Pasted image 20241214232828.png]]
then for each deployment/statefullset of our container we create yaml file.
![[Pasted image 20241214233217.png]]
1. pdb-backend.yaml
```yaml
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
	name: backend-pdb
	namespace: exam
spec:
	minAvailable: 1 #we tolerate having min of 1 container at all time.
	selector:
		matchLabels:
			app: backend
```
2. pdb-frontend.yaml
```yaml
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
	name: frontend-pdb
	namespace: exam
	spec:
		minAvailable: 1 # At least 1 pod must be available
		selector:
			matchLabels:
				app: frontend
```
3. pdb-postgres.yaml
```yaml
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
	name: postgres-pdb
	namespace: exam
	spec:
		minAvailable: 1 # At least 1 database pod must be available
		selector:
			matchLabels:
			app: postgres
```

![[Pasted image 20241214234908.png]]

let's test this by draining our node:
I ran this command:  `kubectl drain minikube --ignore-daemonsets --delete-emptydir-data --force`


![[Pasted image 20241214235611.png]]
![[Pasted image 20241214235731.png]]
we can see that we get errors because it cannot evict pod as it will violate pod's disruption budget.

## 5. Liveness readiness startup probs:
for each deployment/statefullSet I added the following configuration:
for the frontend:
```yaml
livenessProbe:
	httpGet:
		path: /
		port: 80
	initialDelaySeconds: 30
	periodSeconds: 10
	timeoutSeconds: 5
	failureThreshold: 3
readinessProbe:
	httpGet:
		path: /
		port: 80
	initialDelaySeconds: 15
	periodSeconds: 5
	timeoutSeconds: 3
	failureThreshold: 3
startupProbe:
	httpGet:
		path: /
		port: 80
	initialDelaySeconds: 30
	periodSeconds: 10
	failureThreshold: 30
```

backend:
```yaml
		** existing configuration **
        livenessProbe:
          httpGet:
            path: /actuator/health/liveness
            port: 8080
          initialDelaySeconds: 60
          periodSeconds: 10
          timeoutSeconds: 5
          failureThreshold: 3
        readinessProbe:
          httpGet:
            path: /actuator/health/readiness
            port: 8080
          initialDelaySeconds: 30
          periodSeconds: 5
          timeoutSeconds: 3
          failureThreshold: 3
        startupProbe:
          httpGet:
            path: /actuator/health
            port: 8080
          initialDelaySeconds: 30
          periodSeconds: 10
          failureThreshold: 30
```

3. postgres:

```yaml
        ...existing code...
        livenessProbe:
          exec:
            command:
            - /bin/sh
            - -c
            - exec pg_isready -U postgres -h localhost
          initialDelaySeconds: 60
          periodSeconds: 10
          timeoutSeconds: 5
          failureThreshold: 3
        readinessProbe:
          exec:
            command:
            - /bin/sh
            - -c
            - exec pg_isready -U postgres -h localhost
          initialDelaySeconds: 5
          periodSeconds: 10
          failureThreshold: 3
        startupProbe:
          exec:
            command:
            - /bin/sh
            - -c
            - exec pg_isready -U postgres -h localhost
          initialDelaySeconds: 30
          periodSeconds: 10
          failureThreshold: 30
```

## 7. Ingress


**<mark style="background: #FF5582A6;">!</mark> Problem with the current statefullset**:
In the current StatefulSet configuration with 2 replicas, each PostgreSQL instance operates independently with its own storage volume (1Gi each) through `volumeClaimTemplates`. This setup, while providing high availability, doesn't implement data replication or synchronization between pods, potentially leading to data inconsistency as each instance maintains its own separate dataset. A more production-ready approach would involve implementing PostgreSQL streaming replication with a master-slave configuration to ensure data consistency across all instances.
(More about this later).
