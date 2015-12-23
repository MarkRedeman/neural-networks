%% plot_2d_linear_separations:
function [] = plot_2d_linear_separations(fig, labels, samples, weights, bias, teacher)
    limits = plotting_limits(samples);
    axis('equal');
    set( fig,                                  ...
        'Box',      'on',                      ...
        'NextPlot', 'add',                     ...
        'xgrid',    'on',                      ...
        'ygrid',    'on',                      ...
        'xlim',     limits(1, :), ... % Bounds suitable for Z-scored data
        'ylim',     limits(2, :));

    xlabel('x_1');
    ylabel('x_2');
    hold on;

    visualize.plot_samples(fig, labels, samples);

    origin = - bias * weights ./ norm(weights)^2;
    plot_line_normal_to(weights, origin, limits(1, :));

    if (nargin == 6)
        origin = - bias * teacher ./ norm(teacher)^2;
        plot_line_normal_to(teacher, 0 * origin, limits(1, :), 'k:');
        legend({'positive', 'negative', 'Weights', 'Teacher'}, 'Location', 'BestOutside');
    end
end

%% plotting_limits:
function [limits] = plotting_limits(samples)
    limits = [
         min(samples(:, 1)),  max(samples(:, 1))
         min(samples(:, 2)),  max(samples(:, 2))
    ];

    % Add a border to the limits so that we don't plot samples exactly
    % at the border
    dx = abs(min(samples(:, 1)) - max(samples(:, 1)));
    dy = abs(min(samples(:, 2)) - max(samples(:, 2)));
    limits = limits + 0.5 * [
        -dx, dx
        -dy, dy
    ];

    % Make the plotting area at least min_bound x min_bound big
    min_bound = 3;
    limits = [
        min(limits(1, 1), - min_bound), max(limits(1, 2),  min_bound)
        min(limits(2, 1), - min_bound), max(limits(2, 2),  min_bound)
    ];

    % Make it square
    limits = [
        min(limits(1, 1), limits(2, 1)), max(limits(1, 2), limits(2, 2))
        min(limits(1, 1), limits(2, 1)), max(limits(1, 2), limits(2, 2))
    ];
end


%% plot_line_normal_to:
function [] = plot_line_normal_to(normal, origin, limits, color)
    if (nargin < 4)
        color = 'r';
    end
    d = -dot(origin, normal);
    f = @(x) - (normal(1) * x + d) / normal(2);
    fplot(f, limits, color);
end
