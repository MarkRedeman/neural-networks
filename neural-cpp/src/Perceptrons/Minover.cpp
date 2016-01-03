#include "Minover.h"
#include <cmath>

Minover::Minover(Dichotomy &dichotomy)
  :
  Perceptron<Minover>(dichotomy)
{}

void Minover::train(Dichotomy &dichotomy)
{
    auto idx = find_minimal_stability_index();
    rememberStability(stability(idx));

    auto sample = dichotomy.samples[idx];
    auto label = dichotomy.labels[idx];

    hebbian_learning_step(sample, label);
}

void Minover::rememberStability(double stability)
{
    d_stabilities.push(stability);
    // Only remember the last P stabilities
    if (d_stabilities.size() > d_weights.size())
        d_stabilities.pop();
}

bool Minover::converged() const
{
    auto current_stability = d_stabilities.back();
    auto previous_stability = d_stabilities.front();

    return std::abs(current_stability - previous_stability) < 1e-5;
}
