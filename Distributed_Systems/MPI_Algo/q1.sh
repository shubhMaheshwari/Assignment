#!/bin/bash

num_process=$1

num_elements=$2

elements=$3

echo "Num Process: $num_process"
echo "Num elements: $num_elements"
echo "Array Elements: $elements"
# Compile C File 
mpicc -o quick_sort mpi_quick_sort.c
# mpicc -o quick_sort mpi_quick_sort.c -g -Wall -Werror
# Get input 

mpirun -np $num_process quick_sort $2 $3
rm quick_sort