%% rosenblatt_algorithm:
% input:
% label vector of +1 or -1
% samples collection of vectors
function [weights, bias, steps] = perceptron(labels, samples, max_steps, perceptron_algorithm)
    if (nargin < 3)
        max_steps = 0.5 * 1E3;
    end

    weights = zeros(1, size(samples, 2));
    bias = 0;

    iterate = @(weights, bias) perceptron_algorithm(samples, labels, weights, bias);
    for steps = 1 : max_steps
        [weights, bias, should_stop] = iterate(weights, bias);

        % all samples have been separated, so we stop
        if (should_stop)
            break;
        end
    end
end

