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

#include "Experiment.h"

int main(int argc, char **argv)
try
{
    size_t total_runs = 100;
    size_t max_steps = 500;

    std::vector<double> alphas = { 0.0500, 0.0600, 0.0700, 0.0800, 0.0900, 0.1000, 0.2000, 0.3000, 0.4000, 0.5000, 0.6000, 0.7000, 0.8000, 0.9000, 1.0000, 1.1000, 1.2000, 1.3000, 1.4000, 1.5000, 1.6000, 1.7000, 1.8000, 1.9000, 2.0000, 2.1000, 2.2000, 2.3000, 2.4000, 2.5000, 2.6000, 2.7000, 2.8000, 2.9000, 3.0000, 3.1000, 3.2000, 3.3000, 3.4000, 3.5000, 3.6000, 3.7000, 3.8000, 3.9000, 4.0000 };
    size_t dimension = 100;

    for (size_t idx = 0; idx < alphas.size(); ++idx)
    {
        std::chrono::time_point<std::chrono::system_clock> start, end;
        start = std::chrono::system_clock::now();

        // Run the experiments
        Experiment experiment(dimension, alphas[idx], max_steps);
        experiment.run(total_runs);

        end = std::chrono::system_clock::now();
        std::chrono::duration<double> elapsed_seconds = end - start;

        std::cout << "(" << (idx + 1) << " / " << alphas.size()
            << ", (alpha: " << alphas[idx]
            << ", sample size: " << ceil(alphas[idx] * dimension)
            << ") Elapsed time: " << elapsed_seconds.count()
            << ", Successions: " << experiment.successions()
            << " / " << total_runs << '\n';
    }

    return 0;
}
catch(int x)
{
    return x;
}
