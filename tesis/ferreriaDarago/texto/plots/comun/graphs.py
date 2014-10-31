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
  p1 = plt.bar(barLocations, yvalues, barWidth, color='r')
  plt.ylim(ylim)
  pylab.legend()
  pylab.savefig(filename, bbox_inches='tight')
  pylab.close()

def stackGraph(xlabel, ylabel, xvalues, yvalues, filename, xlim, ylim,
               ylegend=u'',ticks='', title=u""):
  pylab.title(title)
  pylab.ylabel(ylabel)
  pylab.xlabel(xlabel)
  p1 = plt.stackplot(xvalues, yvalues, color='r', label=ylegend)
  pylab.legend()
  pylab.savefig(filename, bbox_inches='tight')
  pylab.close()

def scatterGraphFitLineal(xlabel, ylabel, xvalues, yvalues, filename, xlim, ylim,
                          ylegend=u'',fitlegend='u', ticks='', title=u""):
  A = np.vstack([xvalues, np.ones(len(xvalues))]).T
  m, c = np.linalg.lstsq(A, yvalues)[0]
  pylab.title(title)
  pylab.ylabel(ylabel)
  pylab.xlabel(xlabel)
  p1 = plt.scatter(xvalues, yvalues, color='r', label=ylegend)
  plt.plot(xvalues, m*xvalues + c, 'b', label=fitlegend)
  plt.xlim(xlim)
  plt.ylim(ylim)
  pylab.legend(loc=2)
  pylab.savefig(filename, bbox_inches='tight')
  pylab.close()


