function feature = mslProcessUNIQUE(img,W,b)
%%
%  Author:              Mohit Prabhushankar
%  PI:                  Ghassan AlRegib
%  Version:             1.0
%  Published in:        
%  Publication details: 
%%
I = im2double(img);

%Parameter Initialisation
[m,n,~] = size(I);
epsilon = 0.1; 
count = 1; 
scale = 8;

%Convert m x n x 3 image into [(8x8x3) x count] patches
i = 1;
while (i < m - (scale - 2))
    j = 1;
    while (j< n-(scale-2)) %(j < 512)
        patch_temp = I(i:i+(scale-1),j:j+(scale-1),:);
        patches(:,count) = reshape(patch_temp,[],1);
        count = count+1;
        j = j+scale;
    end    
    i = i+scale;
end

% Subtract mean patch (hence zeroing the mean of the patches)
meanPatch = mean(patches,2);  
patches = bsxfun(@minus, patches, meanPatch);

% Apply ZCA whitening
sigma = patches * patches' / (count-1);
[u, s, ~] = svd(sigma);
ZCAWhite = u * diag(1 ./ sqrt(diag(s) + epsilon)) * u';
patches = ZCAWhite * patches;

%Multiply the patches with the pretrained weights and add the
%bias
feature_full = W * patches + repmat(b,1,size(patches,2));

%Pass it through the sigmoid layer to obtain the final feature vector
feature_full = 1./(1 + exp(-(feature_full)));

%Reshaping back to a single vector
feature = reshape(feature_full,[],1);

end