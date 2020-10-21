# UNIQUE-Project-Repository

For the purposes of Georgia Tech ECE 6258 only.

This repository contains the training, testing, and demo codes for the paper - UNIQUE : Unsupervised Image Quality Estimation.

There are two folders : Demo and Complete Pipeline. 

1. Demo code provides the necessary model and code to assess the quality of given reference and distorted images. Example reference and distorted images from TID 2013 database is provided.

2. Complete pipeline provides code for training, testing, and validation.
  
Further details are provided within each folder. If there are any questions, please contact mohit.p@gatech.edu and alregib@gatech.edu.

### UNIQUE : UNSUPERVISED IMAGE QUALITY ESTIMATION

The learnt filter weights :

<p align="center">
  <img src=/Demo/Images/Visualization.png/>
</p>  

Applying these weights to original (top) and distorted images (bottom), the obtained feature maps  

<p align="center">
  <img src=/Demo/Images/FeatMap.png/>
</p>  

The results of the algorithm on LIVE, MULTI-LIVE, and TID13 databases :  

![Results Filters](/Demo/Images/Results.png)

### Citation

IEEE link : https://ieeexplore.ieee.org/document/7546870  
ArXiv Link : https://arxiv.org/abs/1810.06631  

