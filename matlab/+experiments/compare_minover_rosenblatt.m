%% compare_minover_rosenblatt:
function compare_minover_rosenblatt()
    N = 2;
    teacher = ones(N, 1);

    for idx = 1 : 3
        P = randi([4, 50]);
        [labels, samples] = generate_training_data(teacher, P);

        max_steps = 10;
        [weights_minover, bias] = minover_algorithm(labels, samples, max_steps);
        sub_fig = subplot(1, 3, idx);
        [weights_rosenblatt, bias] = rosenblatt_algorithm(labels, samples, max_steps);
        visualize.plot_2d_linear_separations(sub_fig, labels, samples, [weights_minover ; weights_rosenblatt], bias, teacher);
        legend({'positive', 'negative', 'Minover', 'Rosenblatt', 'Teacher'});
        title('Minover and Rosenblat results');
   end
end