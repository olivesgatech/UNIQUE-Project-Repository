# UNIQUE-Project-Repository
This repository contains the training, testing, and demo codes for the paper - UNIQUE : Unsupervised Image Quality Estimation.

There are two folders : Demo and Complete Pipeline. 

1. Demo code provides the necessary model and code to assess the quality of given reference and distorted images. Example reference and distorted images from TID 2013 databases are provided.

2. Complete pipeline provides code for :

  a) Extracting patches from ImageNet dataset
  
  b) Training a linear decoder model on the ImageNet patches
  
  c) Applying learned model on LIVE and MULTI-LIVE datasets
  
  d) Comparing estimated scores against subjective scores and providing distortion-wise and overall Spearman correlation between the two.
  
Further details are provided within each folder.
