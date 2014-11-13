#!/usr/bin/env python
# -*- coding: utf-8 -*-
import re
import sys

import numpy as np
sys.path.insert(0, '../comun')
from graphs import *

MSEC = 1000000.0
def time2secs(s):
    sec,msec = re.search("(?:(\d+)s. )?(\d+)", s).groups()
    return float(sec) + float(msec) / MSEC

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
        'ylim': (0.17,0.23),
    }

    lineGraph(**params)

def comparison_in_times(l):
    return [v / min(l) for v in l]

def post_matrix_splits():
    post = time2secs("15s. 200498us.")
    pre = time2secs("31s. 680109us.")

    params = {
        'xlabel': u"Resultados para proyección de matrices en componentes",
        'ylabel': u"Tiempo por iteración en veces",
        'xvalues': ['Pre-optimizacion', 'Post-optimizacion'],
        'yvalues': comparison_in_times([pre,post]),
        'filename': u'post-split-matrices.png',
    }
    comparisonBarGraph(**params)

def post_caching_matrices():
    post = time2secs("11s. 834914us.")
    pre = time2secs("15s. 200498us.")

    params = {
        'xlabel': u"Resultados para cacheo de matrices iniciales",
        'ylabel': u"Tiempo por iteración en veces",
        'xvalues': ['Pre-optimizacion', 'Post-optimizacion'],
        'yvalues': comparison_in_times([pre,post]),
        'filename': u'post-cachear-matrices.png',
    }
    comparisonBarGraph(**params)

def post_aligning_matrices():
    post = time2secs("11s. 834914us.")
    pre = time2secs("11s. 667524us.")

    params = {
        'xlabel': u"Resultados para alineacion de matrices iniciales",
        'ylabel': u"Speedup de la iteración en veces",
        'xvalues': ['Pre-optimización', 'Post-optimización'],
        'yvalues': comparison_in_times([pre,post]),
        'filename': u'post-alinear-matrices.png',
    }
    comparisonBarGraph(**params)

def escalabilidad_final():
    for exp in ["hemoglobina","caroteno", "fullereno"]:
        with open("measures/escalabilidad-%s.txt" % exp) as f:
            pylab.xlabel("Cantidad de threads")
            pylab.ylabel("Speedup en veces")
            pylab.title("Prueba de escalabilidad para %s" % exp)

            lines = [v.split(" ") for v in f.readlines()]
            data = [(int(u), float(v)) for u,v in lines]
            threads, speedups = zip(*data)

            pylab.plot(threads, speedups,"o-", label="Experimental")
            pylab.plot(threads, threads, "o-", label="Obtenido")
            pylab.legend(loc="best")

            pylab.savefig( "escalabilidad-%s.png" % exp)
            pylab.close()

def diferencias_de_grupos_por_split():
    timesstr = [
        "271622us.",
        "274914us.",
        "275384us.",
        "275467us.",
        "276620us.",
        "283192us.",
        "284217us.",
        "290966us.",
        "294136us.",
        "301388us.",
        "306992us.",
        "314068us.",
    ]

    times = comparison_in_times([time2micros(t)*1.0 for t in timesstr])
    params = {
        'xlabel': u'Grupo de trabajo',
        'ylabel': u'Tiempo en veces',
        'xvalues': ["%d" % t for t in range(1,len(times)+1)],
        'yvalues': times,
        'filename': u'group-split-differences.png',
    }
    comparisonBarGraph(**params)

def diferencias_de_grupos_balanceadas():
    timesstr = [
        "241149us.",
        "242012us.",
        "241986us.",
        "239921us.",
        "242605us.",
        "243379us.",
        "243551us.",
        "243860us.",
        "245598us.",
        "246323us.",
        "249045us.",
        "251391us.",
    ]

    times = comparison_in_times([time2micros(t)*1.0 for t in timesstr])
    params = {
        'xlabel': u'Grupo de trabajo',
        'ylabel': u'Tiempo en veces',
        'xvalues': ["%d" % t for t in range(1,len(times)+1)],
        'yvalues': times,
        'filename': u'group-split-differences-post-balance.png',
    }
    comparisonBarGraph(**params)

def amdahl(B, n):
    return 1.0 / ((1-B) + (1.0 / n) * B)

def amdahl_plot():
    xs = np.arange(1, 101, 1)

    percentages = [0.9, 0.95, 0.99]

    pointstyle = ["-","o","+", "."]
    for i,p in enumerate(percentages):
        pylab.plot(xs, amdahl(p, xs), label="%d%% paralelo" % int(100.0 * p))

    pylab.legend(loc="upper left")
    pylab.xlabel(u"Cantidad de núcleos")
    pylab.ylabel("Speedup (en veces)")
    pylab.savefig("./amdahl.png", bbox_inches="tight")
    pylab.close()

if __name__ == '__main__':
    hemo_group_sizes_histogram()
    plot_cost_function()
    reduce_summing_matrix_plot()
    amdahl_plot()
    post_matrix_splits()
    post_caching_matrices()
    post_aligning_matrices()
    escalabilidad_final()
    diferencias_de_grupos_por_split()
    diferencias_de_grupos_balanceadas()
