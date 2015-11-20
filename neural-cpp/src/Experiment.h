#ifndef INCLUDED_EXPERIMENT
#define INCLUDED_EXPERIMENT

#include <vector>

#include <iostream>
#include <iterator>
#include <cmath>
#include <ctime>
#include <chrono>

#include "create_training_data.h"
#include "Dichotomy.h"
#include "Rosenblatt_Algorithm.h"
#include "Energy_Above_Threshold.h"

struct Run
{
    bool success;
    size_t steps;

    Run(bool success_, size_t steps_)
    :
        success(success_),
        steps(steps_)
    {};
};

class Experiment
{
    std::vector<Run> runs;

    size_t dimension;
    double alpha;
    size_t max_steps;

    public:
        Experiment(size_t dimension_, double alpha_, size_t max_steps_)
        :
            alpha(alpha_),
            dimension(dimension_),
            max_steps(max_steps_),
        {}

        void run(size_t total_runs = 1)
        {
            runs.reserve(total_runs + runs.size());

            std::chrono::time_point<std::chrono::system_clock> start, end;
            start = std::chrono::system_clock::now();

            std::vector<int> total_steps;
            size_t successions = 0;
            size_t sample_size = ceil(alphas[idx] * dimension);

            for (size_t run = 0; run < total_runs; ++run)
            {
                Dichotomy dichotomy = create_training_data(dimension, sample_size);
                Rosenblatt_Algorithm_Result result = rosenblatt_algorithm(dichotomy, max_steps);

                Energy_Above_Threshold matcher(dichotomy);
                runs.push_back(Run(matcher.Matches(result), result.steps));
            }

            end = std::chrono::system_clock::now();
            std::chrono::duration<double> elapsed_seconds = end - start;
            std::cout << "(" << (idx + 1) << " / " << alphas.size() << ", (alpha: " << alphas[idx] << ", sample size: " << sample_size << ") Elapsed time: " << elapsed_seconds.count() << ", Successions: " << successions << " / " << total_runs << '\n';
        }

        std::vector<Run> runs()
        {
            return runs;
        }

    friend std::ostream & operator<<(std::ostream & stm, Experiment const &);
};
#endif