%% stability: finds the sample with lowest stability with respect to some weights vector
function [stability, idx] = lowest_stability(weights, samples, labels, normalized)
    if (nargin < 4)
        normalized = false;
    end
    [stability, idx] = min((weights * samples') .* labels');

    if (normalized)
        stability = stability ./ norm(weights);
    end
end