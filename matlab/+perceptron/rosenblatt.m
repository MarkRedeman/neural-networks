function [weights, bias, should_stop] = rosenblatt(samples, labels, weights, bias, threshold)
    import perceptron.hebbian_learning_step;

    % we will stop iterating once we've separated every sample
    should_stop = true;
    for idx = 1 : size(samples, 1)
        sample = samples(idx, :);
        label = labels(idx);

        % check if the current sample has been correctly separated,
        % otherwise make a correction to the weights and bias
        if ((dot(weights, sample) + bias) * label <= threshold)
            [weights, bias] = hebbian_learning_step( ...
                weights, ...
                bias, ...
                sample, ...
                label, ...
                size(samples, 2) ...
            );

            weights = weights + label * sample / size(samples, 2);
            % bias = bias + label / size(samples, 2);
            should_stop = false;
        end
    end
end