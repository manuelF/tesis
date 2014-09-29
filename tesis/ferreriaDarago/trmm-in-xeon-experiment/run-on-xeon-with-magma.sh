#!/bin/bash
env MIC_OMP_NUM_THREADS=240 MIC_KMP_AFFINITY="proclist=[1-236],granularity=fine,explicit" ./xeon-magma $1 $2
