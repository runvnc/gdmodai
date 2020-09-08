#!/bin/bash
nvcc --shared -I../godot_headers -o libsimple.o simple.c --compiler-options '-fPIC'

