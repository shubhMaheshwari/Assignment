#!/bin/bash

num_process=$1

echo "Num Process: $num_process"

# Compile C File 
mpic++ -o stable_marriage mpi_stable_marriage.cpp

mpirun -np $num_process stable_marriage
rm stable_marriage