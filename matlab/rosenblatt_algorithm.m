%% rosenblatt_algorithm:
% input:
% label vector of +1 or -1
% samples collection of vectors
function [weights, bias, steps, convergence] = rosenblatt_algorithm(labels, samples, max_steps, threshold)
    if (nargin < 3)
        max_steps = 0.5 * 1E3;
    end
    if (nargin < 4)
        threshold = 0;
    end

    dimension = size(samples, 2);
    weights = zeros(1, dimension);
    bias = 0;

    sample_size = size(samples, 1);

    convergence = zeros(max_steps, 1);
    older_weights = zeros(1, dimension);
    old_weights = zeros(1, dimension);

    iterate = @(weights, bias) algorithm(samples, labels, weights, bias, threshold);
    for steps = 1 : max_steps
        [weights, bias, should_stop] = iterate(weights, bias);

        % all samples have been separated, so we stop
        if (should_stop)
            break;
        end

        if (steps > 2)
            convergence(steps) = (norm(weights - old_weights));%/ (norm(old_weights - older_weights));
        end

        older_weights = old_weights;
        old_weights = weights;
    end
end


function [weights, bias, should_stop] = algorithm(samples, labels, weights, bias, threshold)
    % we will stop iterating once we've separated every sample
    should_stop = true;
    for idx = 1 : size(samples, 1)
        sample = samples(idx, :);
        label = labels(idx);

        % check if the current sample has been correctly separated,
        % otherwise make a correction to the weights and bias
        if ((dot(weights, sample) + bias) * label <= threshold)
            weights = weights + label * sample / size(samples, 2);
            % bias = bias + label / size(samples, 2);
            should_stop = false;
        end
    end
end