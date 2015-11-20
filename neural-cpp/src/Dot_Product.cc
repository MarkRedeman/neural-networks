#include "Dot_Product.h"

#include <numeric>
double dot_product(std::vector<double> left, std::vector<double> right)
{
    return std::inner_product(
        left.begin(),
        left.end(),
        right.begin(),
        0
    );
}
