#!/bin/bash
set -euo pipefail

make clean

module purge
module load icc-host magma
make xeon
make xeon-magma

./move-to-xeon-phi.sh

module purge
module load icc-host vtune lio magma

rm -rf xeon-data.txt xeon-phi-data.txt xeon-magma-data.txt
python -c "print '\n'.join(['{0} {1}'.format(472,15000+5000*v) for v in xrange(0,30)])" |\
while read line; do
    echo "Running $line on Xeon"
    ./run-on-xeon.sh $line | tee -a xeon-data.txt 
    echo "Running $line on Xeon Phi"
    ./run-on-xeon-phi.sh $line | tee -a xeon-phi-data.txt 
    echo "Running $line on Xeon with MAGMA"
    ./run-on-xeon-with-magma.sh $line | tee -a xeon-magma-data.txt 
done
