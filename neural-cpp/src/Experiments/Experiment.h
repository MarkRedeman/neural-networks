#ifndef INCLUDED_EXPERIMENT
#define INCLUDED_EXPERIMENT

#include <vector>

#include <iostream>
#include <iterator>
#include <cmath>
#include <ctime>
#include <chrono>
#include <algorithm>

#include "../create_training_data.h"
#include "../Dichotomy.h"
#include "../Rosenblatt_Algorithm.h"
#include "../Energy_Above_Threshold.h"
#include "Run.h"

class Experiment
{
    std::vector<Run> d_runs;

    size_t dimension;
    double alpha;
    size_t max_steps;

    public:
        Experiment(size_t dimension_, double alpha_, size_t max_steps_);
        void run(size_t total_runs = 1);

        std::vector<Run> runs();
        size_t successions() const;
        std::vector<Run>::const_iterator begin() const;
        std::vector<Run>::const_iterator end() const;

        std::ostream & info(std::ostream & stream) const;

    friend std::ostream & operator<<(std::ostream & stream, Experiment const &);
};

#endif