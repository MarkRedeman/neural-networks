#ifndef INCLUDED_ALPHA_EXPERIMENT
#define INCLUDED_ALPHA_EXPERIMENT

#include <vector>
#include "Run.h"

class AlphaExperiment
{
    // std::vector<Experiment> d_experiments;

    size_t dimension;
    size_t max_steps;
    size_t max_runs;

    public:
        AlphaExperiment(size_t dimension_, size_t max_steps_, size_t max_runs);
        void run(std::vector<double> alphas);
};

#endif