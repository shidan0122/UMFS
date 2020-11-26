# UMFS
**Unsupervised Feature Selection with Binary Hashing**

**Data**
1. single-view datasets：single-label and multi-label datasets
2. multi-view datasets

**UMFS**
Unsupervised Multi-label Feature Selection

**MUMFS**
Multo-view extension: Multi-view Unsupervised Multi-label Feature Selection

**Evaluation**
1. Clustering task: perform k-means
2. Classification task: perform SVM (download libSVM package) and ML-KNN (use MLKNN package)

**Evaluation Metrics**
clustering: accuracy(ACC) and Normalized Mutual Information(NMI)（run 'ClusteringMeasure.m'）
classification: accuracy; multi-label classifiction: One-Error and Average Precision.
