

---

# Rapport TP

## 1. Ajout de l'extension JaCoCo

J'ai commencé par ajouter l'extension JaCoCo :  
![[Pasted image 20241222230640.png]]

---

## 2. Tests des méthodes autres que `jourSuivant`

Après avoir ajouté les tests pour les autres méthodes :  
![[Pasted image 20241222231124.png]]

### Build et génération du rapport

Une fois le projet compilé, le rapport est généré dans le dossier `target/site` :  
![[Pasted image 20241222231702.png]]

### Résultats obtenus

Les résultats sont les suivants :  
![[Pasted image 20241222231859.png]]  
![[Pasted image 20241222231922.png]]  
![[Pasted image 20241222231958.png]]

---

## 3. Ajout de tests pour la méthode `jourSuivant`

### Tests des branches

Après avoir ajouté des tests couvrant toutes les branches :  
![[Pasted image 20241222232115.png]]  
![[Pasted image 20241222232139.png]]

### Analyse de couverture

La couverture ne peut pas atteindre 100 % pour la méthode `jourSuivant`. En effet, comme illustré dans l'image précédente, il suffit de vérifier que `jour < 31`. Le cas contraire (`else`) est garanti d’être vrai, car nous avons déjà vérifié au début de la méthode que `jour <= 31` :  
![[Pasted image 20241222232248.png]]

---

## 4. Modifications du code

- Ajout de la condition `jour < 30`.
- Prise en compte du mois de juillet dans les mois à 31 jours.
- Ajout d'un test de branche pour le mois de juillet dans la méthode `estMoisDe30Jours`.

Les résultats après modification :  
![[Pasted image 20241222232451.png]]  
![[Pasted image 20241222232504.png]]  
![[Pasted image 20241222232523.png]]

---

Fin du rapport.