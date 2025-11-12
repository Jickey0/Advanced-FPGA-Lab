#include <iostream>
#include <cassert>
using namespace std;

void matrix_mult(int A[2][2], int B[2][2], int AB[2][2]) {
#pragma HLS INLINE off
row:
    for (int i = 0; i < 2; i++) {
    col:
        for (int j = 0; j < 2; j++) {
            int ABij = 0;
        prod:
            for (int k = 0; k < 2; k++) {
                ABij += A[i][k] * B[k][j];
            }
            AB[i][j] = ABij;
        }
    }
}
