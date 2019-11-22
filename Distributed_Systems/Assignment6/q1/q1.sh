#!/bin/bash

num_process=$1
data_path=$2

echo "Guassian Elimination on: $data_path"

mpic++ -o gauss_elimation q1.c -std=c++11

mpirun -np $num_process gauss_elimation $data_path
rm gauss_elimation