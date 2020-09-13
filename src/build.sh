#!/bin/bash
nvcc --shared -I../godot_headers -o ../simple/bin/libsimple.so addvector.cu simple.c --compiler-options '-fPIC'

