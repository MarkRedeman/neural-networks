#ifndef INCLUDED_ENERGY_ABOVE_TRESHOLD
#define INCLUDED_ENERGY_ABOVE_TRESHOLD

#include <iostream>
#include "Rosenblatt_Algorithm.h"

struct Energy_Above_Threshold
{
    Dichotomy dichotomy;

    Energy_Above_Threshold(Dichotomy &dichotomy_);

    bool Matches(Rosenblatt_Algorithm_Result const &result) const;

    friend std::ostream & operator<<(std::ostream & stm, Energy_Above_Threshold const &);
};

#endif