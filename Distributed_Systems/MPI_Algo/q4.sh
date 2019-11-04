#!/bin/bash

num_process=$1

echo "Num Process: $num_process"

# Compile C File 
mpic++ -o vertex_coloring mpi_vertex_coloring.cpp
# mpicc -o quick_sort mpi_quick_sort.c -g -Wall -Werror
# Get input 

mpirun -np $num_process vertex_coloring
rm vertex_coloring