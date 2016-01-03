#include "Dot_Product.h"

// #include <numeric>
#include <parallel/numeric>
#include <cmath>

double dot_product(std::vector<double> left, std::vector<double> right)
{
    return std::inner_product(
        left.begin(),
        left.end(),
        right.begin(),
        0.0
    );
}

double norm(std::vector<double> vector)
{
    return sqrt(dot_product(vector, vector));
}
