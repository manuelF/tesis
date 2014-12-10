#!/bin/bash

for i in *.svg
do
    in=$(basename $i .svg)
    out=$in.pdf
    if [[ "$in" =~ "_EN" ]]; then
        echo "Skipping $in"
    else
        inkscape -A $in.pdf $in.svg
    fi
    echo $in
done
cp *.pdf ..
