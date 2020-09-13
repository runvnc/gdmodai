#include <cuda.h>
#include <gdnative_api_struct.gen.h>

#ifdef __cplusplus
#define EXTERNC extern "C"
#else
#define EXTERNC
#endif

//
//using namespace std;

/*
int *a, *b;  // host data
int *c, *c2;  // results

__global__ void vecAdd(int *A,int *B,int *C,int N);

void vecAdd_h(int *A1,int *B1, int *C1, int N);
*/

EXTERNC void init();

EXTERNC  char* calc();

EXTERNC  void done();
