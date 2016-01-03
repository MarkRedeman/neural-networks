#include "create_training_data.h"

#include <random>
#include <iterator>
#include <algorithm>
#include <chrono>

#include "Dot_Product.h"
#include "Sign.h"

Dichotomy create_training_data(int dimension, int population_size)
{
    auto samples = normally_distributed_samples(dimension, population_size);
    auto labels = uniformly_distributed_labels(population_size);

    return Dichotomy(labels, samples);
}

Dichotomy create_training_data(std::vector<double> teacher, int population_size)
{
    auto samples = normally_distributed_samples(teacher.size(), population_size);

    std::vector<int> labels;
    labels.reserve(population_size);
    for (auto sample : samples)
        labels.push_back(sign(dot_product(teacher, sample)));

    return Dichotomy(labels, samples);
}

std::vector<std::vector<double>> normally_distributed_samples(int dimension, int population_size)
{
    auto seed = std::chrono::high_resolution_clock::now().time_since_epoch().count();
    std::mt19937_64 generator(seed);
    std::normal_distribution<double> normal;

    // Create `population_size` vectors of `dimension`
    std::vector<std::vector<double>> samples(population_size);
    std::generate(samples.begin(), samples.end(), [&] () {
      std::vector<double> sample(dimension);
      std::generate(sample.begin(), sample.end(), [&] () {
          return normal(generator);
        });
      return sample;
    });

    return samples;
}

std::vector<int> uniformly_distributed_labels(int population_size)
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

    return labels;
}
