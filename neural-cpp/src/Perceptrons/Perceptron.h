#ifndef INCLUDED_PERCEPTRON
#define INCLUDED_PERCEPTRON

#include <cmath>
#include <vector>
#include <algorithm>

#include "../Dot_Product.h"
#include "../Sign.h"
#include "../Dichotomy.h"

const double PI = 3.14159265358979323846;

using Sample = std::vector<double>;
template <typename Derived>
class Perceptron
{
  protected:
    // Note: we could also include the bias inside of the weights
    Sample d_weights;
    double d_bias = 0;
    Dichotomy d_dichotomy;

    // steps performed after training
    int d_steps = 0;

  public:
    explicit Perceptron(Dichotomy &dichotomy);
    void compute_weights(size_t max_steps);
    int predict(Sample & sample) const;

    Sample weights() const;
    double bias() const;
    int steps() const;

    double generalization_error(Sample teacher) const;
    double minimal_stability() const;

 protected:
    size_t find_minimal_stability_index() const;
    double stability(size_t idx) const;
    void hebbian_learning_step(Sample sample, double label);
};

template <typename Derived>
Perceptron<Derived>::Perceptron(Dichotomy &dichotomy)
:
    d_weights(Sample(dichotomy.samples[0].size())),
    d_bias(0),
    d_dichotomy(dichotomy),
    d_steps(0)
{}

template <typename Derived>
inline void Perceptron<Derived>::compute_weights(size_t max_steps)
{
  size_t steps = 0;

  for (; steps < max_steps; ++steps)
  {
    static_cast<Derived *>(this)->train(d_dichotomy);

    if (static_cast<Derived *>(this)->converged())
      break;
  }

  d_steps += steps;
}

template <typename Derived>
inline int Perceptron<Derived>::predict(Sample & sample) const
{
  return sign(dot_product(d_weights, sample) + d_bias);
}

template <typename Derived>
inline Sample Perceptron<Derived>::weights() const
{
  return d_weights;
}

template <typename Derived>
inline double Perceptron<Derived>::bias() const
{
  return d_bias;
}

template <typename Derived>
inline int Perceptron<Derived>::steps() const
{
  return d_steps;
}

template <typename Derived>
void Perceptron<Derived>::hebbian_learning_step(Sample sample, double label)
{
  size_t N = d_weights.size();
  for (size_t weight_idx = 0; weight_idx < d_weights.size(); ++weight_idx)
  {
      d_weights[weight_idx] += (label * sample[weight_idx]) / N;
  }
  // d_bias += label / N;
}

template <typename Derived>
double Perceptron<Derived>::generalization_error(Sample teacher) const
{
  return acos(dot_product(teacher, d_weights)
              / (norm(teacher) * norm(d_weights))) / PI;
}

template <typename Derived>
double Perceptron<Derived>::minimal_stability() const
{
  size_t idx = find_minimal_stability_index();
  return stability(idx);
}

template <typename Derived>
double Perceptron<Derived>::stability(size_t idx) const
{
    auto sample = d_dichotomy.samples[idx];
    auto label = d_dichotomy.labels[idx];
    return dot_product(d_weights, sample) * label / norm(d_weights);
}

template <typename Derived>
size_t Perceptron<Derived>::find_minimal_stability_index() const
{
  Sample stabilities;
  stabilities.reserve(d_dichotomy.samples.size());

  // Compute the stability of the current weights with respect
  // to each sample
  // Note: we do not compute the full stability
  for (size_t idx = 0; idx < d_dichotomy.samples.size(); ++idx)
  {
      auto sample = d_dichotomy.samples[idx];
      auto label = d_dichotomy.labels[idx];
      double stability = dot_product(d_weights, sample) * label;
      stabilities.push_back(stability);
  }

  return std::min_element(stabilities.begin(), stabilities.end()) - stabilities.begin();
}

#endif
