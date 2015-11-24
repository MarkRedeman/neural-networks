#include "Run.h"

#include <iterator>
#include <cmath>
#include <ctime>
#include <chrono>
#include <algorithm>

Run::Run(bool success_, size_t steps_)
:
    success(success_),
    steps(steps_)
{};

std::ostream & operator<<(std::ostream & stream, std::vector<Run> const & runs)
{
    stream << "Runs: [";

    std::vector<Run> sorted_runs;
    sorted_runs.reserve(runs.size());
    std::copy(runs.begin(), runs.end(), back_inserter(sorted_runs));
    std::sort(sorted_runs.begin(), sorted_runs.end(), [](Run & left, Run & right)
    {
        return left.steps < right.steps;
    });

    for (Run run : sorted_runs)
    {
        if (run.success)
            stream << run.steps << ", ";
        else
            stream << "NaN, ";
    }
    stream << "]";

    return stream;
}