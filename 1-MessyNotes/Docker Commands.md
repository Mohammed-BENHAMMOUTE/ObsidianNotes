[[Docker]]
1. To open a terminal in the container:

```bash
docker run -it <Container name> 
```

2. you can give a container a hostname before going to the terminal :

```bash
docker run -h CONTAINER -it debian /bin/bash
```

3. we can get more information using the running container:
``` bash
docker inspect stupefied_turing
```

4. We can get more precise information using grep or Go templates:
   + `docker inspect stupefied_turing | grep IPAddress`
   + `docker inspect --format {{.NetworkSettings.IPAddress}} container name.`
   
5. Inspecting the changed files in the container:
	`docker diff <name of the container`;
6. a list of everything that happened in the container can be obtained using the command:
```bash
docker logs <name of the conatiner>
```
7. to get a list of all containers, stopped also you can use:
```Shell 
docker ps -a
```
8. to remove a container you can use :
   `docker rm <name-of-the-container>`
9. Clean Up Stopped Containers:
```Shell
docker rm -v $(docker ps -aq -f status=exited)
```
10. u avoid piling up stopped containers by giving the argument --rm that deletes the container after stopping:

```Shell
docker run --rm debian
```

11. to create an image based on a state of closed container we can use commit:
```bash
docker commit <container name> <the new image name>
// we can rerun the given container with the following code
docker run test/cowsayimage /usr/games/cowsay "Moo"
```
12. to stop all running containers 
```shell 
docker stop $(docker ps -aq)
```
the difference between the stop and down commands is that down is used to compose down  the container and then kill it. in the other hand the stop command is going only stop the conatiner.

13. To see all stopped containers we can run the following command:
```shell 
docker ps -a --filter "status=exited"
```
14. to start an existing stopped container:
```shell 
docker start -ai <Conatainer Id>
```
15. create a new network with the specified driver:
```shell
docker network create -d bridge my-net
```
#### Dockerfile:
first we need the base image:
we can use the `FROM` in the top of the dockerfile that will specify the base image that our docker image will be built upon.
Every Docker image starts from a base image, which provides the underlying environment.

to link two containers using a network link we can do the following:

```bash 
docker run --rm -it --link myredis:redis redis /bin/bash 
```





















`data persistance?`
use volumes for shared data between multiple containers.
Docker provides this through the concept of volumes. Volumes are files or
directories that are directly mounted on the host and not part of the normal union file system. This means they can be shared with other containers and all changes will be made directly to the host filesystem. There are two ways of declaring a directory as a volume, either using the VOLUME instruction inside a Dockerfile or specifying the -v flag to docker run.
![[Pasted image 20241014225435.png]]


`what is the difference between RUN and CMD?`

the difference is that for the `RUN` command it creates a new layer in the image, and executes during build time.

However the `CMD`, specefies the default command to execute when the container starts up.

meaning that `CMD` is a setup instruction that is executed during building, and cmd ad the default program to launch when running.

one more thing is that the docker command CMD can be overriden, at runtime (meaning when running the caintainer) however the RUN command is Baked into our image.

we can override the `CMD` of the container, using this command:
```Shell
docker run <conatainers_name> python different.py
```


what about entrypoint?
`ENTRYPOINT`:
	defines the executable that will always run when the conatiner starts.
	any command line argument passed to the `docker run` command will be appended  to the ENTRYPOINT.

you can create a docker git container and run the bash mode in it and access git for example:
```shell
docker run -itd mohammedbenhammoute/labs:v1.0
docker attach <id of the container>
```

we can also build an image from a dockerfile that doesnt have the name Dockerfile:
```shell
docker build -t mohammedbenhammoute/add-lab -f <name of the dockerile>
```
the difference between docker attach and docker exec is that docker attach, attahces you the main running process inside the container.

You can name your stages, by adding an AS to the FROM instruction.By default, the stages are not named, and you can refer to them by their integer number, starting with 0 for the first FROM instruction.You are not limited to copying from stages you created earlier in your Dockerfile, you can use the COPY --from instruction to copy from a separate image, either using the local image name, a tag available locally or on a Docker registry.

```
COPY --from=nginx:latest /etc/nginx/nginx.conf /nginx.conf
```


### Workdir in Dockerfile:
if we specify that we ahve first a warking director with the / and then specify another workdir with just the name say folder1


we can also use a workdir and do the stuff we want to do with it at the build time, and then in the same  specify a new working directory for working

we can also specify an env var in the dockefile and use it with the workdir with the $.



in general its better to use a single run command. this reduces the number of layers in the images and there for the size of the image.
![[Pasted image 20241101233315.png]]
# docker healthchack 

The HEALTHCHECK instruction in a Dockerfile is used to tell Docker how to test if a container is still working properly.
- The HEALTHCHECK command runs **periodically** (by default every 30 seconds) while the container is running
- Based on the result of the command, Docker marks the container as:
    - healthy (exit code 0)
    - unhealthy (exit code 1)
    - starting (when checks haven't completed yet)

Here's a simple example:
```yaml 
# Check if web server is responding HEALTHCHECK --interval=30s --
timeout=3s \ CMD curl -f http://localhost/ || exit 1
```
Key points:

- The command is used TO determine health status, not run after unhealthy status
- You can configure:
    - --interval: How often to run (default: 30s)
    - --timeout: Maximum time to wait for command (default: 30s)
    - --retries: Number of consecutive failures before marking unhealthy (default: 3)
    - --start-period: Initial grace period (default: 0s)


we add the exit 1 to the cmd so we can exit the container with the code of 1 if the first command return 1. meaning an error has occured, generally speaking code 1 means an error has occured. code 0 means the application run seccessfully.
