%% assignement_3
function [W] = assignement_3(samples, labels)
import gradient.gradient_descent;
% Input dimension
N = 50;

% Training size
P = 500;
Q = 500;

% Input size
M = length(labels);

% Iterate tmax times over the training set
tmax = 50;

% Learning rate
eta = 0.01;

% Permute input
permutation = randperm(M);
% permutation = 1 : M;
permutedData = samples(permutation, :);
permutedLabels = labels(permutation);

% Start learning
[W, trainingError, setError] = gradient_descent(permutedData, permutedLabels, ...
                                                P, Q, eta, tmax);

figure;
plot(trainingError)
hold on
plot(setError,'r')
hold off
legend('training cost', 'test cost');

figure
subplot(2, 1, 1)
bar(W(1, :));
subplot(2, 1, 2);
bar(W(2, :));

end