%% rosenblatt_algorithm:
% input:
% label vector of +1 or -1
% samples collection of vectors
function [weights, bias, steps] = rosenblatt_algorithm(labels, samples, max_steps, threshold)
    import perceptron.*;

    if (nargin < 3)
        max_steps = 0.5 * 1E3;
    end

    if (nargin < 4)
        threshold = 0;
    end

    % First we setup the rosenblatt perceptron algorithm that we want to use
    perceptron_algorithm = @(samples, labels, weights, bias) rosenblatt(samples, labels, weights, bias, threshold);

    % Next use the general perceptron algorithm
    [weights, bias, steps] = perceptron(labels, samples, max_steps, perceptron_algorithm);
end
