#ifndef INCLUDED_EXPERIMENT_RUN
#define INCLUDED_EXPERIMENT_RUN

#include <vector>
#include <iostream>

struct Run
{
    bool success;
    size_t steps;

    Run(bool success_, size_t steps_);

    friend std::ostream & operator<<(std::ostream & stream, std::vector<Run> const &);
};

#endif