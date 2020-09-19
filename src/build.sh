#!/bin/bash
gcc -std=c11 -fPIC -c -I../godot_headers simple.c -o simple.o
nvcc -c addvector.cu -o addvector.o
gcc -rdynamic -shared simple.o addvector.o -o ../simple/bin/libsimple.so

