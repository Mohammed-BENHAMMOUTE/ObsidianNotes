[[DevOps]]
Deliver **secure** software, rapidly , frequently and reliably. 
in the traditional security, in the waterfall and the Agile methods we only focus on securing our applications, after deployments, which is not the best way to do it, because code changes frequently and we use opens source libraries / apis / microservices => this halts the speed of delivery. also waiting till the end of the waterfall cycle is too late => friction between dev team and friction team.

In the devops era ,  we have to integrate the security in each step of devops.
devsecops is an extension of devops to include security while propagating that security is everyones responsability. 

Lesson: 
```txt
Test early and test often.
```
solution: 
```txt 
shift security left.
```

Establish Continuous security controls. Integrate with ci/cd pipelines. educate, establish a culture of communication, Focus on Traceability, Audit-ability , and Visibility.


```txt
DEVSECOPS = SHIFT SECCURITY LEFT + AUTOMATION + CULTURAL CHANGES
```

HOW DO WE DO DEVSECOPS  ?
Injecting sec in devops pipelines. 
Threat Modeling? 

Precommit hooks ?
`talisman`
local talisman, or a script using talisman ? 
or we can also configure the repo to scan our code.

use vault , u can install it in the cluster, or you can put it in its own cluster.


testing prebuild: 
SCA (software composition analysis)
SBOM : software builds of material.
what is the relationship between sca and sbom?
SAST uses white boxing.

what is the differnece between stast and dast.
scan sur le code c du regex.

challenge in the project, where will we put the DAST.
