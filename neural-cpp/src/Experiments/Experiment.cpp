#include "Experiment.h"

Experiment::Experiment(size_t dimension_, double alpha_, size_t max_steps_)
:
    dimension(dimension_),
    alpha(alpha_),
    max_steps(max_steps_)
{};

void Experiment::run(size_t total_runs)
{
    d_runs.reserve(total_runs + d_runs.size());

    size_t sample_size = ceil(alpha * dimension);
    for (size_t run = 0; run < total_runs; ++run)
    {
        Dichotomy dichotomy = create_training_data(dimension, sample_size);
        Rosenblatt_Algorithm_Result result = rosenblatt_algorithm(dichotomy, max_steps);

        Energy_Above_Threshold matcher(dichotomy);
        bool success = matcher.Matches(result);

        d_runs.push_back(
            Run(success, result.steps)
        );
    }

}

std::vector<Run> Experiment::runs()
{
    return d_runs;
}

size_t Experiment::successions() const
{
    return std::count_if(d_runs.begin(), d_runs.end(), [](auto run) {
        return run.success == true;
    });
}

std::vector<Run>::const_iterator Experiment::begin() const
{
    return d_runs.begin();
}

std::vector<Run>::const_iterator Experiment::end() const
{
    return d_runs.end();
}

std::ostream & operator<<(std::ostream & stream, Experiment const & experiment)
{
    stream << "{ Dimension: "   << experiment.dimension << ", "
           << "Sample_size: " << (ceil(experiment.dimension * experiment.alpha)) << ", "
           << "Max_steps: "   << experiment.max_steps << ", "
           << "Successions: " << experiment.successions()
                << " / "      << experiment.d_runs.size() << ", "
                              << experiment.d_runs
                              << " }\n";

    return stream;
}