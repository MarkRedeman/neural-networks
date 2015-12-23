%% generate_training_data:
% Input:
% N either an integer, the dimension, or a teacher, an N dimensional vector
% P : amount of training samples
function [labels, samples] = generate_training_data(N, P)
    if (length(N) == 1)
        labels = generate_labels(P);
        samples = randn(P, N);
    else
        [labels, samples] = generate_labels_from_teacher(P, N);
    end
end

%% generate_labels:
function [labels] = generate_labels(P)
    % Create P labels equal to plus / minus 1 with 0.5 probability
    labels = randi([0, 1], P, 1);
    labels(find(labels == 0)) = -1;
end

%% generate_labels_from_teacher:
function [labels, samples] = generate_labels_from_teacher(P, teacher)
    labels = zeros(P, 1);
    samples = randn(P, length(teacher));
    for label = 1:P
        labels(label) = sign(dot(samples(label, :), teacher));
    end
end