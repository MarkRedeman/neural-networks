%% gradient_descent: iteration function used to update the weights of a
%% neural network
function [weights, stats] = gradient_descent(weights, training_set, testing_set,learning_rate, ...
                                                      t_max)
    if (nargout >= 2)
       stats = struct('training_set', training_set, 'testing_set', testing_set, 'learning_rate', ...
                      learning_rate, 't_max', t_max, 'initial_weights', weights, ...
                      'final_weights', []);
    end

    hidden_nodes = size(weights, 1); 
    dimension = size(weights, 2);
    cost_of_training = zeros(t_max, 1);
    cost_of_test = zeros(t_max, 1);
    norms = zeros(hidden_nodes, t_max);
    
    training_size = length(training_set.labels);
    testing_size = length(testing_set.labels);

    if (nargout == 0)
        import gradient.cost_function;
        initialize_plots(weights);
    end

    for t = 1 : (t_max * training_size)
        % First we choose a label randomly with equal probability
        idx = randi([1, training_size]);
        weights = weights - learning_rate * jacobian(training_set.samples(idx, :), ...
                                                     training_set.labels(idx), ...
                                                     weights);
            
        % Update the costs after (training_size) learning steps have been done 
        if (nargout == 0 && mod(t, training_size) == 1)
            t_i = ceil(t / training_size); 
            cost_of_training(t_i) = cost_function(training_set.samples, ...
                                training_set.labels, weights);
            cost_of_test(t_i) = cost_function(testing_set.samples, ...
                            testing_set.labels, weights);
            norms(:, t_i) = min(weights, [], 2) + max(weights, [], 2);

            plot_costs(cost_of_training, cost_of_test, learning_rate, ...
                   training_size, testing_size, t, norms(:, 1 : t_i), weights);
        end
        
        if (mod(t, t_max * training_size / 10) == 1)
            fprintf('Progress: %d%%\n', ceil(t * 100 / (t_max * training_size)));
        end
    end
    
    if (nargout >= 2)
        stats.final_weights = weights;
    end
end

%% jacobian: The jacobian to be used
function [jac] = jacobian(sample, label, weights)
    import gradient.sigma;
    difference = sigma(sample, weights) - label;
    
    jac = difference * (1 - tanh(weights * sample').^2) * sample;
end


function [handle] = plot_costs(cost_of_training, cost_of_test, learning_rate, training_size, ...
                    testing_size, t, norms, weights)
    subplot(2, 2, 1);
    plot(cost_of_training)
    plot(cost_of_test)
    title(sprintf('eta: %f, P: %d, Q: %d, t: %d', learning_rate, training_size, ...
              testing_size, t));
    
    subplot(2, 2, 2);
    for idx = 1 : size(norms, 1)
        plot(norms(idx, :));
    end

    subplot(2, 2, [3 4])
    bar(weights', 'grouped');
    xlim([0, size(weights, 2) + 1]);
    title('Size of component of each weight, where each color is a unique weight');

    drawnow limitrate
end

function [handle] = initialize_plots(weights)
    figure(randi([1, 256]));

    subplot(2, 2, 1);
    set(gca, 'YScale', 'log');
    xlabel('iterations');
    legend('training cost', 'test cost');
    hold on;

    % Plotting the min + max of a weight
    subplot(2, 2, 2);
    title('min + max of weights');
    xlabel('iterations');
    hold on;

    % Plotting the weights themself
    subplot(2, 2, [3 4])
    xlim([0, size(weights, 2) + 1]);
    title('Size of component of each weight, where each color is a unique weight');

    drawnow limitrate
end
