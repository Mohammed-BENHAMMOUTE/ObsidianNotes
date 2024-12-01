[[Docker]]

#### Difference between a docker container and an image
**Images**:
+ Docker image is a blueprint or template that contains everything needed to run an application. the code , the libraries , dependencies environment variables, and configuration files;
+ it is immuatable and read only.
+ think of it as a snapshot or a static version of the application at a particular point of time.
- Images are used to create containers, but they do not run by themselves.
- You can share Docker images by pushing them to registries (like Docker Hub).

**Containers**:
- A Docker container is a **running instance** of a Docker image.
- It is a **lightweight, executable package** that contains the environment and the application code from the image.
- Containers are **mutable** and **ephemeral**. You can run, stop, restart, and modify them during their lifetime.
- While running, containers create a writable layer on top of the image, allowing changes such as file modifications, which are lost when the container is deleted unless you persist them externally (via volumes, for example).


### How to push docker images to Docker Hub?
docker login to login to your account.

