%% probabilty_of_linear_separation:
function [probability] = probabilty_of_linear_separation(dimension, sample_size)
    if (sample_size <= dimension)
        probability = 1;
    else
        probability = 0;
        n = sample_size - 1;

        for idx = 1 : (dimension - 1)
            % factorial(k) / (factorial(m) * factorial(k - m))
            probability = probability + nchoosek(sample_size - 1, idx);
        end

        probability = 2^(1 - sample_size) * probability;
    end
end