#ifndef INCLUDED_CREATE_TRAINING_DATA
#define INCLUDED_CREATE_TRAINING_DATA

#include "Dichotomy.h"
#include "Sign.h"

Dichotomy create_training_data(int dimension, int population_size);
Dichotomy create_training_data(std::vector<double> teacher, int population_size);

std::vector<std::vector<double>> normally_distributed_samples(int dimension, int population_size);
std::vector<int> uniformly_distributed_labels(int population_size);

#endif
