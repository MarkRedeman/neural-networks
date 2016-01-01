%% hebbian_learning_step:
function [weights, bias] = hebbian_learning_step(weights, bias, sample, label, N)
    weights = weights + label * sample / N;
    % bias = bias + label / N;
end