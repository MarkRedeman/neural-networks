file_to_analyze = 'v_3_experiment_10.log';

data = importdata(file_to_analyze);
results = struct( ...
    'dimension', [], ...
    'sample_size', [], ...
    'alpha', [], ...
    'max_steps', [], ...
    'successions', [], ...
    'total_runs', [], ...
    'iterations', [] ...
);

results_size = 1;
for idx = 1 : size(data, 1)
    % Skip if the same sample size was used
    if (idx > 1 && data(idx - 1, 2) == data(idx, 2))
        continue;
    end

    results(results_size) = struct( ...
        'dimension', data(idx, 1), ...
        'sample_size', data(idx, 2), ...
        'alpha', data(idx, 2) / data(idx, 1), ...
        'max_steps', data(idx, 3), ...
        'successions', data(idx, 4), ...
        'total_runs', data(idx, 5), ...
        'iterations', data(idx, 6:end) ...
    );
    results_size = results_size + 1;
end

iteration_statistics = struct( ...
    'alpha', [], ...
    'min', [], ...
    'max', [], ...
    'median', [], ...
    'mean', [], ...
    'variance', [] ...
);

for idx = 1 : size(results, 2)
    iterations = results(idx).iterations;
    iteration_statistics(idx) = struct( ...
        'alpha', results(idx).alpha, ...
        'min', min(iterations), ...
        'max', max(iterations), ...
        'median', median(iterations),  ...
        'mean', mean(iterations(find(iterations < results(idx).max_steps))), ...
        'variance', var(iterations(find(iterations < results(idx).max_steps))) ...
    );
end

% easy way of showing a table
struct2table(iteration_statistics);

figure
% The histogram might be a bit hard to see since there
% could be few runs with many iterations
runs = results(20).iterations;
runs = runs(find(runs < results(20).max_steps));
h = histogram(runs);
% set(gca,'XScale','log');
h.NumBins = 250;
xlabel('iterations');

iterations = reshape([results.iterations], [results(1).total_runs, size(results, 2)]);
for idx = 1 : size(results, 2)
    max_steps = results(idx).max_steps;
    iterations(find(iterations(:, idx) >= max_steps), idx) = NaN;
end
fig = figure;
% xlim([0, 3]);
w = 1.5;
h = boxplot(iterations, 'labels', [results.alpha], 'positions', [results.alpha], 'whisker', w); %, 'position', unique([results.alpha]));
xData = [];
yData = [];
for idx = 1:size(results, 2)
    xData = [xData, get(h(7, idx), 'Xdata')];
    yData = [yData, get(h(7, idx), 'YData')];
end
close(fig);

figure
plot([results.alpha], median(iterations, 'omitnan'), 'r');
hold on;
% plot([results.alpha], upper_whisker, 'b--');
% plot([results.alpha], lower_whisker, 'b--');
q1 = quantile(iterations, 0.25);
q3 = quantile(iterations, 0.75);
plot([results.alpha], q1, 'k--');
plot([results.alpha], q3, 'k--');
plot(xData, yData, 'dk');

%
set(gca,'YScale','log');
xlabel('\alpha');
ylabel('iterations');

return;
figure;
dimension = results(1).dimension;
Q = [results.successions] ./ [results.total_runs];
plot([results.alpha], Q, 'd', 'MarkerSize', 8, 'MarkerFaceColor', 'k');

P = [];
for alpha = 0:0.01:4
    P = [P, probabilty_of_linear_separation(dimension, ceil(dimension * alpha))];
end
hold on;
plot(0:0.01:4, P, 'b');
legend('Experimental', 'Theoretical');
xlabel('\alpha');
ylabel('Probability of linear separation');

