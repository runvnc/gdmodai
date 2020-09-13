#!/bin/bash
nvcc --shared -I../godot_headers -o libsimple.o simple.cu addvector.cu --compiler-options '-fPIC'

