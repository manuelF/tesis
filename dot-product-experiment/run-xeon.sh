#!/bin/bash
module purge
module load icc-host vtune
icc -vec-report3 -O3 -o dot_product_xeon dot_product.c -lrt -openmp 2> compile-log-xeon.txt
./dot_product_xeon 2> run-xeon.txt > result-xeon.txt
