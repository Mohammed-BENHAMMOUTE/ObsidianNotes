the chroot comand.
what is the difference between images and containers.

Conatiners is an instantiation of an image. the image est l'ensemble des instructions pour cree une conteneur.

on peut sauvegarder cette image dans un docker registry.
par example docker hub.

docker inspect
docker exec

containers work with namespaces and cgroups.
what is the difference between kernels and VMs?
in VMs u You use the vm kernel , but in the container version you just use the same kernel as all of the the other images running 

namespace is a way to sugreagate what sees what!
one caviate of this namespaces is that you cant control the ressources that each one uses. thats where controll groupes come in , or what we call cgroups.


