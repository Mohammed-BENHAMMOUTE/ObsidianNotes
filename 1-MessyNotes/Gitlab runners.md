[[DevOps]]
1. install runner for program on target host.
2. choose an executor.
3. register gitlab runner
4. run pipeline that utilizes your runner.


settings >> cicd >> runners (expand) >> we then have two types >> shared runners and specific runners.
specific runners are specific to this particular project. 


A specific runner using Docker:

as we can see here only shared runners are available for now:
![[Pasted image 20250112125520.png]]
to use project specific runner we have to first install the install the gitlab runner and register for our specific project.
we do that by first installing the binary:
![[Pasted image 20250112133938.png]]
giving the permissions:
![[Pasted image 20250112134020.png]]
creating a gitlab user:
![[Pasted image 20250112135343.png]]
![[Pasted image 20250112160545.png]]
---
using helm charts:
first lets create a namespace
![[Pasted image 20250113112400.png]]
then we create the create a service account and necessary RBAC permissions:
![[Pasted image 20250113112750.png]]
Applying the RBAC configuration:
![[Pasted image 20250113112652.png]]
retrieving the token:
![[Pasted image 20250113120355.png]]

Creating the values.yaml file for our helm chart:
![[Pasted image 20250113120252.png]]![[Pasted image 20250113120443.png]]
![[Pasted image 20250113121533.png]]


Rules in gitlab: 
