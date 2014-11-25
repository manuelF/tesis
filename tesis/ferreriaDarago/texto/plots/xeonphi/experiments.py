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
    sec = sec or 0
    return float(sec) + float(msec) / MSEC

def time2milis(s):
    sec,msec = re.search("(?:(\d+)s. )?(\d+)", s).groups()
    sec = sec or 0
    return float(sec) * 1000.0 + float(msec) / 1000.0

def time2micros(s):
    return int(re.search("(\d+)us.",s).group(1))

def xeon_phi_single_core():
    weightsxeonphi = time2secs("115s. 987856us")
    weightsxeon = time2secs("7s. 906529us")

    functionsxeonphi = time2secs("32s. 804570us")
    functionsxeon = time2secs("2s. 827386us")

    iteracionxeon = time2secs("10s. 704472us")
    iteracionxeonphi = time2secs("87s. 112224us.")

    labels = [u"Cálculo de pesos", u"Cálculo de funciones", u"Iteración SCF"]
    comparison = {
        u"Xeon": [weightsxeon, functionsxeon, iteracionxeon ],
        u"Xeon Phi": [weightsxeonphi, functionsxeonphi, iteracionxeonphi],
    }

    params = {
        'values': comparison,
        'ticks': labels,
        'filename': u'xeon-xeon-phi-broad-comparison.png',
        'ylabel': u'Tiempo de ejecución [s]',
    }

    multiComparativeBarChart(**params)

def xeon_phi_single_core_scf():
    actualizarmm = ("2s. 620039us", "391261us")
    diis = ("187764us", "29896us")
    dspev = ("1s. 793845us", "160380us")
    coeff = ("1s. 615567us", "207950us")
    otrascosas = ("172114us", "14301us")
    preint3lu = ("260750us", "78862us")
    int3lu = ("258935us", "77279us")

    labels = [ u"Actualiza RMM", u"DIIS", u"DSPEV", u"COEFF", u"Pre int3lu", u"int3lu", u"Otros"]
    values = [ actualizarmm, diis, dspev, coeff, preint3lu, int3lu, otrascosas ]
    comparison = {
        u"Xeon": [time2milis(v[1]) for v in values],
        u"Xeon Phi": [time2milis(v[0]) for v in values]
    }

    params = {
        "values": comparison,
        "ticks": labels,
        "filename": u'xeon-xeon-phi-broad-comparison-scf.png',
        "ylabel": u"Tiempo de ejecución [ms]",
        "rotation": 20,
    }

    multiComparativeBarChart(**params)

def xeon_phi_single_core_xc():
    densityxeon = time2secs("95307") + time2secs("8s. 103455")
    rmmxeon = time2secs("15462") + time2secs("1s. 566310")

    densityxeonphi = time2secs("70s. 87924") + time2secs("103819")
    rmmxeonphi = time2secs("18140") + time2secs("8s. 27276")

    labels = [u"Cálculo densidad", u"Cálculo matrix KS"]
    comparison = {
        u"Xeon": [ densityxeon, rmmxeon ],
        u"Xeon Phi": [ densityxeonphi, rmmxeonphi ],
    }

    params = {
        'values': comparison,
        'ticks': labels,
        'filename': u'xeon-xeon-phi-broad-comparison-xc.png',
        'ylabel': u'Tiempo de ejecución [s]',
    }

    multiComparativeBarChart(**params)

def xeon_phi_partition_theoretical():
    values = []
    with open("particion-teorico.txt") as f:
        for line in f.readlines():
            values.append(int(line))

    params = {
        'yvalues': [min(values), max(values)],
        'xvalues': [u"Mínima carga", u"Máxima carga"],
        'xlabel': u"Comparación costos para cargas",
        'filename': u'xeon-phi-partition-balance-theoretical.png',
        'ylabel': u'Costo predicho para la carga',
    }

    comparisonBarGraph(**params)

def xeon_phi_partition_empirical():
    values = []
    with open("particion-experimental.txt") as f:
        for line in f.readlines():
            values.append(time2secs(line))

    params = {
        'yvalues': [min(values), max(values)],
        'xvalues': [u"Mínima carga", u"Máxima carga"],
        'xlabel': u"Comparación tiempos para cargas",
        'filename': u'xeon-phi-partition-balance-empirical.png',
        'ylabel': u'Tiempo de iteracion para carga [s]'
    }

    comparisonBarGraph(**params)

def xeon_phi_cost_function():
    with open("xeon-phi-costs.txt", "r") as f:
        costs, times = [], []
        seen = set()
        for line in f.readlines():
            pieces = line.split(" ")
            grouptype, number, cost, timestr = pieces[0],pieces[1],pieces[2]," ".join(pieces[3:])
            group = grouptype + " " + number
            if group not in seen:
                costs.append(float(cost))
                times.append(time2milis(timestr))
                seen.add(group)

        params = {
            'xlabel': u"Costo predicho",
            'ylabel': u"Runtime de un grupo [ms]",
            'xvalues': np.array(costs),
            'yvalues': np.array(times),
            'ylegend': u"Runtime de un grupo",
            'fitlegend': 'Fit lineal',
            'filename': 'cost-fit-xeon-phi.png',
        }

        scatterGraphFitLineal(**params)

def xeon_phi_scalability():
    vals = []
    with open("measures/escalabilidad-xeon-phi.txt") as f:
        for line in f.readlines():
            threadc, timestr = line.split("-")
            vals.append((int(threadc), time2secs(timestr)))

    vals = sorted(vals)
    threads, vals = zip(*vals)

    params = {
        'xlabel': "Cantidad de threads",
        'ylabel': "Speedup en veces",
        'xdata': threads,
        'ydata1': [max(vals) / v for v in vals],
        'ydata2': [t for t in threads],
        'label1': 'Experimental',
        'label2': 'Ideal',
        'filename': 'escalabilidad-xeon-phi.png',
    }
    comparativeScatter(**params)

def xeon_phi_enditer():
    vals = []
    with open("measures/enditer-xeon-phi.txt") as f:
        for line in f.readlines():
            threadc, timestr = line.split("-")
            vals.append((int(threadc), time2milis(timestr)))

    threads,vals = zip(*sorted(vals))

    params = {
        'xlabel': u'Cantidad de threads',
        'ylabel': u'Tiempo de reducción post iteración [ms]',
        'xdata': threads,
        'ydata': vals,
        'filename': 'enditer-xeon-phi.png'
    }

    scatter(**params)

def xeon_xeon_phi_final_comparison():
    xeon = time2milis("842375us.")
    xeonphi = time2milis("1s. 309920us.")
    params = {
        'yvalues': [xeon, xeonphi],
        'xvalues': [u"Xeon", u"Xeon Phi"],
        'xlabel': u"Arquitectura",
        'filename': u'xeon-xeon-phi-scale-comparison.png',
        'ylabel': u'Tiempo por iteracion [ms]',
    }

    comparisonBarGraph(**params)

if __name__ == '__main__':
    xeon_phi_single_core()
    xeon_phi_single_core_scf()
    xeon_phi_single_core_xc()
    xeon_phi_partition_theoretical()
    xeon_phi_partition_empirical()
    xeon_phi_cost_function()
    xeon_phi_scalability()
    xeon_phi_enditer()
    xeon_xeon_phi_final_comparison()
