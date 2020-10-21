function [W,b,optTheta] = linearDecoderExercise(patches,patchDim,numPatches)

% All functions including linearDecoderExercise, sparseAutoencoderLinearCost 
% and those in folders '../common' and '../common/fminlbfgs' and are part of the Stanford 
% UFLDL Tutorial on Deep Learning.
% Some parameters were changed according to the application. Tutorial
% completed and used by Mohit Prabhushankar

%%
%  Input:               1. patches    - Input patches used for training
%                       2. patchDim   - Size of patches extracted in mslImageNetPatchExtract
%                       3. numPatches - Number of patches extracted in mslImageNetPatchExtract
%
%  Output:              1. W          - Weights for domain transformation
%                       2. b          - bias for domain transformation
%                       3. optTheta   - All weights and bias (Both for domain transformation 
%                                       and image reconstruction 

%%
addpath LinearDecoderFunctions/
addpath LinearDecoderFunctions/fminlbfgs/

%% STEP 0: Initialization
%  Here we initialize some parameters used for the exercise.

imageChannels = 3;           % Y,G, and Cr
visibleSize = patchDim * patchDim * imageChannels;  % number of input units 
outputSize  = visibleSize;   % number of output units
hiddenSize  = 400;           % number of hidden units 

sparsityParam = 0.035; % desired average activation of the hidden units.
lambda = 3e-3;         % weight decay parameter       
beta = 5;              % weight of sparsity penalty term       

epsilon = 0.1;	       % epsilon for ZCA whitening

displayColorNetwork(patches(:, 1:100));

%% STEP 2b: Apply preprocessing
%  In this sub-step, we preprocess the sampled patches, in particular, 
%  ZCA whitening them. 

% Subtract mean patch 
meanPatch = mean(patches,2);  
patches = bsxfun(@minus, patches, meanPatch);

% Apply ZCA whitening
sigma = patches * patches' / numPatches;
[u, s, ~] = svd(sigma);
ZCAWhite = u * diag(1 ./ sqrt(diag(s) + epsilon)) * u';
patches = ZCAWhite * patches;

displayColorNetwork(patches(:, 1:100));

%% STEP 2c: Learn features

theta = initializeParameters(hiddenSize, visibleSize);

% Use minFunc to minimize the function

options = struct;
options.HessUpdate = 'lbfgs'; 
options.MaxIter = 200;
options.Display = 'iter';
options.GradObj = 'on';

[optTheta, cost] = fminlbfgs( @(p) sparseAutoencoderLinearCost(p, ...
                                   visibleSize, hiddenSize, ...
                                   lambda, sparsityParam, ...
                                   beta, patches), ...
                              theta, options);


fprintf('Saving learned features and preprocessing matrices...\n');                          

%% STEP 2d: Visualize learned features

W = reshape(optTheta(1:visibleSize * hiddenSize), hiddenSize, visibleSize);
b = optTheta(2*hiddenSize*visibleSize+1:2*hiddenSize*visibleSize+hiddenSize);
displayColorNetwork( (W*ZCAWhite)');

save('ImageNet_Weights_YGCr.mat','W','b','optTheta');

end