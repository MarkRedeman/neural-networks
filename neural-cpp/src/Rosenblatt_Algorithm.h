#ifndef INCLUDED_ROSENBLATT_ALGORITHM
#define INCLUDED_ROSENBLATT_ALGORITHM

#include <cstdio>
#include <vector>
#include "Dichotomy.h"

struct Rosenblatt_Algorithm_Result
{
    std::vector<double> weights;
    double bias;
    size_t steps;

    Rosenblatt_Algorithm_Result(std::vector<double> weights_, double bias_, size_t steps_)
    :
        weights(weights_),
        bias(bias_),
        steps(steps_)
    {}
};

Rosenblatt_Algorithm_Result rosenblatt_algorithm(Dichotomy &dichotomy, size_t max_steps = 500, double threshold = 0);


#endif