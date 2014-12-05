#! /bin/bash
set -euo pipefail
for plotfile in $(find plots -name "*experiments.py")
do
    ( pushd $(dirname $plotfile); python2 experiments.py; popd )  &
done
wait
