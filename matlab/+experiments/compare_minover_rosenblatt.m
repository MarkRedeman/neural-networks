%% compare_minover_rosenblatt:
function compare_minover_rosenblatt()
    N = 2;
    teacher = ones(N, 1);

    for idx = 1 : 3
        P = randi([4, 50]);
        [labels, samples] = generate_training_data(teacher, P);

        max_steps = 100;
        [weights, bias] = minover_algorithm(labels, samples, max_steps);
        sub_fig = subplot(2, 3, idx);
        visualize.plot_2d_linear_separations(sub_fig, labels, samples, weights, bias, teacher);
        title('minover');
        [weights, bias] = rosenblatt_algorithm(labels, samples, max_steps);
        sub_fig = subplot(2, 3, idx + 3);
        visualize.plot_2d_linear_separations(sub_fig, labels, samples, weights, bias, teacher);
        title('rosenblatt');
    end
end