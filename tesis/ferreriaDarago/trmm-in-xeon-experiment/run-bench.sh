#!/bin/bash
ulimit -s unlimited
export OMP_NUM_THREADS=240
export MKL_NUM_THREADS=240
export KMP_AFFINITY=compact,granularity=fine
export LD_LIBRARY_PATH=/tmp/mat-mults
./xeon-phi $1 $2
