#!/usr/bin/env python
# -*- coding: utf-8 -*-
##
## Ejemplo de uso
##
##from graphs import *
##
##params =  {'title': u"Speedup de uso de memorias de textura",
##    'xlabel':u"Arquitectura GPU",
##    'ylabel':u"Aceleración (en veces)",
##    'values':(1.0,1.21,1.38),
##    'ticks':(u'Referencia', u'Fermi', u'Kepler'),
##    'filename':"texture.png"}
##barGraph(**params)

import matplotlib as mpl
import matplotlib.pyplot as plt

import pylab
import numpy as np


def barGraph(xlabel, ylabel, yvalues, ticks, ylim, filename, title=u""):
  assert(len(yvalues) == len(ticks))
  N = len(yvalues)
  barLocations = np.arange(N)    # the x locations for the groups
  barWidth = 0.5       # the width of the bars: can also be len(x) sequence
  pylab.title(title)
  pylab.ylabel(ylabel)
  pylab.xlabel(xlabel)
  plt.xticks(np.arange(0.25, N), ticks)
  p1 = plt.bar(barLocations, yvalues, barWidth)
  plt.ylim(ylim)
  pylab.legend()
  pylab.savefig(filename, bbox_inches='tight')
  pylab.close()

def lineGraph(xlabel, ylabel, yvalues, filename,
               scale=u'linear',xvalues=None,ylegend=u'',ticks=None, title=u""):
  pylab.title(title)
  pylab.ylabel(ylabel)
  pylab.xlabel(xlabel)
  fig, ax = plt.subplots()
  base = range(len(yvalues))
  fig, ax = plt.subplots()
  if hasScipy:
    f = interp1d(base, yvalues)
    ax.plot(base,yvalues,'o',base,f(base),'-.', label=ylegend)
  else:
    ax.plot(base,yvalues,'o', label=ylegend)
  if ticks:
    locs, labels = plt.xticks()
    plt.xticks(locs,ticks)

  pylab.legend(loc='best')
  pylab.savefig(filename, bbox_inches='tight')
  pylab.close()

def stackGraph(xlabel, ylabel, yvalues, filename,
               scale=u'linear',xvalues=None,ylegend=u'',ticks='', title=u""):
  pylab.title(title)
  pylab.ylabel(ylabel)
  pylab.xlabel(xlabel)
  fig, ax = plt.subplots()
  ax.stackplot(xvalues, yvalues, label=ylegend)
  ax.set_xscale(scale)
  pylab.legend(loc='best')
  pylab.savefig(filename, bbox_inches='tight')
  pylab.close()

def scatterGraphFitLineal(xlabel, ylabel, xvalues, yvalues, filename,
                          ylegend=u'',fitlegend='u', ticks='', title=u""):
  A = np.vstack([xvalues, np.ones(len(xvalues))]).T
  m, c = np.linalg.lstsq(A, yvalues)[0]
  pylab.title(title)
  pylab.ylabel(ylabel)
  pylab.xlabel(xlabel)
  p1 = plt.scatter(xvalues, yvalues, label=ylegend)
  plt.plot(xvalues, m*xvalues + c,  label=fitlegend)
  plt.xlim((0, max(xvalues)*1.1))
  plt.ylim((0, max(yvalues)*1.1))
  pylab.legend(loc='best')
  pylab.savefig(filename, bbox_inches='tight')
  pylab.close()

def initialize():
  mpl.rcParams['savefig.dpi'] = 150

def histogram(xlabel, ylabel, values, nbins, title, filename):
  pylab.hist(values, nbins, histtype="bar", normed=1, alpha=0.5)
  pylab.title(title)
  pylab.xlabel(xlabel)
  pylab.ylabel(ylabel)
  pylab.savefig(filename, bbox_inches='tight')
  pylab.close()

hasScipy = False
try:
  from scipy.interpolate import interp1d
  hasScipy = True
except ImportError:
  pass

try:
  import seaborn as sns
  sns.set_context("paper",font_scale=1.7)
except ImportError:
  pass
initialize()
