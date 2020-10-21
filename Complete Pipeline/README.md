# UNIQUE-Unsupervised-Image-Quality-Estimation

This repo consists of the entire pipeline including : 



Please refer to mslMainCompleteUNIQUE.m.

### Usage

Some notes :
1) To train the network, the model assumes the existence of random 1500 images from IMAGENET dataset. Other natural image datasets can also be used in place of images (including smaller datasets like STL). If using any other dataset, please retrain UNIQUE and report results on LIVE and MULTI-LIVE before reporting your improvements.

### UNIQUE : UNSUPERVISED IMAGE QUALITY ESTIMATION

The learnt filter weights :

<p align="center">
  <img src=/Images/Visualization.png/>
</p>  

Applying these weights to original (top) and distorted images (bottom), the obtained feature maps  

<p align="center">
  <img src=/Images/FeatMap.png/>
</p>  

The results of the algorithm on LIVE, MULTI-LIVE, and TID13 databases :  

![Results Filters](/Images/Results.png)

### Citation

IEEE link : https://ieeexplore.ieee.org/document/7546870  
ArXiv Link : https://arxiv.org/abs/1810.06631  

