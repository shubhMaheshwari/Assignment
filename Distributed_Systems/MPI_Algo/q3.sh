#!/bin/bash

num_process=$1


echo "Num Process: $num_process"

# Compile C File 
mpic++ -o shortest_path mpi_shortest_path.c
# mpicc -o quick_sort mpi_quick_sort.c -g -Wall -Werror
# Get input 

mpirun -np $num_process shortest_path $num_process
rm shortest_path