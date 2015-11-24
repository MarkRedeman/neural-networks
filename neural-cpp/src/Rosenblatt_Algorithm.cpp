#include "Rosenblatt_Algorithm.h"
#include "Dot_Product.h"
#include <numeric>

#include <algorithm>
#include <iostream>
#include <iterator>

Rosenblatt_Algorithm_Result rosenblatt_algorithm(Dichotomy &dichotomy, size_t max_steps)
{
    size_t dimension = dichotomy.samples[0].size();
    size_t sample_size = dichotomy.labels.size();

    std::vector<double> weights(dimension);
    double bias = 0;
    size_t steps = 0;

    for (; steps < max_steps; ++steps)
    {
        // we will stop iterating once we've separated every sample
        bool found_error = false;

        for (size_t idx = 0; idx < sample_size; ++idx)
        {
            auto sample = dichotomy.samples[idx];
            double desired_label = dichotomy.labels[idx];

            // check if the current sample has been correctly separated,
            // otherwise make a correction to the weights and bias
            auto dot_result = dot_product(weights, sample);

            if ((dot_result + bias) * desired_label <= 0)
            {
                for (size_t weight_idx = 0; weight_idx < weights.size(); ++weight_idx)
                {
                    weights[weight_idx] += (desired_label * sample[weight_idx]) / dimension;
                }
                bias += desired_label / dimension;

                found_error = true;
            }
        }

        // all samples have been separated, so we stop
        if (! found_error) {
            break;
        }
    }

    return Rosenblatt_Algorithm_Result(weights, bias, steps);
}