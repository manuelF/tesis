#! /bin/bash
pushd plots/cuda
python2 experiments.py
popd

pushd plots/cpu
python2 experiments.py
popd
