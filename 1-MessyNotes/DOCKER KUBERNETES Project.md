[[Docker]]
[[Kubernetes]]
how to create a network in docker:
```bash
docker network create --driver bridge <Name of the network>
```
how to create a volume in docker:
```bash
docker volume create postgres_data
```
if you want to create a docker image with the right configuration of the network and volume you can do the following :
```shell 
docker run -d \
--name postgres-container \
--network postgres_network \
-e POSTGRES_USER=postgres \
-e POSTGRES_DB = my_db \
-e POSTGRES_PASSWORD = postgres123 \
-v potgres_data:/var/lib/postgres/data \
-p 5432:5432 \
postgres:15-alpine
```

alternatively we can use the docker compose file:
```yml
services:
	postgres:
		container_name: postgres-container
	image: postgres:15-alpine
		networks:
			- nockNock
		ports:
			- "5432:5432"
		environment:
			POSTGRES_USER: admin
			POSTGRES_PASSWORD: admin123
			POSTGRES_DB: my_database
		volumes:
			- postgres_data:/var/lib/postgresql/data
networks:
	nockNock:
volumes:
	postgres_data:
```

## Dockerfile:
we have a Backend with spring, java needs to be compiled and we should get that .jar file.
we have to phases of our build, first the build with maven, and then the running in a runtime environment.
```Dockerfile
FROM maven:3.9.9-eclipse-temurin-17-alpine AS builder
RUN addgroup -S spring && adduser -S/home/spring/.m2/repository spring -G spring 
RUN mkdir -p /home/spring/.m2/repository && \ 
	chown -R spring:spring /home/spring/.m2

WORKDIR  /build
RUN chown spring:spring /build

USER spring

COPY --chown spring:spring pom.xml . 
RUN mvn dependency:go-offline

COPY --chown spring:spring src ./src
RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jre-alpine
RUN addgroup -S spring && adduser -S spring -G spring

RUN apk add --no-cache \
dumb-init=1.2.5-r3\
curl=8.11.0-r2

COPY --from=builder --chown=spring:spring /build/target/*.jar  app.jar

ENV JAVA_OPTS="-XX:+UseContainerSupport -XX:MaxRAMPercentage=75.0"\
SPRING_PROFILES_ACTIVE="prod"
USER spring:spring
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=3 \
	CMD curl -f http://localhost:8080/actuator/health || exit 1
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
```

with the run apk add always use --no-cache?
in the run , the && ensures that the second command only runs if the first one doesn't succeed.

how to check the container image for volunerabilities:
we use trivy:
after instlling trivy we run :
```bash
trivy image -f json -o scan_results.json mohammedbenhamoute/backend:1.0
# or simply 
trivy image <image name>
```

