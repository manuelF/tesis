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


hasScipy = False
try:
  from scipy.interpolate import interp1d
  hasScipy = True
except ImportError:
  pass

try:
  import seaborn as sns
  sns.set_context("paper",font_scale=1.7)
  sns.set_style("ticks", {"font.family": "serif"})
  palette = sns.color_palette()
except ImportError:
  palette = ["b"] * 1000
  pass

import matplotlib as mpl
import matplotlib.pyplot as plt

from matplotlib.patches import Rectangle

import pylab
import numpy as np


def barGraph(xlabel, ylabel, yvalues, ticks, filename, ylim=None, title=u""):
  assert(len(yvalues) == len(ticks))
  N = len(yvalues)
  barLocations = np.arange(N)    # the x locations for the groups
  barWidth = 0.5       # the width of the bars: can also be len(x) sequence
  pylab.title(title)
  pylab.ylabel(ylabel)
  pylab.xlabel(xlabel)
  plt.xticks(np.arange(0.25, N), ticks)
  p1 = plt.bar(barLocations, yvalues, barWidth)
  if ylim:
    plt.ylim(ylim)
  pylab.legend()
  pylab.savefig(filename, bbox_inches='tight')
  pylab.close()

def lineGraph(yvalues, filename,
               xlabel=u"", ylabel=u"", scale=u'linear',xvalues=None,
               ylegend=u'',ticks=None, title=u"", ylim=None, xlim=None):
  if xvalues is None:
    xvalues = range(len(yvalues))
  fig, ax = plt.subplots()

  if type(yvalues) != type([]):
    yvalues = [yvalues]
    ylegend = [ylegend]

  for _yvalues,_ylegend in zip(yvalues,ylegend):
    if hasScipy:
      f = interp1d(xvalues, _yvalues)
      ax.plot(xvalues,_yvalues,'o')
      ax.plot(xvalues,f(xvalues),'-', label=_ylegend)
    else:
      ax.plot(xvalues,_yvalues,'o', label=_ylegend)

  if ticks:
    locs, labels = plt.xticks()
    plt.xticks(locs,ticks)

  if ylim:
      plt.ylim(ylim)
  if xlim:
      plt.xlim(xlim)
  pylab.title(title)
  ax.set_ylabel(ylabel)
  ax.set_xlabel(xlabel)
  pylab.legend(loc='best')
  pylab.savefig(filename, bbox_inches='tight')
  pylab.close()

def stackGraph(xlabel, ylabel, yvalues, filename,
               scale=u'linear',xvalues=None,ylegend=u'',ticks='', title=u""):
  pylab.title(title)
  fig, ax = plt.subplots()
  stack = ax.stackplot(xvalues, yvalues, label=ylegend)
  proxy_rects = [Rectangle((0, 0), 1, 1, fc=pc.get_facecolor()[0]) for pc in stack]
  label_list = [ylegend]
  # make the legend
  ax.legend(proxy_rects, label_list, loc=2)
  ax.set_xscale(scale)
  plt.xlim((0,xvalues[-1]))
  ax.set_ylabel(ylabel)
  ax.set_xlabel(xlabel)
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

def piechart(labels, values, filename, title):
  def my_autopct(val):
    total=sum(values)
    pct = 100.0*(float(val)/float(total))
    val = int(val)
    return '{p:.2f}%  ({v:d}ms)'.format(p=pct,v=val)

  patches, texts = plt.pie(values, labels=labels, startangle=90, labeldistance=1.05, colors=palette)
  edited_labels = [labels[i] +" "+ my_autopct(values[i]) for i in range(len(values))]
  pylab.axis('equal')

  legend = plt.legend(patches, edited_labels,loc='upper center' , bbox_to_anchor=(0.5, -0.05),
                fancybox=True, shadow=True)
  for pie_wedge in patches:
    pie_wedge.set_edgecolor('white')

  pylab.savefig(filename, bbox_inches="tight")
  pylab.close()

def comparisonBarGraph(xlabel, ylabel, xvalues, yvalues, filename, rotation=0):
  pylab.xlabel(xlabel)
  pylab.ylabel(ylabel)
  ticks = range(0,len(xvalues))
  pylab.bar(ticks, yvalues, align="center")
  pylab.xticks(ticks, xvalues, rotation=rotation)
  pylab.legend(loc="best")
  pylab.savefig(filename, bbox_inches="tight")
  pylab.close()

def multiComparativeBarChart(ticks, values, filename, ylabel, width=0.1, rotation=0, loc="best"):
  fig, ax = plt.subplots()
  indexes = np.arange(max(len(v) for u,v in values.items()))
  rects, count = [], 0
  for key, vals in values.items():
      bar = ax.bar(indexes + width * count, vals, width, color=palette[count])
      rects.append(bar)
      count += 1

  ax.set_ylabel(ylabel)
  ax.set_xticks(indexes)
  ax.set_xticklabels(ticks, rotation=rotation)
  ax.legend(rects, values.keys(), loc="best")

  plt.savefig(filename, bbox_inches="tight")
  plt.close()

def initialize():
  mpl.rcParams['savefig.dpi'] = 150

def histogram(xlabel, ylabel, values, nbins, title, filename):
  pylab.hist(values, nbins, histtype="bar",  alpha=0.5)
  pylab.title(title)
  pylab.xlabel(xlabel)
  pylab.ylabel(ylabel)
  pylab.savefig(filename, bbox_inches='tight')
  pylab.close()

def scatter(xlabel, ylabel, filename, xdata, ydata):
  pylab.xlabel(xlabel)
  pylab.ylabel(ylabel)
  pylab.plot(xdata, ydata, "o-")
  pylab.savefig(filename, bbox_inches='tight')
  pylab.close()

def comparativeScatter(xlabel, ylabel, filename, xdata, ydata, label):
  pylab.xlabel(xlabel)
  pylab.ylabel(ylabel)

  for yd, l in zip(ydata, label):
      pylab.plot(xdata, yd, "o-", label=l)
  pylab.legend(loc="best")

  pylab.savefig(filename, bbox_inches="tight")
  pylab.close()

initialize()
