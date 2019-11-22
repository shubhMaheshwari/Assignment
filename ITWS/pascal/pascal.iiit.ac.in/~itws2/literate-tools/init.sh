#!/bin/bash

if [ -d literate-tools ]; then
    echo "literate-tools already present"
    (cd literate-tools; git pull)
else
    wget http://pascal.iiit.ac.in/~itws2/literate-tools/literate-tools.tar
    tar xvf literate-tools.tar
fi

if [ -L tangle-make ]; then
    echo "symlinked makefile already present"
else 
    ln -sf literate-tools/makefile tangle-make
fi

