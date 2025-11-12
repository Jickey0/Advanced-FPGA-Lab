#include <cstdlib>
#include <ctime>
#include <iostream>
#include <ap_int.h>

void matrix_mult(ap_int<8> A[2][2], ap_int<8> B[2][2], ap_int<16> AB[2][2]);

int main() {
    ap_int<8> A[2][2];
    ap_int<8> B[2][2];
    ap_int<16> AB[2][2];
    int test_iters = 100;

    srand(time(NULL));

    for (int i = 0; i < test_iters; i++) {

        // Generate random numbers for each matrix
        for (int j = 0; j < 2; j++) {
            for (int k = 0; k < 2; k++) {
                A[j][k] = rand() % 512; // ensures its within our bitwidth
                B[j][k] = rand() % 512;
            }
        }

        // Call the DUT
        matrix_mult(A, B, AB);

        // std::cout << "AB Matrix:\n";
        // for (int i=0;i<2;i++){ for (int j=0;j<2;j++) std::cout<<AB[i][j]<<" "; std::cout<<"\n"; }

    }

    return 0;
}
