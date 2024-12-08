[[docker Compose]]

the objective is to create a cluster using docker swarm, first since we are creating a cluster, where we supposedly, have multiple virtual/physical machines, then we must switch to Overlay network as the bridge network allows only single-host communication between containers.

To use Docker swarm we need to have a specification, the goal of our system, the ideal state that docker swarm must implement at all time: 

to do that we need to to create a docker-compose yaml file:
for our application consisting of frontend and backend:


```yml
services:
	frontend: 
		image: mohammedbenhammoute/frontend:1.0
		container-name: frontend-container
		ports:
			- "3000:80"
		deploy:  #specification of the deployement
			replicas: 2 #how many containers at all time
			update-config:
				parallelism: 1 #number of containers to update at a time.
				delay: 10s  # Time to wait between each container group
				order: start-first # starting the new container before stopping the old one. making sure we have minimum down time.
			restart_policy:
				condition: on-failure # restart the container if it fails.
				max_attempts: 3
			resources:
				limits:
					cpus: 0.5 # limit of 50% of one CPU core.
					memory: 512 # limits the memory usage to 518 MB.
			placement:
				# only runs on worker nodes
				constraints:
					- node.role==worker
			networks:
	# connecting to the overlay network for multihost communication:
				app-network: 
					aliases:
					#dns alias for service discovery
						- fontend-service 
			logging:
				driver:"json-file"
				options:
					max-size: "10m"
					max-file: "3"				
	backend:
		image: mohammedbenhammoute/backend:1.0
		container_name: backend-container
		
		
					 
				
				
				
			
```



