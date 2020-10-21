%% mslMainCompleteUNIQUEPipeline.m
%  This program extracts image patches from any available online database, learns 
%  sparse representation from them, processes images from LIVE, and MULTI 
%  databases and compares them against subjective scores.

%%
clear all
clc

%%
% %Extract patches from ImageNet database
% 
% %Path where ImageNet database is stored
% path = '../databases/ILSVRC2013_DET_test/';
% %Size of patches to be extracted
% Scale = 8;
% 
% %Call function to extract patches and store in the variable mslPatches
% [mslPatches,numPatches] = mslImageNetPatchExtract(path,Scale);

%%
%Calculate weights and bias using a linear decoder
patchesStruct = load('ImageNet_patches.mat');
mslPatches = patchesStruct.patches;
Scale = 8;
numPatches = length(mslPatches);
[W,b,~] = linearDecoderExercise(mslPatches,Scale,numPatches);

%% Parameter Initialization for score calculation in individual databases

AEStruct = load('ImageNet_Weights_YGCr.mat');
W = AEStruct.W;
b = AEStruct.b;

tic
blockSize=[10 10];
paramIndArray=[1];
metInd=[1];
poolInd=[1];
nMet = 1;

%LIVE
%Calculate scores for images in LIVE database
for ii=1:nMet
mslMainPoolingLIVE(poolInd, metInd(ii), paramIndArray, blockSize)
end

%MULTI
%Calculate scores for images in MULTI database
for ii=1:nMet
mslMainPoolingMULTI(poolInd, metInd(ii), paramIndArray, blockSize)
end

%% Compare against subjective scores
for jj=1:nMet

fileDir=['Multi_corrAfter','*metInd_',num2str(metInd(jj)),'_poolInd_',num2str(poolInd)];
files = dir([fileDir,'*.mat']);
load([files(1).name]);
multi_results(jj,:,:)=squeeze(corrMat);


fileDir=['corrAfter','*metInd_',num2str(metInd(jj)),'_poolInd_',num2str(poolInd)];
files = dir([fileDir,'*.mat']);
load([cd,filesep,files(1).name]);
live_results(jj,:,:)=squeeze(corrMat);

end

pool_table=zeros(19,nMet);
live=squeeze(live_results(:,2,:));
multi=squeeze(multi_results(:,2,:));

live_ind=[1,2,5,8,10,17];
live_ind_int=[1,2,3,5,4,6];
multi_ind=[4,6,12,13,18];
multi_ind_int=[1,2,1,2,3];

for jj=1:nMet

    for ii=1:size(live_ind,2)
        if nMet==1 
            pool_table(live_ind(ii))=live(live_ind_int(ii));
        else
            pool_table(live_ind(ii),jj)=live(jj,live_ind_int(ii));
  
        end
    end

    for ii=1:size(multi_ind,2)
        if nMet==1 
            pool_table(multi_ind(ii))=multi(multi_ind_int(ii));
        else
            pool_table(multi_ind(ii),jj)=multi(jj,multi_ind_int(ii));
  
        end
    end

end

pool_table=abs(pool_table);

temp=load('ssim.mat');
temp=temp.pool_table;

ii=1; 
dist_class{ii}=['Jp2k [LIVE]:',num2str(pool_table(ii)),' SSIM: ',num2str(temp(ii)) ];
ii=2;
dist_class{ii}=['Jpeg [LIVE]:',num2str(pool_table(ii)),' SSIM: ',num2str(temp(ii))   ];
ii=4;
dist_class{ii}=['Blur-Jpeg [MULTI]:',num2str(pool_table(ii)),' SSIM: ',num2str(temp(ii))  ];
ii=5;
dist_class{ii}=['Wn [LIVE]:',num2str(pool_table(ii)),' SSIM: ',num2str(temp(ii))  ];
ii=6;
dist_class{ii}=['Blur-Noise [MULTI]:',num2str(pool_table(ii)),' SSIM: ',num2str(temp(ii))  ];
ii=8;
dist_class{ii}=['FF [LIVE]:',num2str(pool_table(ii)),' SSIM: ',num2str(temp(ii))  ];
ii=10;
dist_class{ii}=['Gblur [LIVE]:',num2str(pool_table(ii)),' SSIM: ',num2str(temp(ii))  ];
ii=12;
dist_class{ii}=['Blur-Jpeg [MULTI]:',num2str(pool_table(ii)),' SSIM: ',num2str(temp(ii))  ];
ii=13;
dist_class{ii}=['Blur-Noise [MULTI]:',num2str(pool_table(ii)),' SSIM: ',num2str(temp(ii))  ];
ii=17;
dist_class{ii}=['All [LIVE]:',num2str(pool_table(ii)),' SSIM: ',num2str(temp(ii))  ];
ii=18;
dist_class{ii}=['All [MULTI]:',num2str(pool_table(ii)),' SSIM: ',num2str(temp(ii))  ];

toc

for ii=1:18
   disp(dist_class{ii}) 
end
