#include <iostream>
#include <cuda.h>
using namespace std;

/*
int *a, *b;  // host data
int *c, *c2;  // results

__global__ void vecAdd(int *A,int *B,int *C,int N);

void vecAdd_h(int *A1,int *B1, int *C1, int N);
*/

void init();

char* calc();

void done();

