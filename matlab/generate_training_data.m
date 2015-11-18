%% generate_training_data:
function [labels, samples] = generate_training_data(N, P)
    labels = generate_labels(P);
    samples = randn(P, N);
end

%% generate_labels:
function [labels] = generate_labels(P)
    % Create P labels equal to plus / minus 1 with 0.5 probability
    labels = randi([0, 1], P, 1);
    labels(find(labels == 0)) = -1;
end
