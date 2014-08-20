#!/bin/bash
module purge
module load icc-mic vtune
icc -vec-report3 -O3 -openmp -o dot_product_xeon_phi dot_product.c -lrt 2> log-xeon-phi.txt
scp run-inside.sh root@mic0:
export SINK_LD_LIBRARY_PATH=$LD_LIBRARY_PATH
micnativeloadex dot_product_xeon_phi -l | python deps-xeon.py | while read dep
do
    scp $dep root@mic0:
done
scp dot_product_xeon_phi root@mic0:dot_product
ssh root@mic0 "bash run-inside.sh"
scp root@mic0:run-xeon-phi.txt run-xeon-phi.txt
scp root@mic0:result-xeon-phi.txt result-xeon-phi.txt
