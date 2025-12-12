__kernel void saxpy(float a, __global const float *x, __global float *y, int n) {
    int i = get_global_id(0);
    if (i < n) {
        y[i] = a * x[i] + y[i];
}}