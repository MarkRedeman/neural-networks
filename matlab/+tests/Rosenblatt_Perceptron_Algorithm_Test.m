classdef Rosenblatt_Perceptron_Algorithm_Test < matlab.unittest.TestCase

    methods(Test, TestTags={'Small'})
        %% test_it_finds_a_linear_separation_of_a_1_dimensional_data_set:
        function test_it_finds_a_linear_separation_of_a_1_dimensional_data_set(t)
            labels = [-1, 1];
            samples = [
                -2
                 2
            ];

            % for this set anything between -1 and 1 is correct
            w = rosenblatt_algorithm(labels, samples);
            assert(length(w) == 1);
            t.assert_energy_aove_treshold(w, labels, samples);
        end

        %% test_it_finds_a_linear_separation_of_a_2_dimensional_data_set:
        function test_it_finds_a_linear_separation_of_a_2_dimensional_data_set(t)
            labels = [-1, 1];
            samples = [
                -2 -2
                 2 2
            ];

            % for this set anything between -1 and 1 is correct
            w = rosenblatt_algorithm(labels, samples);
            assert(length(w) == 2);
            t.assert_energy_aove_treshold(w, labels, samples);
        end

        %% test_finds_a_linear_separation_of_a_large_separable_2d_data_set:
        function test_finds_a_linear_separation_of_a_large_separable_2d_data_set(t)
            labels = [-1, -1, -1, -1, -1, 1, 1, 1 1];
            samples = [
                -2, -2
                -1.3, -1
                -1.7, -3
                -1, -1.2
                -0.5, 1
                0.4, 1
                0.3, -3
                1.2, 4
                2, 2
            ];

            % for this set anything between -1 and 1 is correct
            w = rosenblatt_algorithm(labels, samples);
            assert(length(w) == 2);
            t.assert_energy_aove_treshold(w, labels, samples);
        end


        %% test_it_finds_a_linear_separation_of_a_high_dimensional_data_set:
        function test_finds_a_linear_separation_of_a_high_dimensional_data_set(t)
            rng('default');
            [labels, samples] = generate_training_data(50, 20);

            % for this set anything between -1 and 1 is correct
            w = rosenblatt_algorithm(labels, samples);
            assert(length(w) == 50);
            t.assert_energy_aove_treshold(w, labels, samples);
        end

        %% test_uses_max_steps_for_a_set_that_is_not_separable:
        function test_uses_max_steps_for_a_set_that_is_not_separable(t)
            % Samples:
            %  +  -
            %  -  +
            labels = [-1, -1, 1 1];
            samples = [
                -2 -2
                 2 2
                -2, 2
                 2, -2
            ];

            % for this set anything between -1 and 1 is correct
            [w, bias, steps] = rosenblatt_algorithm(labels, samples, 100);
            assert(length(w) == 2);
            assert(steps == 100);

            t.assert_energy_not_aove_treshold(w, labels, samples);
        end
    end

        % %
        % it finds a linear separation of a 1 dimensional data set
        % it finds a linear separation of a 1 dimensional data set

        % it returns the linear separation
        % it returns the
        % it returns the history

        % it fails when it cant find a linear separation
        %  - use example:
        %    + -
        %    - +


   methods
        %% assertIsInteger:
        function assertIsInteger(t, x)
            assert(isequal(0, mod(x, 1)));
        end


        %% assert_energy_aove_treshold:
        function assert_energy_aove_treshold(t, weight, labels, samples)
            sample_size = size(samples, 1);

            for idx = 1 : sample_size
                sample = samples(idx, :);
                label = labels(idx);
                assert(dot(weight, sample) * label > 0);
            end
        end

        %% assert_energy_not_aove_treshold:
        function assert_energy_not_aove_treshold(t, weight, labels, samples)
            sample_size = size(samples, 1);

            below = false;
            for idx = 1 : sample_size
                sample = samples(idx, :);
                label = labels(idx);
                if (dot(weight, sample) * label <= 0)
                    below = true;
                end
            end

            assert(below);
        end

    end
end