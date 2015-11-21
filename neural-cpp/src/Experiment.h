#ifndef INCLUDED_EXPERIMENT
#define INCLUDED_EXPERIMENT

#include <vector>

#include <iostream>
#include <iterator>
#include <cmath>
#include <ctime>
#include <chrono>
#include <algorithm>

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
    std::vector<Run> d_runs;

    size_t dimension;
    double alpha;
    size_t max_steps;

    public:
        Experiment(size_t dimension_, double alpha_, size_t max_steps_)
        :
            dimension(dimension_),
            alpha(alpha_),
            max_steps(max_steps_)
        {};

        void run(size_t total_runs = 1)
        {
            d_runs.reserve(total_runs + d_runs.size());

            size_t sample_size = ceil(alpha * dimension);
            for (size_t run = 0; run < total_runs; ++run)
            {
                Dichotomy dichotomy = create_training_data(dimension, sample_size);
                Rosenblatt_Algorithm_Result result = rosenblatt_algorithm(dichotomy, max_steps);

                Energy_Above_Threshold matcher(dichotomy);
                bool success = matcher.Matches(result);

                d_runs.push_back(
                    Run(success, result.steps)
                );
            }

        }

        std::vector<Run> runs()
        {
            return d_runs;
        }

        size_t successions() const
        {
            return std::count_if(d_runs.begin(), d_runs.end(), [](auto run) {
                return run.success == true;
            });
        }

    friend std::ostream & operator<<(std::ostream & stm, Experiment const &);
};
#endif