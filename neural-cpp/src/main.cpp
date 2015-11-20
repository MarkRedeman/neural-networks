#include "main.h"

#include <iostream>
#include <iterator>
#include <cmath>
#include <ctime>
#include <chrono>

#include "create_training_data.h"
#include "Dichotomy.h"
#include "Rosenblatt_Algorithm.h"
#include "Energy_Above_Threshold.h"

int main(int argc, char **argv)
try
{
    size_t total_runs = 100;
    size_t max_steps = 50000;

    std::vector<double> alphas = { 0.0500, 0.0600, 0.0700, 0.0800, 0.0900, 0.1000, 0.2000, 0.3000, 0.4000, 0.5000, 0.6000, 0.7000, 0.8000, 0.9000, 1.0000, 1.1000, 1.2000, 1.3000, 1.4000, 1.5000, 1.6000, 1.7000, 1.8000, 1.9000, 2.0000, 2.1000, 2.2000, 2.3000, 2.4000, 2.5000, 2.6000, 2.7000, 2.8000, 2.9000, 3.0000, 3.1000, 3.2000, 3.3000, 3.4000, 3.5000, 3.6000, 3.7000, 3.8000, 3.9000, 4.0000 };
    size_t dimension = 10;

    for (size_t idx = 0; idx < alphas.size(); ++idx)
    {
        std::chrono::time_point<std::chrono::system_clock> start, end;
        start = std::chrono::system_clock::now();

        std::vector<int> total_steps;
        size_t successions = 0;
        size_t sample_size = ceil(alphas[idx] * dimension);

        for (size_t run = 0; run < total_runs; ++run)
        {
            Dichotomy dichotomy = create_training_data(dimension, sample_size);
            Rosenblatt_Algorithm_Result result = rosenblatt_algorithm(dichotomy, max_steps);
            total_steps.push_back(result.steps);

            Energy_Above_Threshold matcher(dichotomy);
            if (result.steps < max_steps && matcher.Matches(result))
            {
                ++successions;
            }
        }

        end = std::chrono::system_clock::now();
        std::chrono::duration<double> elapsed_seconds = end - start;
        std::cout << "(" << (idx + 1) << " / " << alphas.size() << ", (alpha: " << alphas[idx] << ", sample size: " << sample_size << ") Elapsed time: " << elapsed_seconds.count() << ", Successions: " << successions << " / " << total_runs << '\n';
    }

    return 0;
}
catch(int x)
{
    return x;
}
