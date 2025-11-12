#include <iostream>
#include <cassert>
#include <ap_int.h>
using namespace std;

void matrix_mult(ap_int<8> A[2][2], ap_int<8> B[2][2], ap_int<16> AB[2][2]) {
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
