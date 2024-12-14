# Part 3


1. **Create K8s manifests**:

+ create the namespace exam:
  
```yml
apiVersion: v1
kind: Namespace
metadata:
	name: exam
	labels:
		name: exam
		environment: dev
```
+ create the configmap:
1. backend config map:
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
2. frontend config map:
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