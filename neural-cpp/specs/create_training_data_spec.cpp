#include <bandit/bandit.h>

using namespace bandit;

#include "../src/create_training_data.h"
#include "../src/Is_A_Set_Of_Labels.h"
#include "../src/Rosenblatt_Algorithm.h"
#include "../src/Energy_Above_Threshold.h"

go_bandit([](){
    describe("Creating training data for the perceptron algorithm", [&](){
        it("creates a random dichotomy of data", [&](){
            Dichotomy dichotomy = create_training_data(2, 1);

            AssertThat(dichotomy.labels, HasLength(1));
            AssertThat(dichotomy.samples, HasLength(1));
            AssertThat(dichotomy.samples[0], HasLength(2));

            AssertThat(dichotomy.labels, Fulfills(Is_A_Set_Of_Labels()));
        });

        it("creates a large set of random labels and samples", [&](){
            Dichotomy dichotomy = create_training_data(2, 100);

            AssertThat(dichotomy.labels, HasLength(100));
            AssertThat(dichotomy.samples, HasLength(100));
            AssertThat(dichotomy.samples[0], HasLength(2));

            AssertThat(dichotomy.labels, Fulfills(Is_A_Set_Of_Labels()));
        });

        it("creates a set of random labels and high dimensional samples", [&](){
            Dichotomy dichotomy = create_training_data(50, 1);

            AssertThat(dichotomy.labels, HasLength(1));
            AssertThat(dichotomy.samples, HasLength(1));
            AssertThat(dichotomy.samples[0], HasLength(50));

            AssertThat(dichotomy.labels, Fulfills(Is_A_Set_Of_Labels()));
        });
    });


    describe("Create training data based on a teacher", [&](){
        it("Creates a normally distributed set of samples with labels based on a teacher perceptron", [&]() {
            std::vector<double> teacher = { 1.0, 1.0 };
            Dichotomy dichotomy = create_training_data(teacher, 20);

            AssertThat(dichotomy.labels, HasLength(20));
            AssertThat(dichotomy.samples, HasLength(20));
            AssertThat(dichotomy.samples[0], HasLength(2));

            AssertThat(dichotomy.labels, Fulfills(Is_A_Set_Of_Labels()));

            Rosenblatt_Algorithm_Result result(teacher, 0, 0);
            AssertThat(result, Fulfills(Energy_Above_Threshold(dichotomy)));
        });
    });
});
