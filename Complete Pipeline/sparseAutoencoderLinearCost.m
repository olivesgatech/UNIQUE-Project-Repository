function [cost,grad] = sparseAutoencoderLinearCost(theta, visibleSize, hiddenSize, ...
                                             lambda, sparsityParam, beta, data)



% visibleSize: the number of input units (192) 
% hiddenSize: the number of hidden units (400) 
% lambda: weight decay parameter
% sparsityParam: The desired average activation for the hidden units.
% beta: weight of sparsity penalty term
% data: 192x10000 matrix containing the training data.  

W1 = reshape(theta(1:hiddenSize*visibleSize), hiddenSize, visibleSize);
W2 = reshape(theta(hiddenSize*visibleSize+1:2*hiddenSize*visibleSize), visibleSize, hiddenSize);
b1 = theta(2*hiddenSize*visibleSize+1:2*hiddenSize*visibleSize+hiddenSize);
b2 = theta(2*hiddenSize*visibleSize+hiddenSize+1:end);

% Cost and gradient variables. 
cost = 0;
W1grad = zeros(size(W1)); 
W2grad = zeros(size(W2));
b1grad = zeros(size(b1)); 
b2grad = zeros(size(b2));

%%
% W1grad, W2grad, b1grad and b2grad are computed using backpropagation.

m = size(data, 2);

z2 = bsxfun(@plus, W1 * data, b1);
a2 = sigmoid(z2); 
rho_hat = sum(a2, 2) / m;

z3 = bsxfun(@plus, W2 * a2, b2);
a3 = z3; 

diff = a3 - data;
sparse_penalty = sparsity(sparsityParam, rho_hat);
J_simple = sum(sum(diff.^2)) / (2*m);


reg = sum(W1(:).^2) + sum(W2(:).^2);

cost = J_simple + beta * sparse_penalty + lambda * reg / 2;

% Backpropogation

delta_3 = diff;   

d2_simple = W2' * delta_3;  
d2_pen = penalty(sparsityParam, rho_hat);


delta_2 = (d2_simple + beta * repmat(d2_pen,1, m)) .* a2 .* (1 - a2);

b2grad = sum(delta_3, 2)/m;
b1grad = sum(delta_2, 2)/m;

W2grad = delta_3 * a2'/m  + lambda * W2; 
W1grad = delta_2 * data'/m + lambda * W1; 

grad = [W1grad(:) ; W2grad(:) ; b1grad(:) ; b2grad(:)];

end

%-------------------------------------------------------------------

function sigm = sigmoid(x)
    sigm = 1 ./ (1 + exp(-x));    
end

function res = sparsity(r, rh)
    res = sum(r .* log(r ./ rh) + (1-r) .* log( (1-r) ./ (1-rh)));
end

function res = penalty(r, rh)
    res = -(r./rh) + (1-r) ./ (1-rh);
end




