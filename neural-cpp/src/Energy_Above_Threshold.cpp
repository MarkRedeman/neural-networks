#include "Energy_Above_Threshold.h"

#include "Dot_Product.h"
#include <iostream>
#include <numeric>

#include <algorithm>
#include <iostream>
#include <iterator>
#include <functional>

Energy_Above_Threshold::Energy_Above_Threshold(Dichotomy &dichotomy_)
:
    dichotomy(dichotomy_)
{};

bool Energy_Above_Threshold::Matches(Rosenblatt_Algorithm_Result const &result) const
{
    // we will first check that the weights are not just 0 since such a result wont be
    // meaningful
    if (weights_are_zero(result.weights))
        return false;

    size_t sample_size = dichotomy.labels.size();
    bool success = true;
    for (size_t idx = 0; idx < sample_size; ++idx)
    {
        auto sample = dichotomy.samples[idx];
        double label = dichotomy.labels[idx];

        auto dot_result = dot_product(result.weights, sample);

        if ((dot_result + result.bias) * label <= 0)
            success = false;
    }

    return success;
}

bool Energy_Above_Threshold::weights_are_zero(std::vector<double> const &weights) const
{
    return std::all_of(
        weights.cbegin(),
        weights.cend(),
        [](double weight){ return weight == 0; }
    );
}

std::ostream & operator<<(std::ostream & stm, Energy_Above_Threshold const &)
{
    return stm << "One or more samples were not above the energy threshold";
}
