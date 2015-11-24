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

#include "Experiments/AlphaExperiment.h"

int main(int argc, char **argv)
try
{
    // Try as big as possible
    size_t max_steps = 10000;
    size_t total_runs = 1000;

    // std::vector<double> alphas = { 0.0500, 0.0600, 0.0700, 0.0800, 0.0900, 0.1000, 0.2000, 0.3000, 0.4000, 0.5000, 0.6000, 0.7000, 0.8000, 0.9000, 1.0000, 1.1000, 1.2000, 1.3000, 1.4000, 1.5000, 1.6000, 1.7000, 1.8000, 1.9000, 2.0000, 2.1000, 2.2000, 2.3000, 2.4000, 2.5000, 2.6000, 2.7000, 2.8000, 2.9000, 3.0000, 3.1000, 3.2000, 3.3000, 3.4000, 3.5000, 3.6000, 3.7000, 3.8000, 3.9000, 4.0000 };
    std::vector<double> alphas = { 0.050, 0.060, 0.070, 0.080, 0.090, 0.10, 0.20, 0.30, 0.40, 0.50, 0.60, 0.70, 0.80, 0.90, 1.0, 1.10, 1.20, 1.30, 1.40, 1.50, 1.60, 1.70, 1.80, 1.90, 2.0,
        2.10, 2.20, 2.30, 2.40, 2.50, 2.60, 2.70, 2.80, 2.90, 3.0,
         // 3.2, 3.4, 3.6, 3.8, 4.0
     };
    std::vector<size_t> dimensions = {20, 5, 10, 15, 25, 50, 75, 100, 200};

    for (auto dimension : dimensions)
    {
        AlphaExperiment alphaExperiment(dimension, max_steps, total_runs);
        alphaExperiment.run(alphas);
    }

    return 0;
}
catch(int x)
{
    return x;
}
