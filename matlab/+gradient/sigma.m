%% sigma
%sigma is compatible with multiple weights (adaptive input-to-hidden weights)
% sample: P x N, where P is the sample size 
% weights: A x N, where A is the number of adaptive weights
% output: sigma : 1 x 10, sigma value for each sample 
function [sigma] = sigma(sample, weights)
    % sum over the collumns
    sigma = sum(tanh(weights * sample'), 1);
end
