
1. Lab sur la Régression Linéaire:
- Utilise un dataset sur le "World Happiness Report" de Kaggle
- Deux types de régression sont étudiés:
  1. Régression linéaire simple (une variable explicative)
  2. Régression linéaire multiple (plusieurs variables explicatives)

Points clés du Lab:
- Étapes importantes:
  1. Visualisation (nuage de points, corrélations)
  2. Split des données (train/test)
  3. Création et application du modèle
  4. Évaluation des performances

Métriques d'évaluation utilisées:
- RMSE (Root Mean Squared Error)
- R² (coefficient de détermination)
- R² ajusté 
- Validation croisée (5-fold)

2. Cours sur la Régression Logistique:
Différences clés:
- Régression linéaire : prédit une variable continue
- Régression logistique : prédit une variable discrète (classification)

Concepts importants:
1. Odds Ratio
   - Mesure de dépendance entre variables
   - Formule: p/(1-p)
   - Valeur entre 0 et +∞

2. Fonction Sigmoïde
   - Transforme toute valeur en probabilité (0 à 1)
   - Utilisée pour la classification

3. Démarche de la régression logistique:
   1. Prédire le logit par régression linéaire
   2. Mapper les logits aux probabilités
   3. Définir un seuil de décision (souvent 0.5)
   4. Prévoir la classe

Points à retenir pour l'examen:
1. Savoir interpréter les métriques (R², RMSE)
2. Comprendre la différence entre régression simple et multiple
3. Comprendre quand utiliser régression linéaire vs logistique
4. Connaître les étapes de validation d'un modèle
5. Comprendre l'importance de la visualisation des données avant modélisation