#!/bin/bash

token=$1

num_process=$2

echo "Token: $token"
echo "Num Process: $num_process"

# Compile C File 
mpicc main.c
# mpicc -o quick_sort mpi_quick_sort.c -g -Wall -Werror
# Get input 

mpirun -np $num_process a.out $num_process
rm a.out