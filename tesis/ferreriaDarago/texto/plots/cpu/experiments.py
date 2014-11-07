#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys

import numpy as np
sys.path.insert(0, '../comun')
from graphs import *

def hemo_group_sizes_histogram():
    allfunctions, allpoints, allindexes = [], [], []
    with open("measures/tamanios-cubos-esferas.txt", "r") as rawdata:
        for line in rawdata.readlines():
            _, functions, points, _, _, indexes = line.strip().split(" ")
            allfunctions.append(functions)
            allpoints.append(points)
            allindexes.append(indexes)

    params = {
        'xlabel': u"Funciones por grupo",
        'ylabel': u"Fracción de los grupos",
        'title': u'',
        'nbins': 30,
        'values': [int(f) for f in allfunctions],
        'filename': "histogram-functions-hemo.png"
    }
    histogram(**params)

    params = {
        'xlabel': u"Puntos por grupo",
        'ylabel': u"Fracción de los grupos",
        'title': u'',
        'nbins': 30,
        'values': [int(p) for p in allpoints],
        'filename': "histogram-points-hemo.png"
    }
    histogram(**params)

    params = {
        'xlabel': u"Indices de fock por grupo",
        'ylabel': u"Fracción de los grupos",
        'title': u'',
        'nbins': 30,
        'values': [int(p) for p in allindexes],
        'filename': "histogram-indexes-hemo.png"
    }
    histogram(**params)

if __name__ == '__main__':
    hemo_group_sizes_histogram()
