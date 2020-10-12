//
//using namespace std;

/*
int *a, *b;  // host data
int *c, *c2;  // results

__global__ void vecAdd(int *A,int *B,int *C,int N);

void vecAdd_h(int *A1,int *B1, int *C1, int N);
*/

#define int64_t __int64_t

#ifdef __cplusplus
extern "C" {
#endif
	 void init();

int* calc(int64_t*);

	void done();
#ifdef __cplusplus	
}
#endif
