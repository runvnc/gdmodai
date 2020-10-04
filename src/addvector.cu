#include <iostream>
#include <cuda.h>

using namespace std;

int *a, *b;  // host data
int *c, *c2;  // results
int *a_d,*b_d,*c_d;
//int n=10000000;
int n = 100 * 100;
int block_size, block_no; 

char retdata[50];


// detectEdge(int *imgIn, *imgOut)
// add up color of all neighbors
// get avg
// compare to color of this pixel
// if its greater than threshold
// return color set
// else return 0

__global__ void detectEdge(int *imgIn,int *B,int *imgOut,int N)
{
   int i = blockIdx.x * blockDim.x + threadIdx.x;
   int y = i / 100;
   int x = i % 100;
   int sum = 0;
   for (int oy=-1; oy<=1; oy++) {
	 for (int ox=-1; ox<=1; ox++) {
	   int index = (y+oy) * 100 + (x+ox);
	   sum += imgIn[index];
	 }
   }
   float avg = sum / 9.0;
   float diff = imgIn[i] - avg;
   if (abs(diff) > 1000) imgOut[i] = 255*255*100;
   else imgOut[i] = 0;
}

__global__ void vecAdd(int *A,int *B,int *C,int N)
{
   int i = blockIdx.x * blockDim.x + threadIdx.x;
   C[i] = A[i] + B[i]; 
}

void vecAdd_h(int *A1,int *B1, int *C1, int N)
{
   for(int i=0;i<N;i++)
	  C1[i] = A1[i] * B1[i];
}

extern "C" { 

	void init()
	{
	   printf("Begin \n");
	   int nBytes = n*sizeof(int);
	   a = (int *)malloc(nBytes);
	   b = (int *)malloc(nBytes);
	   c = (int *)malloc(nBytes);
	   c2 = (int *)malloc(nBytes);
	   block_size=4000;
	   block_no = n/block_size;
	   dim3 dimBlock(block_size,1,1);
	   dim3 dimGrid(block_no,1,1);
	   for(int i=0;i<n;i++)
		  a[i]=i,b[i]=i;
	   printf("Allocating device memory on host..\n");
	   cudaMalloc((void **)&a_d,n*sizeof(int));
	   cudaMalloc((void **)&b_d,n*sizeof(int));
	   cudaMalloc((void **)&c_d,n*sizeof(int));
	}
	
	int* calc(int64_t **img) {
	   printf("Copying to device..\n");
	   cudaMemcpy(a_d,a,n*sizeof(int),cudaMemcpyHostToDevice);
	   cudaMemcpy(a_d,img,n*sizeof(int),cudaMemcpyHostToDevice);
	   cudaMemcpy(b_d,b,n*sizeof(int),cudaMemcpyHostToDevice);
	   clock_t start_d=clock();
	   printf("Doing GPU edge detect\n");
	   detectEdge<<<block_no,block_size>>>(a_d,b_d,c_d,n);
	   cudaThreadSynchronize();
	   clock_t end_d = clock();
	   double time_d = (double)(end_d-start_d)/CLOCKS_PER_SEC;
	   cudaMemcpy(c,c_d,n*sizeof(int),cudaMemcpyDeviceToHost);
	   return c;
	}
	
	void done() {
	   cudaFree(a_d);
	   cudaFree(b_d);
	   cudaFree(c_d);
	}

}
