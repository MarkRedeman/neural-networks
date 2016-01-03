#ifndef INCLUDED_ROSENBLATT_PERCEPTRON
#define INCLUDED_ROSENBLATT_PERCEPTRON

#include <cstddef>
#include "Perceptron.h"

class Rosenblatt : public Perceptron<Rosenblatt>
{
  friend void Perceptron<Rosenblatt>::compute_weights(size_t max_steps);

  bool d_should_stop = false;
  double d_threshold = 0.0;

  void train(Dichotomy &dichotomy);
  bool converged() const;

  public:
    explicit Rosenblatt(Dichotomy &dichotomy, double threshold = 0.0);
    double threshold() const;
};

#endif
