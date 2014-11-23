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
        "ylabel": u"Tiempo de ejecución [s]",
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

if __name__ == '__main__':
    xeon_phi_single_core()
    xeon_phi_single_core_scf()
    xeon_phi_single_core_xc()
