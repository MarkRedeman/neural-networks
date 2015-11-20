#include "Is_A_Set_Of_Labels.h"

bool Is_A_Set_Of_Labels::Matches(std::vector<int> const &labels) const
{
    for (auto label : labels)
        if (label != 1 && label != -1)
            return false;

    return true;
}

std::ostream & operator<<(std::ostream & stm, Is_A_Set_Of_Labels const &)
{
    return stm << "Labels are only allowed to equal +1 or -1";
}