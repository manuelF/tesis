#!/bin/bash

make clean
make fast
make clean
make slow

python -c "print '\n'.join(['{0} {1}'.format(v, (512 * 1024 * 512) / v) for v in [512, 1024, 4096, 16384, 65536, 524288]])" |\
while read line; do
    ./fast $line
    ./slow $line
done | tee out.txt
