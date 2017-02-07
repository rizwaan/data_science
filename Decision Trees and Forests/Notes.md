> This is a stub. Need to be completed
> Currently capturing major concepts
---
### **Decision Trees**

- Building blocks for Decision Forests
- Not used on their own due to low accuracy

##### Splitting
- Which variable to use for splitting next?
- Select the one which provides
  - Max Information Gain (C4.5,C5, ID3)
  - Least Gini Index (CART) : (Impurity measure))
- Another metric is Cross Entropy
  

##### Pruning
- To avoid over fitting
- Grow a tree fully and prune it back
- 2 Methods
  - Reduced Error Pruning :
    - Start at the leaves
    - Replace each node with its most popular class
    - If prediction accuracy is not affected, change is kept
    - Simple and fast
  - Cost Complexity Pruning
    - Best tradeoff between fit and complexity
    - Generate lots of subtree for a given tree
    - Using a hyperparameter  for Complexity find the subtree which minimizes
      - Cost(Misclassification error)+alpha*No of terminal nodes.
    - Use bootstrapping to find alpha
    - Tree with the minimum cost complexity measure is retained over original tree



---

### **Decision Forests** or Ensemble Methods

##### Bagging
- Use many weak DTs to build a final classifier
- Decision based on voting (Classification Trees) or averaging (Regression Trees)
- Individual DTs built using bootstrapping the observations from original training set


##### Random Forests
- Same as Bagging
- Key difference : observations and variables both are bootstrapped
- Very accurate
- Slow since the due to number of trees and diverse nature of trees

##### Boosting
-Final Weighted sum of classifiers
- Main algo: Adaboost
- Weights for individual classifiers are calculates using their errors on bootstrapped samples
