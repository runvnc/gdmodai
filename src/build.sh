#!/bin/bash
gcc -std=c99 -fPIC -c -I../godot_headers simple.c -o simple.o
nvcc -c addvector.cu -o addvector.o --compiler-options '-fPIC'
gcc -std=c99 -Xlinker '--unresolved-symbols=ignore-all' -rdynamic -shared addvector.o simple.o -o ../simple/bin/libsimple.so -L/usr/local/cuda/lib64 -lcuda -lcudart -lcublas -lcurand  

