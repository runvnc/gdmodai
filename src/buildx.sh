#!/bin/bash
nvcc --shared -I../godot_headers -o ../simple/bin/libsimple.so simple.c addvector.cu --compiler-options '-fPIC'

