%% assignement_3
function [W, trainingError, setError] = assignement_3(samples, labels)
import gradient.gradient_descent;
% Input dimension
N = 50;

% Training size
P = 500;
Q = 4500;

P = 500;
Q = 500;

% Input size
M = length(labels);

% Iterate tmax times over the training set
t_max = 500000;

% Learning rate
eta = 0.01;
% eta = 0.05;

% Permute input
permutation = randperm(M);
% permutation = 1 : M;
permutedData = samples(permutation, :);
permutedLabels = labels(permutation);

hidden_nodes = 1;
weights = normc(rand(hidden_nodes, N)); 
% Start learning
[W, trainingError, setError] = gradient_descent(weights, permutedData, permutedLabels, ...
                                                P, Q, eta, t_max);

figure;
plot(trainingError)
hold on
plot(setError,'r')
hold off
set(gca, 'yscale', 'log')
legend('training cost', 'test cost');
title(sprintf('eta: %f, P: %d, Q: %d, t: %d', eta, P, Q, t_max));

figure
bar3(W);
end