%% solve_2d_lin_sep:
% In this experiment we check that our Rosenblatt algorithm can find an vector,
% weights, that linearly separates a training sample.
function [] = solve_2d_lin_sep()
    open_figure;

    for iteration = 1:9
        [labels, samples] = generate_training_data(2, randi([2, 9]));
        [weights, bias] = rosenblatt_algorithm(labels, samples);

        sub_fig = subplot(3, 3, iteration);
        visualize.plot_2d_linear_separations(sub_fig, labels, samples, weights, bias)
    end

    thresholds = [0, 0.01, 0.05, 0.1, 0.2, 0.5, 1, 10, 100];
    teachers = 5;
    for idx = 1:teachers
        teacher = randn(2, 1);
        [labels, samples] = generate_training_data(teacher, randi([2, 50]));
        samples = samples;
        open_figure;
        for iteration = 1:9
            threshold = thresholds(iteration);
            [weights, bias, steps] = rosenblatt_algorithm(labels, samples, 0.5 * 1E3, threshold);

            sub_fig = subplot(3, 3, iteration);
            visualize.plot_2d_linear_separations(sub_fig, labels, samples, weights, bias, teacher);
            title(sprintf('Threshold : %f, Steps: %d', threshold, steps));
        end
    end

    % thresholds = [0, 0.01, 0.05, 0.1, 0.2, 0.5, 1, 10, 100];
    % teachers = 5;
    % results = {};
    % for idx = 1:teachers
    %     results{idx} = struct('N', [], 'alpha', [], 'successions', [], 'Steps', [], 'Time', []);
    %     teacher = randn(2, 1);
    %     [labels, samples] = generate_training_data(teacher, randi([2, 9]));
    %     open_figure;
    %     for iteration = 1:9
    %         threshold = thresholds(iteration);
    %         [weights, bias, steps] = rosenblatt_algorithm(labels, samples, 0.5 * 1E3, threshold);

    %         results()
    %     end
    % end
end

%% open_figure:
function [fig] = open_figure()
    fig = figure();
    clf;
    set(fig,                        ...
        'NumberTitle', 'off',         ...
        'Name',         mfilename,    ...
        'MenuBar',      'none',       ...
        'Color',        [1.0 1.0 1.0] );
end