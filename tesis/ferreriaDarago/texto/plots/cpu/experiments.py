#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys

import numpy as np
sys.path.insert(0, '../comun')
from graphs import *

def hemo_group_sizes_histogram():
    allfunctions, allpoints = [], []
    with open("measures/tamanios-cubos-esferas.txt", "r") as rawdata:
        for line in rawdata.readlines():
            _, functions, points, _, _ = line.strip().split(" ")
            allfunctions.append(functions)
            allpoints.append(points)

    params = {
        'xlabel': u"Rango de funciones por grupo",
        'ylabel': u"Número de grupos",
        'title': "Histograma de la cantidad de funciones para cada grupo",
        'nbins': 30,
        'values': [int(f) for f in allfunctions],
        'filename': "histogram-functions-hemo.png"
    }
    histogram(**params)

    params = {
        'xlabel': u"Rango de puntos por grupo",
        'ylabel': u"Número de grupos",
        'title': "Histograma de la cantidad de puntos para cada grupo",
        'nbins': 30,
        'values': [int(p) for p in allpoints],
        'filename': "histogram-points-hemo.png"
    }
    histogram(**params)


if __name__ == '__main__':
    hemo_group_sizes_histogram()
