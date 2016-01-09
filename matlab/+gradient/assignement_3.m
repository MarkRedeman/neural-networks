%% assignement_3
function [W, stats] = assignement_3(samples, labels)
import gradient.gradient_descent;
% Input dimension
N = 50;

% Training size
P = 500;
Q = 4500;

% P = 500;
% Q = 100;

% Iterate tmax times over the training set
t_max = 5000;

% Learning rate
eta = 0.001;
% eta = 0.05;

%% Input size
M = length(labels);

% Permute input
permutation = randperm(M);
samples = samples(permutation, :);
labels = labels(permutation);

hidden_nodes = 2;
weights = initial_weights(hidden_nodes, N);
 
% Start learning
training_size = P;
testing_size = Q;
training = 1 : training_size;
testing = training_size + 1 : min(length(labels), training_size + 1 + testing_size);

training_set = struct('samples', samples(training, :), 'labels', labels(training));
testing_set = struct('samples', samples(testing, :), 'labels', labels(testing));

plot_costs = true;
[W, stats] = gradient_descent(weights, training_set, testing_set, eta, t_max, ...
                              plot_costs);

end

function [weights] = initial_weights(hidden_nodes, dimension)
    weights = normr(rand(hidden_nodes, dimension));
    
    % This might be an intersting initial condition
    % weights(1, :) = - weights(2, :);
end
