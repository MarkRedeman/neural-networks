%% rosenblatt_algorithm:
% input:
% label vector of +1 or -1
% samples collection of vectors
function [weights, bias, steps] = rosenblatt_algorithm(labels, samples, max_steps)
    if (nargin < 3)
        max_steps = 0.5 * 1E3; % TODO: change this to the analytical expression
    end

    dimension = size(samples, 2);
    weights = zeros(1, dimension);
    bias = 0;

    sample_size = size(samples, 1);

    for steps = 1 : max_steps
        % we will stop iterating once we've separated every sample
        found_error = false;
        for idx = 1 : sample_size
            sample = samples(idx, :);
            desired_label = labels(idx);

            % check if the current sample has been correctly separated,
            % otherwise make a correction to the weights and bias
            if (sign(desired_label) ~= sign(dot(weights, sample) + bias))
                weights = weights + desired_label * sample / dimension;
                bias = bias + desired_label / dimension;
                found_error = true;
            end
        end

        % all samples have been separated, so we stop
        if (~ found_error)
            break;
        end
    end
end
