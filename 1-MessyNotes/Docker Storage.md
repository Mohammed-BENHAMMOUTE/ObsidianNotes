[[Docker]]
we need to persist data, there for the need of a virtual storage system.
les donnes sont stocke par default dans le repertoire var/lib/X.

there are three solutions:
1. Using Volume.
2. BindMount.
3. Using Tmpfs.

## Volume:
its the best way to persisit data in docker.
the data is stored in ''var/lib/docker/volumes" in Linux.
there are three types of Volume storage in Docker:

#### a. Host Volumes:
you decide where the data will be duplicated on the host machine.
```shell
docker run -v /home/mount/data:/var/lib/mysql/data
```
the first part is for the host machine, the second part is for the container.

#### b. Anonymous Volumes:
for each container hash is generated and then a floder is created at the container's `var/lib/docker/volumes/hash_gen/_data`

#### c. Named Volumes:
on fait la reference du volume par son nom, c'est le meilleur type conseiller pour le developpement:
on fait reference au volume par son nom.

`docker run - v name:var/lib/mysql/data`
![[Pasted image 20241016223345.png]]


its not a good idea to put databases in containers in production.
