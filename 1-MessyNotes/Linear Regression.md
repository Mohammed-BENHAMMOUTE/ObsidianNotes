#  Multiple Linear Regression

## 1️⃣ Core Concept
- **Definition**: A statistical method analyzing relationship between:
  - One dependent variable ($Y$)
  - Multiple independent variables ($X_1, X_2, ..., X_p$)
- **Purpose**: 
  - Prediction
  - Understanding variable relationships
  - Feature importance analysis

## 2️⃣ Mathematical Framework
### Model Equation
$$Y = \beta_0 + \beta_1X_1 + \beta_2X_2 + ... + \beta_pX_p + \varepsilon$$

Where:
- $\beta_0$: Intercept
- $\beta_i$: Coefficients
- $\varepsilon$: Error term (residuals)

### Matrix Notation
$$Y = X\beta + \varepsilon$$
$$\hat{y} = X\hat{\beta}$$ 
(Predicted values)

## 3️⃣ Key Assumptions (BLUE)
1. **Linearity**: $E(Y|X)$ is linear in $X$
2. **Independence**: Observations are independent
3. **Homoscedasticity**: $Var(\varepsilon_i) = \sigma^2$ (constant)
4. **Normality**: $\varepsilon \sim N(0,\sigma^2)$
5. **No Multicollinearity**: Independent variables aren't highly correlated
6. **No Autocorrelation**: $Cov(\varepsilon_i,\varepsilon_j) = 0$ for $i \neq j$

## 4️⃣ Estimation
### Least Squares Method
- Minimizes sum of squared residuals (SSE)
- $\hat{\beta} = (X'X)^{-1}X'Y$

### Important Metrics
$$SST = \sum_{i=1}^n (y_i - \bar{y})^2$$ 
(Total variation)

$$SSR = \sum_{i=1}^n (\hat{y}_i - \bar{y})^2$$ 
(Explained variation)

$$SSE = \sum_{i=1}^n (y_i - \hat{y}_i)^2$$ 
(Unexplained variation)

## 5️⃣ Model Evaluation
### R-squared ($R^2$)
$$R^2 = \frac{SSR}{SST} = 1 - \frac{SSE}{SST}$$
- Range: [0,1]
- Interpretation:
  - $R^2 = 0.7$ means 70% of variance explained
  - Higher is better

### Adjusted $R^2$
$$\hat{R}^2 = R^2 - \frac{k-1}{n-1}(1-R^2)$$
- Penalizes for adding variables if they don't improve our model.
- k is the number of parameters. 
- n is the number of observation.
- Better for model comparison

### F-statistic
$$F = \frac{SSR/p}{SSE/(n-p-1)}$$
- Tests overall model significance
- $H_0$: All $\beta$ coefficients = 0
- High F-value → reject $H_0$

## 6️⃣ Important Statistical Tests
### T-test for Coefficients
$$t = \frac{\hat{\beta}_j}{SE(\hat{\beta}_j)}$$
- Tests individual coefficient significance
- $H_0$: $\beta_j = 0$

### Confidence Intervals
$$\hat{\beta}_j \pm t_{(\alpha/2,n-p-1)}SE(\hat{\beta}_j)$$

## 7️⃣ Diagnostic Measures
### Variance Inflation Factor (VIF)
$$VIF_j = \frac{1}{1-R^2_j}$$
- $VIF > 10$ indicates multicollinearity

### Residual Standard Error (RSE)
$$RSE = \sqrt{\frac{SSE}{n-p-1}}$$

### Cook's Distance
$$D_i = \frac{(\hat{y}_j - \hat{y}_{j(i)})^2}{p \times MSE} \times \frac{h_{ii}}{(1-h_{ii})^2}$$
- Identifies influential observations

## 8️⃣ Model Selection Criteria
### AIC (Akaike Information Criterion)
$$AIC = n\ln(SSE/n) + 2p$$

### BIC (Bayesian Information Criterion)
$$BIC = n\ln(SSE/n) + p\ln(n)$$

## 9️⃣ Prediction Intervals
### For Mean Response
$$\hat{y}_h \pm t_{(\alpha/2,n-p-1)}\sqrt{MSE \cdot x_h'(X'X)^{-1}x_h}$$

### For Individual Response
$$\hat{y}_h \pm t_{(\alpha/2,n-p-1)}\sqrt{MSE(1 + x_h'(X'X)^{-1}x_h)}$$

## 🔟 Implementation Notes
```python
# Example code structure
import statsmodels.api as sm

# Fit model
X = sm.add_constant(X)
model = sm.OLS(y, X).fit()

# Get statistics
print(model.summary())
```

## 📝 Key Points for Exam
1. Know how to interpret:
   - Coefficients ($\beta_j$)
   - $R^2$ and adjusted $R^2$
   - F-statistic
   - t-statistics
   - p-values
2. Understand assumption tests
3. Know diagnostic plots interpretation
4. Remember variable selection methods

#study_notes #statistics #exam_prep #regression_analysis

Would you like me to clarify any of these mathematical formulas or add more practical examples?