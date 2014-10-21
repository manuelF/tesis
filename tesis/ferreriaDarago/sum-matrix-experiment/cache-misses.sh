#!/bin/bash
set -euo pipefail

python -c "print '\n'.join(['{0} {1}'.format(16,512*u) for u in xrange(1,1000)])" |\
while read testcase; do
    echo -n "$testcase "
    echo $(./fast $testcase 4 2> /dev/null | grep "L2 Cache" | cut -d':' -f2)
done | tee misses-size2.txt

python -c "print '\n'.join(['{0} {1}'.format(512*u,16) for u in xrange(1,1000)])" |\
while read testcase; do
    echo -n "$testcase "
    echo $(./fast $testcase 4 2> /dev/null | grep "L2 Cache" | cut -d':' -f2)
done | tee misses-size1.txt
