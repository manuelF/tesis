#!/bin/bash
set -euo pipefail

module purge
module load icc-host vtune
icc -profile-functions -vec-report6 -O2 -g -std=gnu99 -o dot_product_xeon dot_product.c -lrt -lirc -openmp 2> log-xeon.txt
./dot_product_xeon > result-xeon.txt 2> run-xeon.txt
