#include "Minover.h"

Minover::Minover(Dichotomy &dichotomy)
  :
  Perceptron<Minover>(dichotomy)
{}

void Minover::train(Dichotomy &dichotomy)
{
    auto idx = find_minimal_stability_index();

    auto sample = dichotomy.samples[idx];
    auto label = dichotomy.labels[idx];

    hebbian_learning_step(sample, label);
}

bool Minover::converged() const
{
    return false;
}
