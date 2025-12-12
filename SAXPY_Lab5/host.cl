#include <CL/cl.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N 1024

int main() {
    // 1. Host Data Setup
    float a = 2.0f;
    float *x = (float*)malloc(sizeof(float) * N);
    float *y = (float*)malloc(sizeof(float) * N);
    for(int i=0; i<N; i++) { x[i] = 1.0f; y[i] = 2.0f; }

    // 2. OpenCL Setup
    cl_platform_id platform;
    cl_device_id device;
    clGetPlatformIDs(1, &platform, NULL);
    clGetDeviceIDs(platform, CL_DEVICE_TYPE_DEFAULT, 1, &device, NULL);
    cl_context ctx = clCreateContext(NULL, 1, &device, NULL, NULL, NULL);
    cl_command_queue queue = clCreateCommandQueue(ctx, device, 0, NULL);

    // 3. Load Kernel Source
    FILE *fp = fopen("saxpy.cl", "r");
    char *source_str = (char*)malloc(0x10000);
    size_t source_size = fread(source_str, 1, 0x10000, fp);
    fclose(fp);

    // 4. Build Kernel
    cl_program program = clCreateProgramWithSource(ctx, 1, (const char**)&source_str, &source_size, NULL);
    clBuildProgram(program, 1, &device, NULL, NULL, NULL);
    cl_kernel kernel = clCreateKernel(program, "saxpy", NULL);

    // 5. Create Buffers & Copy Data
    cl_mem buf_x = clCreateBuffer(ctx, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR, sizeof(float)*N, x, NULL);
    cl_mem buf_y = clCreateBuffer(ctx, CL_MEM_READ_WRITE | CL_MEM_COPY_HOST_PTR, sizeof(float)*N, y, NULL);

    // 6. Set Arguments & Execute
    int n = N; 
    clSetKernelArg(kernel, 0, sizeof(float), &a);
    clSetKernelArg(kernel, 1, sizeof(cl_mem), &buf_x);
    clSetKernelArg(kernel, 2, sizeof(cl_mem), &buf_y);
    clSetKernelArg(kernel, 3, sizeof(int), &n);

    // Measure Latency
    size_t global = N;
    clock_t start = clock();
    clEnqueueNDRangeKernel(queue, kernel, 1, NULL, &global, NULL, 0, NULL, NULL);
    clFinish(queue);
    printf("Latency: %f ms\n", (double)(clock() - start) / CLOCKS_PER_SEC * 1000.0);

    // 7. Read Back & Cleanup
    clEnqueueReadBuffer(queue, buf_y, CL_TRUE, 0, sizeof(float)*N, y, 0, NULL, NULL);
    
    // Quick verification
    if (y[0] == 4.0f) printf("Resust Verified.\n");
    
    return 0;
}