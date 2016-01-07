%% gradient_descent: iteration function used to update the weights of a
%% neural network
function [weights, cost_of_training, cost_of_test, stats] = gradient_descent(weights, ...
                                                      samples, ...
                                                      labels,training_size, ...
                                                      testing_size,learning_rate, ...
                                                      t_max)
    % if (nargout == 4)
    %    stats = struct('training_set', [], 'testing_set', [], 'learning_rate', ...
    %                   []
    % end
figure(randi([1, 256]));
pause(0.1)
    hidden_nodes = size(weights, 1); 
    dimension = size(samples, 2);
    cost_of_training = zeros(t_max, 1);
    cost_of_test = zeros(t_max, 1);
    norms = zeros(hidden_nodes, t_max);
    
    training = 1 : training_size;
    testing = training_size + 1 : min(length(labels), training_size + 1 + testing_size);

    for t = 1 : (t_max * training_size)
            % First we choose a label randomly with equal probability
            idx = randi([1, training_size]);
            % idx = ii;
        
            weights = weights - learning_rate * jacobian(samples(idx, :), ...
                                                         labels(idx), ...
                                                         weights);

            % Update the costs after (training_size) learning steps have been
            % done 
            if (mod(t, training_size) == 1)
                t_i = ceil(t / (training_size)); 
                cost_of_training(t_i) = cost_function(samples(training, :), ...
                                            labels(training), weights);
                cost_of_test(t_i) = cost_function(samples(testing, :), ...
                                        labels(testing), weights);
                norms(:, t_i) = min(weights, [], 2) + max(weights, [], 2);

                plot_costs(cost_of_training, cost_of_test, learning_rate, ...
                           training_size, testing_size, t, norms(:, 1 : t_i), weights);
            end
    end
    plot_costs(cost_of_training, cost_of_test, learning_rate, training_size, ...
               testing_size, t, norms, weights);
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
   sample_size = length(labels);
   
   E = sum((sigma(samples, weights) - labels').^2) / (sample_size * 2);
end


function [handle] = plot_costs(cost_of_training, cost_of_test, learning_rate, training_size, ...
                    testing_size, t, norms, weights)
    subplot(2, 2, 1);
    plot(cost_of_training)
    hold on
    plot(cost_of_test)
    hold off
    set(gca, 'YScale', 'log');
    % set(gca, 'xScale', 'log');
    xlabel('iterations');
    legend('training cost', 'test cost');
    title(sprintf('eta: %f, P: %d, Q: %d, t: %d', learning_rate, training_size, ...
              testing_size, t));
    subplot(2, 2, 2);
    hold on;
    for idx = 1 : size(norms, 1)
        plot(norms(idx, :));
    end
    hold off
    title('min + max of weights');
    % set(gca, 'YScale', 'log');
    % set(gca, 'xScale', 'log');
    xlabel('iterations');

subplot(2, 2, [3 4])
bar(weights', 'grouped');
xlim([0, size(weights, 2) + 1]);
title('Size of component of each weight, where each color is a unique weight');
% subplot(2, 2, 4);
% bar(weights(2, :));
    pause(1)
end
