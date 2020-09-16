#include <cuda.h>
#include <gdnative_api_struct.gen.h>

//
//using namespace std;

/*
int *a, *b;  // host data
int *c, *c2;  // results

__global__ void vecAdd(int *A,int *B,int *C,int N);

void vecAdd_h(int *A1,int *B1, int *C1, int N);
*/

#ifdef __cplusplus
extern "C" {
#endif
	 void init();

char* calc(int64_t**);

	void done();
#ifdef __cplusplus	
}
#endif
