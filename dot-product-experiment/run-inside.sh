#!/bin/bash
chmod u+x dot_product
export LD_LIBRARY_PATH=.
export OMP_NUM_THREADS=180
export KMP_PLACE_THREADS=60C,3T
set ulimit -s unlimited
./dot_product 2> run-xeon-phi.txt > result-xeon-phi.txt
