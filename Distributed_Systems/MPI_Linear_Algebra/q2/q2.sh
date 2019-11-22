#!/bin/bash

num_process=$1
data_path=$2

echo "Guassian Elimination on: $data_path using process:$num_process"
echo "Data:"
cat $data_path
echo

N=$(head -n1 $data_path | cut -d " " -f 1)
M=$(head -n1 $data_path | cut -d " " -f 2)
mpic++ -o congjugate_gradient_method q2.cpp -std=c++11
# mpic++ -o congjugate_gradient_method compute_congjugate_gradient_method.cpp -g -Wall -Werror

mpirun -np $num_process congjugate_gradient_method $N $M $data_path
rm congjugate_gradient_method