%% Minover
function [weights, bias, should_stop] = minover(samples, labels, weights, bias, threshold)
    import perceptron.hebbian_learning_step;
    import perceptron.lowest_stability;
    should_stop = false;

    % do a hebbian learning step using the sample with lowest stability
    [stability, idx] = lowest_stability(weights, samples, labels);
    [new_weights, bias] = hebbian_learning_step( ...
        weights, ...
        bias, ...
        samples(idx), ...
        labels(idx), ...
        size(samples, 2) ...
    );

    previous_stability = stability + 1;

    if abs(1 - new_weights'* weights / norm(weights) / norm(new_weights)) < 1E-5 
        should_stop = true;
    end
    weights = new_weights;

    % if (norm(stability - previous_stability) < threshold)
    %     should_stop = true;
    % end
end
