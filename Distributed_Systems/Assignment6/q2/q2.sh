#!/bin/bash

num_process=$1
data_path=$2

echo "Conjugate Gradient Method on: $data_path"

mpic++ -o conjugate q2.c -std=c++11

mpirun -np $num_process conjugate $data_path
rm conjugate