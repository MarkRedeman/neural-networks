#include <bandit/bandit.h>

using namespace bandit;

#include <numeric>

#include "../../src/Dichotomy.h"
#include "../../src/Rosenblatt_Algorithm.h"
#include "../../src/Energy_Above_Threshold.h"
#include "../../src/Perceptrons/Perceptron.h"
#include "../../src/Perceptrons/Rosenblatt.h"


go_bandit([](){
    describe("The Rosenblatt Algorithm for finding a linear separation of a dichotomy", [&](){
        it("finds a linear separation of a 1 dimensional data set", [&](){
            size_t steps = 10;
            Dichotomy dichotomy({-1, 1}, Dichotomy::Samples {{-2}, {2}});
            Rosenblatt perceptron(dichotomy);
            perceptron.compute_weights(steps);
            Rosenblatt_Algorithm_Result result(perceptron.weights(), perceptron.bias(), perceptron.steps());

            AssertThat(result.weights, HasLength(1));
            AssertThat(result, Fulfills(Energy_Above_Threshold(dichotomy)));
        });

        it("finds a linear separation of a 2 dimensional data set", [&](){
            Dichotomy dichotomy({-1, 1}, Dichotomy::Samples {{-2, -2}, {2, 2}});

            size_t steps = 10;
            Rosenblatt perceptron(dichotomy);
            perceptron.compute_weights(steps);
            Rosenblatt_Algorithm_Result result(perceptron.weights(), perceptron.bias(), perceptron.steps());

            AssertThat(result.weights, HasLength(2));
            AssertThat(result, Fulfills(Energy_Above_Threshold(dichotomy)));
        });

        it("finds a linear separation of a large seperable 2 dimensional data set", [&](){
            Dichotomy dichotomy({-1, -1, -1, -1, -1, 1, 1, 1, 1}, Dichotomy::Samples {
                { -2, -2 },
                { -1.3, -1 },
                { -1.7, -3 },
                { -1, -1.2 },
                { -0.5, 1 },
                { 0.4, 1 },
                { 0.3, -3 },
                { 1.2, 4 },
                { 2, 2 }
            });

            size_t steps = 10;
            Rosenblatt perceptron(dichotomy);
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
            Rosenblatt perceptron(dichotomy);
            perceptron.compute_weights(steps);
            Rosenblatt_Algorithm_Result result(perceptron.weights(), perceptron.bias(), perceptron.steps());

            AssertThat(result.weights, HasLength(1));
            AssertThat(result, Is().Not().Fulfilling(Energy_Above_Threshold(dichotomy)));
        });

        it("won't find a solution if the data set is not linear separable and will use all steps", [&](){
            Dichotomy dichotomy({-1, -1, 1, 1}, Dichotomy::Samples {{-2, -2}, {2, 2}, {-2, 2}, {2, -2}});

            size_t steps = 10;
            Rosenblatt perceptron(dichotomy);
            perceptron.compute_weights(steps);
            Rosenblatt_Algorithm_Result result(perceptron.weights(), perceptron.bias(), perceptron.steps());

            AssertThat(result.weights, HasLength(2));
            AssertThat(result, Is().Not().Fulfilling(Energy_Above_Threshold(dichotomy)));
        });
    });
});
