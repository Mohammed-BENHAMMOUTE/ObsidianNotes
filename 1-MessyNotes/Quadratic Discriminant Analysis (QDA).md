
## Core Concept
- QDA is a classification method that assigns new observations to the most probable group/class
- It's an extension of LDA that allows for more flexible decision boundaries
- The key idea is that each class can have its own unique spread/variance of data

## How QDA Works
1. **Assumption about Data**
   - Assumes each class's data follows a Gaussian/Normal distribution
   - Each class can have its own unique shape and spread.
   - This means each class has its own covariance matrix.

2. **Decision Process**
   - Calculates probability of a new data point belonging to each class
   - Assigns the point to the class with highest probability
   - Creates curved (quadratic) boundaries between classes

## Key Differences from LDA

### 1. Flexibility
- **LDA**: Assumes all classes share same spread/variance
- **QDA**: Allows each class to have different spread/variance
- Result: QDA can capture more complex class boundaries

### 2. Decision Boundaries
- **LDA**: Creates straight-line boundaries
- **QDA**: Creates curved boundaries
- This makes QDA more flexible but also more complex

### 3. Data Requirements
- **LDA**: Needs less training data
- **QDA**: Needs more training data
- Why? QDA has more parameters to estimate

## When to Use QDA

### Good Use Cases
1. When you have plenty of training data
2. When classes clearly have different spreads/shapes
3. When you need flexible boundaries
4. When computational resources aren't limited

### Not Recommended When
1. Limited training data available
2. Classes have similar spreads
3. Need simple, interpretable model
4. Computational resources are limited

## Practical Considerations

### Advantages
1. More flexible than LDA
2. Better captures complex class relationships
3. More realistic in many real-world scenarios
4. Can outperform LDA when assumptions are met

### Disadvantages
1. Requires more training data
2. More complex to implement
3. Higher risk of overfitting
4. More computationally intensive

## Implementation Tips
1. Always check if you have enough data for QDA
2. Visualize your data first if possible
3. Consider starting with LDA and only move to QDA if needed
4. Watch out for overfitting signs

## Key Questions to Ask Before Using QDA
1. Do my classes look like they have different spreads?
2. Do I have enough training data?
3. Is the added complexity worth the potential gain in accuracy?
4. Are computational resources a concern?

## Real-World Applications
1. Face recognition systems
2. Medical diagnosis
3. Financial risk assessment
4. Pattern recognition
5. Signal processing