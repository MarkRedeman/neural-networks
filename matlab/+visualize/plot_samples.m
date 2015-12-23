%% plot_samples:
function [] = plot_samples(fig, labels, samples)
    positives = labels > 0;
    negatives = labels < 0;

    % close all;
    plot_markers(fig, samples(positives, 1), samples(positives, 2));
    hold on;
    plot_markers(fig, samples(negatives, 1), samples(negatives, 2));
end

%% plot_markers:
function [] = plot_markers(fig, x, y)
    plot(fig, x, y, 'LineStyle', 'none', 'Marker', '.', 'MarkerSize', 36);
end

