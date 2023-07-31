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

@article{DBLP:journals/tip/ShiZLZC23,
  author       = {Dan Shi and
                  Lei Zhu and
                  Jingjing Li and
                  Zheng Zhang and
                  Xiaojun Chang},
  title        = {Unsupervised Adaptive Feature Selection With Binary Hashing},
  journal      = {{IEEE} Trans. Image Process.},
  volume       = {32},
  pages        = {838--853},
  year         = {2023},
  url          = {https://doi.org/10.1109/TIP.2023.3234497},
  doi          = {10.1109/TIP.2023.3234497},
  timestamp    = {Tue, 31 Jan 2023 20:44:07 +0100},
  biburl       = {https://dblp.org/rec/journals/tip/ShiZLZC23.bib},
  bibsource    = {dblp computer science bibliography, https://dblp.org}
}
