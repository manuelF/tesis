#!/bin/bash
set -euo pipefail

module purge
module load icc-mic lio vtune magma
make xeon-phi
ssh root@mic0 "rm -rf /tmp/mat-mults"
ssh root@mic0 "mkdir -p /tmp/mat-mults"

export SINK_LD_LIBRARY_PATH=$LD_LIBRARY_PATH
micnativeloadex xeon-phi -l | python deps-xeon-phi.py | while read line; do
    scp $line root@mic0:/tmp/mat-mults
done
scp xeon-phi root@mic0:/tmp/mat-mults
scp run-bench.sh root@mic0:/tmp/mat-mults
