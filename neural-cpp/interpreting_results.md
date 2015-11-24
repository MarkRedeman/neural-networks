# Extracting results for matlab
Given that we have a file named `experiment_20.log` we can analyze it by using matlab.
First we will need reformat the file so that it is compatible with matlab, we can use  the following regexp for that,
```regex
\{ Dimension: (\d+), Sample_size: (\d+), Max_steps: (\d+), Successions: (\d+) / (\d+), Runs: \[([!?\d+!?, ]+)\] \}

$1, $2, $3, $4, $5, $6
```
After this we should also remove all runs that did not succeed.
```
![\d]+!

NaN
```

Next we will load the data into matlab
```matlab
data = importdata('v_3_experiment_100.log');
results = struct( ...
    'dimension', [], ...
    'sample_size', [], ...
    'alpha', [], ...
    'max_steps', [], ...
    'successions', [], ...
    'total_runs', [], ...
    'iterations', [] ...
);

for idx = 1 : size(data, 1)
    results(idx) = struct( ...
        'dimension', data(idx, 1), ...
        'sample_size', data(idx, 2), ...
        'alpha', data(idx, 2) / data(idx, 1), ...
        'max_steps', data(idx, 3), ...
        'successions', data(idx, 4), ...
        'total_runs', data(idx, 5), ...
        'iterations', data(idx, 6:end) ...
    );
end
```

Next we can compute the mean and the variance of the iterations needed to find a linear separation,
```matlab
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
```

We are now ready to create graphs and tables!
Let's start with a histogram of the iterations,
```matlab
% easy way of showing a table
struct2table(iteration_statistics)

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
boxplot(iterations, 'labels', [results.alpha]);
set(gca,'YScale','log');
xlabel('$\alpha$');
ylabel('iterations');
```

We are also interested in the success rate and whether it agrees with the theory.
```matlab
%% probabilty_of_linear_separation:
function [probability] = probabilty_of_linear_separation(dimension, sample_size)
    if (sample_size <= dimension)
        return probability = 1;
    else
        probability = 0;
        n = sample_size - 1;

        for idx = 1 : (dimension - 1)
            probability = probability + nchoosek(n, idx);
        end

        probability = 2^(n) * probability
    end
end
```

```matlab
dimension = results(1).dimension;
Q = [results.successions] ./ [results.total_runs];
plot([results.alpha], Q);

P = [];
for alpha = [results.alpha]
    dimension,
    ceil(dimension * alpha)
    P = [P, probabilty_of_linear_separation(dimension, ceil(dimension * alpha))];
end
hold on;
plot([results.alpha], P);
```