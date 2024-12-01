[[ML]]
___
# Decision Trees

## Core Concepts
1. Definition:
   - Supervised machine learning algorithm
   - Used for both regression and classification (mostly classification)
   - Based on if-else conditions

2. Key Components:
   - Root Node: Initial splitting point, chosen using Attribute Selection Techniques
   - Leaf/Terminal Node: End point where no further splitting occurs
   - Decision Node: Nodes after splitting into sub-nodes
   - Branch/Sub-Tree: Part of the decision tree
   - Pruning: Process of removing sub-nodes
   - Splitting: Dividing nodes based on conditions

3. Attribute Selection Measure (ASM):
   Two main techniques:
   - Gini Index: 
     * Measures probability of classification
     * Feature with lowest Gini index is selected
   - Information Gain (ID3):
     * Based on entropy
     * Selects features providing maximum class information

4. Implementation Process:
   - Data loading and cleaning
   - Data exploration
   - Train-test split
   - Model building and training
   - Pruning
   - Tree visualization (optional)
   - Model evaluation

5. Pruning Process:
   Two approaches:
   - Early stopping: Stop tree growth at optimal point using validation set
   - Post-pruning: Build complete tree, then remove unnecessary branches
   - Goal: Prevent overfitting and improve generalization

6. Advantages/Disadvantages:
   Advantages:
   - Easy visualization
   - Captures non-linear patterns
   Disadvantages:
   - Prone to overfitting
   - Sensitive to small data variations
   - Requires balanced dataset

# Random Forests

## Core Concepts
1. Definition:
   - Ensemble of multiple decision trees
   - Final prediction based on majority voting
   - Based on "wisdom of crowds" principle

2. Construction Process:
   - Uses bootstrap dataset (random sampling with replacement)
   - Considers random subset of variables at each step
   - Trees grown to maximum extent without pruning
   - No correlation between individual trees

3. Out-of-bag (OOB) Error Estimation:
   - Uses approximately 1/3 of cases left out during training
   - Provides unbiased error estimate
   - Eliminates need for separate cross-validation
   - Used for variable importance estimation

4. Proximities:
   - Creates NxN matrix
   - Measures similarity between cases
   - Increased when cases share terminal nodes
   - Normalized by number of trees
   - Useful for handling missing values

5. Key Requirements:
   - Features must contain actual signal (better than random guessing)
   - Low correlation between individual tree predictions
   - Balanced dataset

6. Performance Notes:
   - Fast processing (example: 100 trees for 50,000 cases/100 variables in 11 minutes)
   - Memory requirements mainly for data storage
   - Additional storage needed for proximities

Remember: Random Forests generally outperform individual decision trees and are less prone to overfitting.
