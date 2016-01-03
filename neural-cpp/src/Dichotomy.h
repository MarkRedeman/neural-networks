#ifndef INCLUDED_DICHOTOMY
#define INCLUDED_DICHOTOMY

#include <vector>

struct Dichotomy
{
    using Samples = std::vector< std::vector<double> >;

    std::vector<int> labels;
    Samples samples;

    Dichotomy(std::vector<int> labels_, Samples samples_)
    :
        labels(labels_),
        samples(samples_)
    {}

};

#endif
