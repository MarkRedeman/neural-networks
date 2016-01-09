%% assignement_3
function [W, stats] = assignement_3(samples, labels)
import gradient.gradient_descent;
% Input dimension
N = 50;

% Training size
P = 500;
Q = 4500;

P = 100;
Q = 500;

% Input size
M = length(labels);

% Iterate tmax times over the training set
t_max = 5000;

% Learning rate
eta = 0.001;
% eta = 0.05;

% Permute input
permutation = randperm(M);
% permutation = 1 : M;
permutedData = samples(permutation, :);
permutedLabels = labels(permutation);

hidden_nodes = 2;
weights = normr(rand(hidden_nodes, N));
weights(1, :) = - weights(2, :);
% Start learning
training_size = P;
testing_size = Q;
training = 1 : training_size;
testing = training_size + 1 : min(length(labels), training_size + 1 + testing_size);

training_set = struct('samples', samples(training, :), 'labels', labels(training));
testing_set = struct('samples', samples(testing, :), 'labels', labels(testing));

[W, stats] = gradient_descent(weights, training_set, testing_set, eta, t_max);
% gradient_descent(weights, training_set, testing_set, eta, t_max);

end