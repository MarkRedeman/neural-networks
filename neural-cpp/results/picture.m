fig = open_figure([], sprintf('Iterations needed for convergence for N = %d', results(1).dimension));

old_iterations = iterations;
iterations(find(iterations >= 10000)) = NaN;
median_iterations = median(iterations, 'omitnan');
% Only use the iterations that were not NaN
to_plot = ~ isnan(median_iterations);
iterations = iterations(:, to_plot);

% For each alpha, for the amount of iterations calculate the median and the 25th and 75th percentiles
median_iterations = median_iterations(to_plot);
q1 = quantile(iterations, 0.25);
q3 = quantile(iterations, 0.75);

% The boundedline library we're using draws intervals below and above a line (our median_iterations)
% we now calculate the width of these intervals
confidence_interval = [];
confidence_interval(:, :, 2) = [median_iterations - q1; q3 - median_iterations]';
confidence_interval(:, :, 1) = [median_iterations - min(iterations); max(iterations) - median_iterations]';

[l, p_] = boundedline([results(to_plot).alpha], repmat(median_iterations, 2, 1), ...
        confidence_interval, 'cmap', lines(2), 'transparency', 0.25);

set(p_(2), 'FaceAlpha', 0.9);
set(p_(1), 'FaceAlpha', 0.25);
hold on;

% Create a dotted border around the q1 - q3 interval (the bounded interval)
plot([results(to_plot).alpha], q1, 'k:');
plot([results(to_plot).alpha], q3, 'k:');

% Show the extreme values
plot([results(to_plot).alpha], min(iterations), 'k:');
plot([results(to_plot).alpha], max(iterations), 'k:');

xlabel('$\alpha$');
ylabel('Iterations');
xlim([0.1, 3]);
set(gca,'YScale','log');
title(sprintf('N:= %d, max iterations: %d, total runs: %d', results(1).dimension, results(1).max_steps, results(1).total_runs));

iterations = old_iterations;