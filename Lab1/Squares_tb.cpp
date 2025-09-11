#include <iostream>
using namespace std;

void compute_c(int a, int b, int &c);

int main() {
    // Test cases
    int test_inputs[][2] = {
    	{0, 0},
        {5, 3},
        {7, 6},
        {20, 20},
        {9234, 4234},
        {15123, 10},
		{10, 15123},
		{4343, 2144}
    };

    int num_tests = sizeof(test_inputs) / sizeof(test_inputs[0]);

    for (int i = 0; i < num_tests; i++) {
        int a = test_inputs[i][0];
        int b = test_inputs[i][1];
        int c;

        compute_c(a, b, c);

        cout << "TEST NUM " << i+1
             << ", a: " << a
             << ", b: " << b
             << ", c: " << c << endl;
    }

    return 0;
}

