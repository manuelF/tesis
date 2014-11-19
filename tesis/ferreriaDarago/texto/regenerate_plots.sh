#! /bin/bash
pushd plots/cuda
python2 experiments.py
popd

pushd plots/cpu
python2 experiments.py
popd

pushd plots/otros
python2 experiments.py
popd
