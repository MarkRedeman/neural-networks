#include "Rosenblatt.h"

Rosenblatt::Rosenblatt(Dichotomy &dichotomy, double threshold)
  :
  Perceptron<Rosenblatt>(dichotomy),
  d_threshold(threshold)
{}

void Rosenblatt::train(Dichotomy &dichotomy)
{
  // we will stop iterating once we've separated every sample
  size_t sample_size = dichotomy.samples.size();

  for (size_t idx = 0; idx < sample_size; ++idx)
    {
      auto sample = dichotomy.samples[idx];
      auto desired_label = dichotomy.labels[idx];

      // check if the current sample has been correctly separated,
      // otherwise make a correction to the weights and bias
      auto dot_result = dot_product(d_weights, sample);

      if ((dot_result + d_bias) * desired_label - d_threshold <= 0)
        {
          hebbian_learning_step(sample, desired_label);
          d_should_stop = false;
        }
    }
}

bool Rosenblatt::converged() const
{
  // all samples have been separated, so we stop
  return d_should_stop;
}

double Rosenblatt::threshold() const
{
  return d_threshold;
}
