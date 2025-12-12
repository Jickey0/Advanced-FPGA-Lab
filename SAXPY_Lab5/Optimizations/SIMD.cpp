// Process 6 items at once per thread
__attribute__((num_simd_work_items(6))) 
__attribute__((reqd_work_group_size(64, 1, 1))) // Helper to organize threads

