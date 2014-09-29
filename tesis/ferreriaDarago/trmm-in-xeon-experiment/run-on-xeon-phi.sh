#!/bin/bash
set -euo pipefail
ssh -n root@mic0 "cd /tmp/mat-mults; chmod u+x run-bench.sh; ./run-bench.sh $1 $2"
