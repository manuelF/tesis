#!/bin/bash
set -euo pipefail

echo "Running on xeon..."
./run-xeon.sh
echo "Running on xeon phi..."
./run-xeon-phi.sh 
echo "Doing summary..."
./summary.py
