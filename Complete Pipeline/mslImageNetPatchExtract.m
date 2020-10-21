function [patches,numPatches] = mslImageNetPatchExtract(srcPath,Scale)
%%
%  Input:               1. srcPath    - Path where the function can find 
%                                       ImageNet database
%                       2. Scale      - Scale of patches to be extracted
%
%  Output:              1. patches    - Extracted patches of size [(Scale*Scale*3)x100000]
%                       2. numPatches -
%%
%Read the path and find the number of images present
srcFilesRef = dir([srcPath,'/*.JPEG']);
numberImage = length(srcFilesRef);

%%
%Initializations
D = randi([1,numberImage],[1500,1],'distributed');
count = 1;
count_out = 1;
i = 1;
patch = [];

%%
%Patch extraction
fprintf('Extracting patches...')
while count_out < 1001
    
    filename = strcat([srcPath,srcFilesRef(D(i)).name]);
    I = imread(filename);
    [m,n,~] = size(I);
    if size(I,3) < 3
        i = i+1;
        continue;
    end
    Image = rgb2ycbcr(I);
    Image(:,:,2) = I(:,:,2);
    I = im2double(Image);
    randomn_x = randi([1,m-Scale],[100,1]);
    randomn_y = randi([1,n-Scale],[100,1]);
    for j = 1:100
        patch_temp = I(randomn_x(j,1):(randomn_x(j,1)+(Scale-1)),randomn_y(j,1):(randomn_y(j,1)+(Scale-1)),:);
        patch(1:(Scale*Scale*3),count) = reshape(patch_temp,[],1);
        count = count+1;
    end
    i = i+1;
    count_out = count_out+1;
end

%%
%Randomly rearrange the patches to decrease correlation between adjoining
%patches of same image
Ind = randperm(100000,100000);
patches = patch(:,Ind');
fprintf('%d Patches each of size %dx1 extracted\n',size(patches,2),size(patches,1));
numPatches = size(patches,2);
save('ImageNet_patches.mat','patches');


end