#include <cstdlib>
#include <ctime>
#include <iostream>

void matrix_mult(int A[2][2], int B[2][2], int AB[2][2]);

int main() {
    int A[2][2];
    int B[2][2];
    int AB[2][2];
    int test_iters = 100;

    srand(time(NULL));

    for (int i = 0; i < test_iters; i++) {

        // Generate random numbers for each matrix
        for (int j = 0; j < 2; j++) {
            for (int k = 0; k < 2; k++) {
                A[j][k] = rand() % 1000;
                B[j][k] = rand() % 1000;
            }
        }

        // Call the DUT
        matrix_mult(A, B, AB);

        // std::cout << "AB Matrix:\n";
        // for (int i=0;i<2;i++){ for (int j=0;j<2;j++) std::cout<<AB[i][j]<<" "; std::cout<<"\n"; }

    }

    return 0;
}
