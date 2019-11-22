#!/bin/bash

data_path=$1

echo "Guassian Elimination on: $data_path"
echo "Data:"
cat $data_path
echo 

num_process=$(head -n1 q1_data.txt | cut -d " " -f 1)
mpic++ -o gauss_elimation q1.cpp -std=c++11
# mpic++ -o gauss_elimation compute_gauss_elimation.cpp -g -Wall -Werror

mpirun -np $num_process gauss_elimation $data_path
rm gauss_elimation