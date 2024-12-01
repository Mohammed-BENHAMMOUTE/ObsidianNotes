## Résumé Détaillé - API Design and Management
## I. Introduction aux APIs

### 1. Définition et Types
- **API (Application Programming Interface)**
  - Interface de Programmation d'Application
  - Définit le contrat/façade d'interaction avec un objet, composant ou système
  - Façade permettant à une application d'offrir des services à d'autres applications

- **Types d'APIs**
  - API interne : usage interne à l'organisation
  - API externe : usage interne + développeurs/entreprises partenaires
  - API publique : accessible au public (Open API)

- **Concept Important** : Service = Contrat (API) + Implémentation

### 2. Notion de Service

#### Définition
- Entité logicielle distribuée exposant des fonctionnalités métier
- Base du modèle d'interaction entre applications
- Périmètre fonctionnel avec sens métier identifiable et réutilisable

#### Propriétés Essentielles
1. **Abstraction**
   - Cache les détails d'implémentation
   - Expose uniquement l'interface nécessaire

2. **Contrat Standardisé**
   - Syntaxique : opérations, messages d'entrée/sortie
   - Sémantique : règles et contraintes d'exécution
   - QoS : temps de réponse, disponibilité, etc.
   - Peut avoir plusieurs contrats pour différents besoins

3. **Composition**
   - Interconnexion de plusieurs services
   - Service composite vs services composants
   - Approches : Orchestration et chorégraphie

4. **Couplage Lâche**
   - Client dépend du contrat, non de l'implémentation
   - Communication par messages standardisés
   - Indépendance des services via orchestration

5. **Découverte**
   - Services référencés dans un annuaire
   - Métadonnées pour identification
   - Processus : Enregistrement → Recherche → Utilisation

6. **Autonomie**
   - Isolation des clients
   - Sans état (stateless)
   - Indépendance au contexte d'exécution

7. **Réutilisation**
   - Par composition
   - Conforme au contrat
   - Découvrable via annuaire

### 3. Types et Granularités de Services

#### Types
1. **Service Métier/Fonctionnel**
   - Participe aux processus métier
   - Ex: gestion des absences

2. **Service Applicatif**
   - Réalise les services fonctionnels
   - Ex: service de pointage

3. **Service Technique**
   - Réalise les services applicatifs
   - Ex: service mail

#### Granularités
- Service atomique (fine granularité)
- Service composite (grosse granularité)

## II. Web Services SOAP

### 1. Contexte et Définition
- Evolution du web classique vers web programmable
- Avantages vs middlewares traditionnels :
  - Multi-langages
  - Multiplateformes
  - Standards indépendants
  - Integration Web native

### 2. Protocole SOAP

#### Structure Message SOAP
1. **Enveloppe (Obligatoire)**
   - Contient tout le message
   - Spécifie version SOAP et règles d'encodage

2. **Header (Optionnel)**
   - Métadonnées
   - Attributs :
     - Role (none/next/ultimateReceiver)
     - mustUnderstand (true/false)
     - relay (true/false)

3. **Body (Obligatoire)**
   - Données applicatives
   - Contient requête/réponse ou message de faute
   - Ne peut pas contenir les deux simultanément

#### Messages de Faute
- Elements :
  - Code (VersionMismatch, MustUnderstand, Sender, Receiver)
  - Reason
  - Node
  - Role
  - Detail

### 3. WSDL (Web Service Description Language)

#### Structure WSDL 1.1
1. **Description Abstraite**
   - `types` : définition des types de données (XSD)
   - `message` : définition des messages échangés
   - `operation` : actions disponibles
   - `portType` : collection d'opérations

2. **Description Concrète**
   - `binding` : protocole et format de données
   - `port` : point de communication
   - `service` : ensemble de ports

### 4. Implémentation (JAX-WS)

#### Approches
1. **Code First (Bottom up)**
   - Implémentation métier → WSDL généré
   
2. **Contract First (Top down)**
   - WSDL → Génération code skeleton

#### Annotations Principales
- `@WebService` : définit un service web
- `@SOAPBinding` : type messages/encodage
- `@WebMethod` : paramétrage opération
- `@WebParam` : paramétrage message
- `@WebResult` : paramétrage sortie
- `@WebFault` : paramétrage faute

#### JAX-B
- Correspondance Java ↔ XML
- Marshalling/Unmarshalling
- Génération classes Java ↔ XSD
- Validation

## III. Aspects Pratiques

### 1. Déploiement
- Conteneurs Web : Jetty, Tomcat
- Serveurs d'applications : WildFly, GlassFish

### 2. Développement Client
- Méthode Stub (wsimport)
- Proxy dynamique
- Support multi-langages (PHP, Python, etc.)

### 3. Tests
- SoapUI
- Postman
- Tests unitaires

## IV. Standards et Acteurs

### 1. W3C
- Standards web base
- HTTP, HTML, XML
- SOAP, WSDL

### 2. OASIS
- Standards e-business
- UDDI, BPEL
- WS-Security, WS-Transactions