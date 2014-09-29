#!/bin/bash

export MKL_NUM_THREADS=12
export OMP_NUM_THREADS=12
export KMP_AFFINITY=compact,granularity=fine

./xeon $1 $2
