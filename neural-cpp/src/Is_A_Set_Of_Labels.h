#ifndef INCLUDED_IS_A_SET_OF_LABELS
#define INCLUDED_IS_A_SET_OF_LABELS

#include <iostream>
#include <vector>
#include <iterator>

struct Is_A_Set_Of_Labels
{
    bool Matches(std::vector<int> const &labels) const;

    friend std::ostream & operator<<(std::ostream & stm, Is_A_Set_Of_Labels const &);
};

#endif