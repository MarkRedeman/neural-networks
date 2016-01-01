%% stability: finds the sample with lowest stability with respect to some weights vector
function [stability, idx] = lowest_stability(weights, samples, labels)
    [stability, idx] = min((weights * samples') .* labels');
end