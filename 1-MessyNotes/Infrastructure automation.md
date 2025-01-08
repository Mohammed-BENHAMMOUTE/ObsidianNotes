[[DevOps]]
tester dans une environnement de testes qui simule les conditions de l'environment de production.
we cant simulate to 100% the conditions of the production environment.
solution: Automation -> Infrastructure provisioning  + maintenance of Infrastructure = Terraform.
configuaration management tool : Ansible = manage infreastructure + **Initial Application Setup + Manage applications.**

we usually use cloud providers, to avoid more configuration.

Ansible is **agentless** (temporarly connecting remotely via SSH) (dont need to install other agents in these servers)
	=>  No additianal deployment / upgrade effort.
	
1. Ansible components :
		for complex tasks that we cant execute in a single module we can use Playbooks which are a set of modules that execute sequencially.
	a playbook is a single or more plays.
		
	
To look up:
- [ ] SSH connections, how can i connect via ssh with a remote server.


