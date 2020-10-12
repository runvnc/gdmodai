#!/bin/bash
nvcc -c addvector.cu -o addvector.o --compiler-options '-fPIC'
nvcc test.cu addvector.o -o test

#gcc -std=c99 -Xlinker '--unresolved-symbols=ignore-all' addvector.o test.o -o test -L/usr/local/cuda/lib64 -lcuda -lcudart -lcublas -lcurand  

