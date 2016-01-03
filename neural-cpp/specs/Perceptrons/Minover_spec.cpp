#include <bandit/bandit.h>

using namespace bandit;

#include <numeric>

#include "../../src/Dichotomy.h"
#include "../../src/Rosenblatt_Algorithm.h"
#include "../../src/Energy_Above_Threshold.h"
#include "../../src/Perceptrons/Perceptron.h"
#include "../../src/Perceptrons/Minover.h"
#include "../../src/create_training_data.h"


go_bandit([](){
    describe("The Minover Algorithm for finding a linear separation of a dichotomy", [&](){
        it("finds a linear separation of a 1 dimensional data set", [&](){
            size_t steps = 10;
            Dichotomy dichotomy({-1, 1}, Dichotomy::Samples {{-2}, {2}});
            Minover perceptron(dichotomy);
            perceptron.compute_weights(steps);
            Rosenblatt_Algorithm_Result result(perceptron.weights(), perceptron.bias(), perceptron.steps());

            AssertThat(result.weights, HasLength(1));
            AssertThat(result, Fulfills(Energy_Above_Threshold(dichotomy)));
        });

        it("finds a linear separation of a 2 dimensional data set", [&](){
            Dichotomy dichotomy({-1, 1}, Dichotomy::Samples {{-2, -2}, {2, 2}});

            size_t steps = 10;
            Minover perceptron(dichotomy);
            perceptron.compute_weights(steps);
            Rosenblatt_Algorithm_Result result(perceptron.weights(), perceptron.bias(), perceptron.steps());


            AssertThat(result.weights, HasLength(2));
            AssertThat(result, Fulfills(Energy_Above_Threshold(dichotomy)));
        });

        it("finds a linear separation of a large seperable 2 dimensional data set", [&](){
            std::vector<double> teacher = { 1.0, 1.0 };
            Dichotomy dichotomy = create_training_data(teacher, 10);

            size_t steps = 1000;
            Minover perceptron(dichotomy);
            perceptron.compute_weights(steps);
            Rosenblatt_Algorithm_Result result(perceptron.weights(), perceptron.bias(), perceptron.steps());

            AssertThat(result.weights, HasLength(2));
            AssertThat(result, Fulfills(Energy_Above_Threshold(dichotomy)));
        });

        it("won't find a solution if the data set is not linear separable and will use all steps", [&](){
            Dichotomy dichotomy(
                {-1, 1, -1},
                Dichotomy::Samples {{-1}, {0.5}, {1}}
            );

            size_t steps = 100;
            Minover perceptron(dichotomy);
            perceptron.compute_weights(steps);
            Rosenblatt_Algorithm_Result result(perceptron.weights(), perceptron.bias(), perceptron.steps());

            AssertThat(result.weights, HasLength(1));
            AssertThat(result, Is().Not().Fulfilling(Energy_Above_Threshold(dichotomy)));
        });

        it("finds a linear separation of a high dimensional data set", [&](){
            std::vector<int> labels = {
              1, 1,-1, 1, 1,-1,-1, 1, 1, 1,-1, 1, 1,-1, 1,-1,-1, 1, 1, 1
            };
#include "../20_50_VECTORS.h"
            Dichotomy dichotomy(labels, VECTORS_20_50);

            size_t steps = 100; // 59
            Minover perceptron(dichotomy);
            perceptron.compute_weights(steps);
            Rosenblatt_Algorithm_Result result(perceptron.weights(), perceptron.bias(), perceptron.steps());

            AssertThat(result.weights, HasLength(50));
            AssertThat(result, Fulfills(Energy_Above_Threshold(dichotomy)));
        });

        it("won't find a solution if the data set is not linear separable and will use all steps", [&](){
            Dichotomy dichotomy({-1, -1, 1, 1}, Dichotomy::Samples {{-2, -2}, {2, 2}, {-2, 2}, {2, -2}});

            size_t steps = 10;
            Minover perceptron(dichotomy);
            perceptron.compute_weights(steps);
            Rosenblatt_Algorithm_Result result(perceptron.weights(), perceptron.bias(), perceptron.steps());

            AssertThat(result.weights, HasLength(2));
            AssertThat(result, Is().Not().Fulfilling(Energy_Above_Threshold(dichotomy)));
        });
    });
});
