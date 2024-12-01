[[ML]]

---
## Linear Discriminant Analysis (LDA) and Discriminant Factor Analysis (AFD)

### Overview
- **LDA (Linear Discriminant Analysis)** and **AFD (Analyse Factorielle Discriminante)** are both methods used for classification by finding a transformation that separates classes.
- The main difference lies in their approach:
  - **AFD** directly transforms original data \( X \) into new coordinates \( Z \).
  - **LDA** doesn’t transform data but instead calculates projection scores of the data onto the new space.

### Goal of LDA
1. Find a **linear combination of variables** that best separates the target classes.
2. Create a **discriminant rule** that divides the space into \( K \) distinct regions representing each class.

### Key Problem
- **LDA** tries to find a plane that separates classes but **doesn’t consider the spread within each class** (intra-class variance).

### Fisher's LDA
- Fisher's version of LDA addresses this by considering:
  - **Inter-class variance**: separation between classes.
  - **Intra-class variance**: spread within each class.
- Fisher’s LDA maximizes the **ratio of inter-class variance to intra-class variance** for better class separability and robustness.

### Discriminant Score and Threshold
- The first discriminant variable in LDA can be used to construct a **simple decision rule** by setting a threshold \( c \).
- **For \( K = 2 \) classes in two dimensions**, the threshold \( c \) is the midpoint of the projected means of the two classes.

### Quadratic Discriminant Analysis (QDA)
- **QDA** classifies elements using **Bayes' formula** for decision-making.



En pratique, si votre objectif est de **classer des données** dans des groupes, vous utiliserez de préférence l’ALD. Si, au contraire, vous voulez **visualiser** les groupes ou **comprendre leur structure**, l’AFD sera plus appropriée.

---
