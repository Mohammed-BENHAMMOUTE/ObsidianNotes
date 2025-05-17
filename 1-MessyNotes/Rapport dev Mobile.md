## Lancement du projet Android "Hello World" et test avec l'AVD

d'abord on creer un projet android avec l'option Empty views activity et avec la language java:
![[Pasted image 20250214110542.png]]
On choisit la language JAVA:
![[Pasted image 20250214110633.png]]
voici notre application:
![[Pasted image 20250214110738.png]]
7. Quelle sont les differents etapes d'un processus de build gradle?
	- **Initialisation (Initialization Phase)**
    
	    - Gradle détermine quels projets sont inclus dans le build (dans le cas d’un projet multi-modules).
	    - Il crée une instance de `Gradle` et un `Project` pour chaque module du projet.
	    - Il charge et exécute le fichier `settings.gradle(.kts)` pour configurer la structure du projet.
	- **Configuration (Configuration Phase)**
    
	    - Gradle exécute les scripts de build (`build.gradle` ou `build.gradle.kts`) pour chaque projet.
	    - Il construit le **DAG (Directed Acyclic Graph)** des tâches à exécuter.
	    - À cette étape, les tâches ne sont pas encore exécutées, mais leur structure est définie.
	- **Exécution (Execution Phase)**
	    - Gradle exécute les tâches demandées en fonction de leurs dépendances.
	    - Il suit l’ordre défini dans le DAG et exécute chaque tâche dans le bon ordre.
	    - Cette phase peut inclure la compilation du code source, l’exécution des tests, la génération des artefacts, etc. 
8. Trouver comment configurer l'AVD ?

![[Drawing_Rapport_1]]
	on creer un device virtuelle:
	![[Pasted image 20250214112544.png]] image system:
	![[Pasted image 20250214112608.png]]
	![[Pasted image 20250214112643.png]]
	On trouve nos AVD:
	![[Pasted image 20250214112724.png]]



1. Exploration d'android studio:
	 quelles sont les principales fenetres qui apparaissent dans votre IDE (fenetre arborescence du projet )


### 9.1 Notion d'activite:

1. Executer le code precedent et expliquer le fonctionnement du cycle de vie de l'activite 