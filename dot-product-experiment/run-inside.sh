#!/bin/bash
chmod u+x dot_product
export LD_LIBRARY_PATH=.
export OMP_NUM_THREADS=240
export KMP_AFFINITY=balanced,granularity=fine
set ulimit -s unlimited
./dot_product 2> run-xeon-phi.txt > result-xeon-phi.txt
