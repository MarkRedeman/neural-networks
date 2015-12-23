%% compare_theoretical:
function [] = compare_theoretical(results, iterations, thresholds)
    max_threshold = results(1).max_steps;
    fig = open_figure([], sprintf('Probability of linear separtaion for N = %d', results(1).dimension));

    colors = lines(length(thresholds) + 1);

    successions = [results.successions];
    Q = successions ./ [results.total_runs];
    plot([results.alpha], Q, 'd', 'MarkerSize', 8, 'MarkerFaceColor', colors(1, :));
    legends = {};
    legends(1) = {sprintf('Iterations < %d', max_threshold)};
    hold on;
    for idx = 1:length(thresholds)
        % TODO: check if iterations correctly correspond to the alpha
        successions = sum(iterations < thresholds(idx)) ./ [results.total_runs];
        plot([results.alpha], successions, 'd', 'MarkerSize', 8, 'MarkerFaceColor', colors(idx + 1, :));
        legends{idx + 1} = sprintf('Iterations < %d', thresholds(idx));
    end

    legends{length(thresholds) + 2} = sprintf('Theoretical');
    P = [];
    dimension = results(1).dimension;
    for alpha = 0:0.01:4
        P = [P, probabilty_of_linear_separation(dimension, ceil(dimension * alpha))];
    end
    hold on;
    plot(0:0.01:4, P, 'b');
    legend(legends);
    % legend('Experimental', 'Theoretical');
    xlabel('$\alpha$', 'interpreter', 'latex');
    ylabel('Probability of linear separation');
    ylim([0, 1]);
    xlim([0, 4]);
end
