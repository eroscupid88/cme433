
/* kernel.cl 
 * Matrix multiplication
 * Device code.
 * Check out vectorAdd.cl as an example...
 */
 
// OpenCL Kernel
__kernel void matrixMul(__global float* C, __global float* A, __global float* B, int wa, int wb, int wc, int hc){
    int x = get_global_id(0);
    int y = get_global_id(1);

    float sum = 0;
    if (x < wc && y < hc){
        
        for (int n = 0; n < wa; n++){
            sum += A[y*wa + n] * B[n*wb + x];
        }

        C[y*wc + x] = sum;
    }
}