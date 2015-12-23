function [result] = threshold()
    % Check how the threshold effects solutions for different alphas
    N = 200;
    alphas = [0.1:0.1:3];
    thresholds = [0, 0.01, 0.05, 0.1, 0.2, 0.5, 1];
    teacher_runs = 20;

    result = struct('N', [], ...
        'alpha', [], ...
        'successions', [], ...
        'average_steps', [], ...
        'Steps', [], ...
        'thresholds', [] ...
    );
    % Use an average over a set of teachers
    for idx = 1:length(alphas)
        sample_size = ceil(alphas(idx) * N);
        average_steps = zeros(length(thresholds), 1);
        successions = zeros(length(thresholds), 1);
        for teacher_number = 1:teacher_runs
            teacher = randn(N, 1);
            for thresholdIdx = 1:length(thresholds)
                threshold = thresholds(thresholdIdx);
                [labels, samples] = generate_training_data(teacher, sample_size);
                [weights, ~, steps] = rosenblatt_algorithm(labels, samples);

                if (energy_aove_treshold(weights, labels, samples))
                    average_steps(thresholdIdx) = average_steps(thresholdIdx) + steps;
                    successions(thresholdIdx) = successions(thresholdIdx) + 1;
                end
            end
        end
        average_steps = average_steps ./ successions;
        alphas(idx)
        result(idx) = struct('N', N, ...
            'alpha', alphas(idx), ...
            'successions', successions, ...
            'average_steps', average_steps, ...
            'Steps', steps, ...
            'thresholds', thresholds ...
        );
    end
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