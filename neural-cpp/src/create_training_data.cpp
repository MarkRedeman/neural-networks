#include "create_training_data.h"

#include <random>
#include <iterator>
#include <algorithm>
#include <chrono>

Dichotomy create_training_data(int dimension, int population_size)
{
    auto seed = std::chrono::high_resolution_clock::now().time_since_epoch().count();
    std::mt19937_64 generator(seed);
    // std::default_random_engine generator;

    // Create uniformly distributed labels
    std::bernoulli_distribution label_distribution;
    std::vector<int> labels(population_size);
    std::generate(labels.begin(), labels.end(), [&]() {
        return label_distribution(generator) ? 1 : -1;
    });

    // Create `population_size` vectors of `dimension`
    std::normal_distribution<double> normal;
    std::vector<std::vector<double>> samples(population_size);
    std::generate(samples.begin(), samples.end(), [&] () {
        std::vector<double> sample(dimension);
        std::generate(sample.begin(), sample.end(), [&] () {
            return normal(generator);
        });
        return sample;
    });

    // Dichotomy dichotomy;
    // dichotomy.labels = labels;
    // dichotomy.samples = samples;
    return Dichotomy(labels, samples);
}