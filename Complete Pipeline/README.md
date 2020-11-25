# UNIQUE-Unsupervised-Image-Quality-Estimation

This repo consists of the entire pipeline including : 

1) Extracting patches from ImageNet dataset
  
2) Training a linear decoder model on the ImageNet patches
  
3) Applying learned model on LIVE and MULTI-LIVE datasets
  
4) Comparing estimated scores against subjective scores and providing distortion-wise and overall Spearman correlation between the two.

The code assumes presence of ImageNet, LIVE, and MULTI-LIVE datasets.
Please refer to mslMainCompleteUNIQUEPipeline.m.

### Usage

Some notes :

1) To train the network, the model assumes the existence of random 1500 images from IMAGENET dataset. Other natural image datasets can also be used in place of images (including smaller datasets like STL). If using any other dataset, please retrain UNIQUE and report results on LIVE and MULTI-LIVE before reporting your improvements. Adjust the path accordingly in line 14 of mslMainCompleteUNIQUEPipeline.m.

2) Once trained, the code reads the reference and distorted images from LIVE dataset in mslMainPoolingLIVE.m. Please download the LIVE dataset from https://live.ece.utexas.edu/research/quality/subjective.htm (release 2) and adjust your path accordingly in lines 25 and 31-36 within mslMainPoolingLIVE.m. 

3) The reference and distorted images are read and provided to mslPoolingMetric.m from where mslUNIQUE.m is called. Your own code/functions can be written here. outCT is the quality of the distorted image given the reference image. outCT of all the images in the LIVE dataset is calculated and collated within mslMainPoolingLIVE.m.

4) Similar setup is followed on the MULTI-LIVE dataset. Please download MULTI-LIVE from https://live.ece.utexas.edu/research/Quality/live_multidistortedimage.html

5) Spearman correlation between the estimated and subjective quality is calculated and displayed. Note that the last two display lines provide the overall correlation scores across all images and distortions in each dataset. 

6) SSIM results are also provided as comparison.

7) For quick implementation, trained model is provided as ImageNet_Weights_YGCr.mat

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

