classdef Generate_Training_Data_Test < matlab.unittest.TestCase

    methods(Test, TestTags={'Small'})
        %% test_it_creates_a_random_vector_and_a_random_label:
        function Stest_it_creates_a_random_vector_and_a_random_label(t)
            N = 2; % the size of the vector
            [labels, vectors] = generate_training_data(N, 1);

            % Check that enough labels and vectors were generated
            assert(isequal(1, size(labels, 1)));
            assert(isequal(1, size(vectors, 1)));

            % Check the value of the labels and vectors
            t.assertIsInteger(labels(1));
            assert(isequal(2, size(vectors, 2)));
        end

        function Stest_it_creates_more_than_one_random_vector_and_a_random_label(t)
            N = 2; % the size of the vector
            P = 10; % population size
            [labels, vectors] = generate_training_data(N, P);

            % Check that enough labels and vectors were generated
            assert(isequal(P, size(labels, 1)));
            assert(isequal(P, size(vectors, 1)));

            % Check the value of the labels and vectors
            t.assertIsInteger(labels(1));
            assert(isequal(2, size(vectors, 2)));
        end

        %% test_it_generates_large_normal_distributed_vectors:
        function Stest_it_generates_large_normal_distributed_vectors(t)
            N = 200; % the size of the vector
            P = 1; % population size
            [labels, vectors] = generate_training_data(N, P);

            % Check that enough labels and vectors were generated
            assert(isequal(P, size(labels, 1)));
            assert(isequal(P, size(vectors, 1)));

            % Check the value of the labels and vectors
            t.assertIsInteger(labels(1));
            assert(isequal(200, size(vectors, 2)));
        end
    end

   methods
        %% assertIsInteger:
        function assertIsInteger(t, x)
            assert(isequal(0, mod(x, 1)));
        end
    end
end