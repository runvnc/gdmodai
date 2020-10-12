#include <stdio.h>
#include "addvector.h"

int main() {
  printf("OK\n");
  init();
  int64_t img[100*100];
  int* ret = calc(img);
  printf("%d\n",ret[0]);  
}



