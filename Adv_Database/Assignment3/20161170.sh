#!/bin/sh
if [ "$#" -ne 1 ]; then
    python 20161170_1.py $1 $2
else 
    python 20161170_2.py $1
fi
