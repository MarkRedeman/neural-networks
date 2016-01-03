#ifndef INCLUDED_MINOVER_PERCEPTRON
#define INCLUDED_MINOVER_PERCEPTRON

#include <cstddef>
#include "Perceptron.h"

class Minover : public Perceptron<Minover>
{
  friend void Perceptron<Minover>::compute_weights(size_t max_steps);

  bool d_should_stop = false;
  std::vector<Sample> d_old_weights;

  void train(Dichotomy &dichotomy);
  bool converged() const;

public:
  explicit Minover(Dichotomy &dichotomy);
  double threshold() const;
};

#endif
