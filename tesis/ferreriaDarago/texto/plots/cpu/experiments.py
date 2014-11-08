#!/usr/bin/env python
# -*- coding: utf-8 -*-
import re
import sys

import numpy as np
sys.path.insert(0, '../comun')
from graphs import *

def time2micros(s):
    return int(re.search("(\d+)us.",s).group(1))

def plot_cost_function():
    with open("measures/times-for-groups.txt") as f:
        data = []
        for line in f.readlines():
            pieces = line.split()

            keys = [pieces[i] for i in xrange(0,len(pieces),2)]
            vals = [pieces[i] for i in xrange(1,len(pieces),2)]

            data.append(dict(zip(keys,vals)))

        for key in ['size_in_gpu', 'cost']:
            xvals,yvals = zip(*[(int(v[key]), time2micros(v['times']) / 1000.0) for v in data])
            params = {
                'xlabel': u"Costo basado en funcion %s" % key,
                'ylabel': u"Runtime de un grupo [ms]",
                'xvalues': np.array(xvals),
                'yvalues': np.array(yvals),
                'ylegend': 'Runtime de un grupo',
                'fitlegend': 'Fit Lineal',
                'filename': "fit-func-%s.png" % key
            }
            scatterGraphFitLineal(**params)

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

def reduce_summing_matrix_plot():
    threads, measures = [],[]
    with open("./measures/experimento-reducir-matrices.txt") as f:
        for line in f.readlines():
            t, m = line.strip().split(" ")
            threads.append(int(t))
            measures.append(float(m))

    params = {
        'xlabel': u"Cantidad de threads utilizados",
        'ylabel': u"Tiempo tomado en las reducciones [s]",
        'xvalues': np.array(threads),
        'yvalues': np.array(measures),
        'ylegend': u'Costo en segundos',
        'filename': u'scalability-matrix-sums.png',
        'ylim': (0.14,0.2),
    }

    lineGraph(**params)

if __name__ == '__main__':
    hemo_group_sizes_histogram()
    plot_cost_function()
    reduce_summing_matrix_plot()
