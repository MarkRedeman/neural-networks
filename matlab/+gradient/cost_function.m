%% Cost function: computes E
function [E] = cost_function(samples, labels, weights)
   import gradient.sigma;
   sample_size = length(labels);
   
   E = sum((sigma(samples, weights) - labels').^2) / (sample_size * 2);
end
