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

#include <fstream>

int main(int argc, char **argv)
try
{
    std::string filename = "minover_teached_experiment.log";
    std::ofstream output_file;
    
    // Try as big as possible
    size_t max_steps = 10000;
    size_t total_runs = 1000;

    // std::vector<size_t> dimensions = {5, 10, 15, 20, 25, 50, 75, 100, 200};

    std::vector<double> alphas = { 0.050, 0.060, 0.070, 0.080, 0.090, 0.10, 0.20, 0.30, 0.40, 0.50, 0.60, 0.70, 0.80, 0.90, 1.0, 1.10, 1.20, 1.30, 1.40, 1.50, 1.60, 1.70, 1.80, 1.90, 2.0,
        2.10, 2.20, 2.30, 2.40, 2.50, 2.60, 2.70, 2.80, 2.90, 3.0,
         // 3.2, 3.4, 3.6, 3.8, 4.0
     };

    std::vector<double> alpha = {
      0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0,
      // 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0,
      // 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0,
      // 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0,
    }
    std::vector<size_t> dimensions = {20};


    output_file.open(filename.str(), std::ofstream::out | std::ofstream::app );
    for (auto dimension : dimensions)
    {
        StabilityExperiment stabilityExperiment(dimension, max_steps, total_runs);
        stabilityExperiment.run(alphas, output_file);
    }
    output_file.close();

    return 0;
}
catch(int x)
{
    return x;
}
