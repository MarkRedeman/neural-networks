#include "AlphaExperiment.h"

#include <iostream>
#include <iterator>
#include <cmath>
#include <ctime>
#include <chrono>

#include <sstream>
#include <fstream>

#include "Experiment.h"

AlphaExperiment::AlphaExperiment(size_t dimension_, size_t max_steps_, size_t max_runs_)
:
    dimension(dimension_),
    max_steps(max_steps_),
    max_runs(max_runs_)
{};

void AlphaExperiment::run(std::vector<double> alphas)
{
    std::stringstream filename;
    filename << "results/v_4_experiment_" << dimension << ".log";
    std::ofstream output_file;

    for (auto alpha : alphas)
    {
        std::chrono::time_point<std::chrono::system_clock> start, end;
        start = std::chrono::system_clock::now();

        Experiment experiment(dimension, alpha, max_steps);
        experiment.run(max_runs);

        end = std::chrono::system_clock::now();
        std::chrono::duration<double> elapsed_seconds = end - start;

        std::cout << "(alpha: " << alpha
            << ", sample size: " << ceil(alpha * dimension)
            << ") Elapsed time: " << elapsed_seconds.count()
            << ", Successions: " << experiment.successions()
            << " / " << max_runs << '\n';


        output_file.open(filename.str(), std::ofstream::out | std::ofstream::app );
        output_file << experiment;
        output_file.close();
    }
}