%% gradient_descent: iteration function used to update the weights of a
%% neural network
function [weights, cost_of_training, cost_of_test] = gradient_descent(samples, ...
                                                      labels, training_size, ...
                                                      learning_rate, t_max, ...
                                                      hidden_nodes)
    if (nargin < 6)
        hidden_nodes = 2;
    end
    
    dimension = size(samples, 2);
    cost_of_training = zeros(t_max, 1);
    cost_of_test = zeros(t_max, 1);

    weights = normc(rand(hidden_nodes, dimension)); 
    
    training = 1 : training_size;
    testing = training_size + 1 : length(labels);
    
    for i = 0 : (training_size * t_max - 1)
        idx = 1 + mod(i, training_size);
    % for t = 1 : t_max
        % for ii = training 
            % First we choose a label randomly with equal probability
            % idx = randi([1, training_size]);
            % idx = ii;
        
            % Next update the weights using stochastic gradient descent
            % input = tanh(weights * samples(idx, :)');
            % for k = 1 : 2
            %     weights(k, :) = weights(k, :) - learning_rate * (sum(input) - ...
            %                                                      labels(idx)) ...
            %         * (1 - input(k)^2) * samples(idx, :);
            % end
            
            weights = weights - learning_rate * jacobian(samples(idx, :), ...
                                                         labels(idx), ...
                                                         weights);
        % end
        
        if (1 + mod(i, training_size)) == 1 
            t = (i/training_size + 1);
        cost_of_training(t) = cost_function(samples(training, :), ...
                                            labels(training), weights);
        cost_of_test(t) = cost_function(samples(testing, :), ...
                                        labels(testing), weights);
        end
    end
end

%% jacobian: The jacobian to be used
function [jac] = jacobian(sample, label, weights)
    difference = sigma(sample, weights) - label;
    
    jac = difference * (1 - tanh(weights * sample').^2) * sample;
end

%% sigma
%sigma is compatible with multiple weights (adaptive input-to-hidden weights)
% sample: P x N, where P is the sample size 
% weights: A x N, where A is the number of adaptive weights
% output: sigma : 1 x 10, sigma value for each sample 
function [sigma] = sigma(sample, weights)
    % sum over the collumns
    sigma = sum(tanh(weights * sample'), 1);
end

%% Cost function: computes E
function [E] = cost_function(samples, labels, weights)
    % W = weights';
    % tau = labels';
    % xi = samples';
    % E = sum((ones(1, 2) * tanh(W' * xi) - tau).^2) / (2 * size(xi, 2));
   sample_size = length(labels);
   
   E = sum((sigma(samples, weights) - labels').^2) / (sample_size * 2);
end

