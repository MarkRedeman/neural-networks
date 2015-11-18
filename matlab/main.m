%% solve_2d_lin_sep:
function [Simulation] = main()
    runs = 100; % n_d
    max_steps = 2500;

    alphas = [0.01:0.01:0.1 0.2:0.1:4];
    Q_linear_separation = struct('N', [], 'alpha', [], 'Q', [], 'successions', [], 'Steps', [], 'Time', []);
    N = 10; % dimension

    for idx = 1:length(alphas)
        total_steps = [];
        successions = 0;
        sample_size = ceil(alphas(idx) * N); % P

        fprintf('Starting iteration %d / %d with P = %d, alpha = %f,', idx, length(alphas), sample_size, alphas(idx));
        tic;
        for run_number = 1:runs
            [labels, samples] = generate_training_data(N, sample_size);
            [weights, ~, steps] = rosenblatt_algorithm(labels, samples, max_steps);
            total_steps = [total_steps, steps];

            if (energy_aove_treshold(weights, labels, samples))
                successions = successions + 1;
            end
        end

        Q_linear_separation(idx) = struct('N', N, 'alpha', alphas(idx), 'Q', successions / runs, 'successions', successions, 'Steps', total_steps, 'Time', toc);

        fprintf(' finished in %e seconds, Q_ls: %f\n', ...
            Q_linear_separation(idx).Time, ...
            mean(Q_linear_separation(idx).Q) ...
        );
    end

    Simulation = struct('Q_linear_separation', Q_linear_separation, ...
        'Runs', runs,           ...
        'Max_steps', max_steps, ...
        'Dimension', N          ...
    );

    save(sprintf('simulation_%d', N), 'Simulation');
end

%% prepare_figure:
function [fig] = prepare_figure()
    fig = figure(1);
    clf;
    set(fig,                        ...
        'NumberTitle', 'off',         ...
        'Name',         mfilename,    ...
        'MenuBar',      'none',       ...
        'Color',        [1.0 1.0 1.0] );
end

%% assert_energy_aove_treshold:
function [above] = energy_aove_treshold(weight, labels, samples)
    sample_size = size(samples, 1);
    above = true;
    for idx = 1 : sample_size
        sample = samples(idx, :);
        label = labels(idx);
        if (dot(weight, sample) * label <= 0)
            above = false;
            break;
        end
    end
end