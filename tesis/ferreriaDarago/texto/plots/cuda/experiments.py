#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys
import numpy as np
sys.path.insert(0, '../comun')
from graphs import *

def lineGraphConOtroEje(xlabel, ylabel, yvalues, filename,
               ylim=None,scale=u'linear',xvalues=None,ylegend=u'',ticks=None, title=u""):
  pylab.title(title)
  pylab.ylabel(ylabel)
  pylab.xlabel(xlabel)
  fig, ax = plt.subplots()
  base = range(len(yvalues))
  ax.plot(base,yvalues,"o")
  if hasScipy:
    f = interp1d(base, yvalues)
    ax.plot(base,f(base),"-",label=ylegend)
  if ticks:
    locs, labels = plt.xticks()
    plt.xticks(locs,ticks)
  if ylim:
    plt.ylim(ylim)

  pylab.legend(loc='best')
  pylab.savefig(filename, bbox_inches='tight')
  pylab.close()



def texture():
#hemo k40 2075 solo density
  ref_c2075 = 1153238.9
  change_c2075 = 1072045.1836735
  ref_kepler = 733393.46
  change_kepler = 599249.48979592
  measures = (ref_c2075/change_c2075,
      ref_kepler/change_kepler)

  params =  { #'title': u"Speedup de uso de memorias de textura",
      'xlabel':u"Arquitectura GPU",
      'ylabel':u"Aceleración del kernel density (en veces)",
      'yvalues':measures,
      'ylim':(1.0,1.3),
      'ticks':(u'Mejora Textura (Fermi)', u'Mejora Textura (Kepler)'),
      'filename':"texture.png"}
  barGraph(**params)

def speedupSimple():
  params =  {#'title': u"Speedup en multiples M2090 (simple precision)",
      'xlabel':u"Cantidad de placas en un mismo nodo",
      'ylabel':u"Aceleración de una iteración de SCF (en veces)",
      'yvalues':(1.0,1.83,2.6,2.86),
      'ylim':(0.0,4.0),
      'ticks':(u'1 placa', u'2 placas', u'3 placas', u'4 placas'),
      'filename':"4placas-simple.png"}
  barGraph(**params)

def speedupDoble():
  params =  {#'title': u"Speedup en multiples M2090 (doble precision)",
      'xlabel':u"Cantidad de placas en un mismo nodo",
      'ylabel':u"Aceleración de una iteración de SCF (en veces)",
      'yvalues':(1.0,2.03,2.92,3.8),
      'ylim':(0.0,4.0),
      'ticks':(u'1 placa', u'2 placas', u'3 placas', u'4 placas'),
      'filename':"4placas-doble.png"}
  barGraph(**params)

def threading():
  ref_m2090 = 3915307.0
  change_m2090 = 3077739.0
  ref_kepler = 4358695.0
  change_kepler = 1929594.0
  measures = (ref_m2090/change_m2090,
      ref_kepler/change_kepler)

  params =  {#'title': u"Aceleracion de density cambiando el threading",
      'xlabel':u"Arquitecturas GPU",
      'ylabel':u"Aceleración del kernel density (en veces)",
      'yvalues':measures,
      'ylim':(1.0,2.5),
      'ticks':(u'Mejora Threading (Fermi)', u'Mejora Threading (Kepler)'),
      'filename':"threading.png"}
  barGraph(**params)

def variandoDBS():
  m2090_32 =1113661.0
  m2090_64 =638061.0
  m2090_128 =849679.0

  k40_32 = 579138.0
  k40_64 = 401664.0
  k40_128 = 494509.0

  measures = (m2090_32, m2090_64, m2090_128,
    k40_32, k40_64, k40_128)

  params =  {#'title': u"Tiempo del computo de density variando el tamaño del bloque",
      'xlabel':u"Tamaño del bloque",
      'ylabel':u"Tiempo del kernel density [ms]",
      'yvalues':np.divide(measures,1000),
      'ylim':(0.0,max(list(measures))*0.001),
      'ticks':(u'Fermi 32', u'Fermi 64',u'Fermi 128',
         u'Kepler 32', u'Kepler 64',u'Kepler 128',),
      'filename':"dbs.png"}
  barGraph(**params)

def shared4vs3():
  m2090_shared3 = 638061.0
  m2090_shared4 = 631758.0

  k40_shared3 = 401664.0
  k40_shared4 = 423654.0

  measures = (m2090_shared4/m2090_shared3, k40_shared4/k40_shared3)

  params =  {#'title': u"Speedup del computo de density variando el tamaño de la estructuras",
      'xlabel':u"Tamaño de los elementos en la shared",
      'ylabel':u"Aceleracion del kernel density (en veces)",
      'yvalues':measures,
      'ylim':(0.0,1.2),
      'ticks':(u'float3 v. float4 (Fermi)',
        u'float3 v. float4 (Kepler)',),
      'filename':"shared-4vs3.png"}
  barGraph(**params)

def globalMemory():
#iteration fullereno - giol - 2090 - master

  m2090_gpu0 = 3310800
  m2090_gpu1 = 2807270
  m2090_gpu2 = 2806877
  m2090_gpu3 = 2785507
  m2090_gpu4 = 2791127
  m2090_gpu5 = 2742317
  m2090_gpu6 = 2739543
  m2090_gpu7 = 2694980

  vals = map(float,[m2090_gpu0, m2090_gpu1, m2090_gpu2, m2090_gpu3,
      m2090_gpu4, m2090_gpu5, m2090_gpu6, m2090_gpu7])
  measures =  tuple( map((lambda x: (1/x) * (m2090_gpu0)), vals))

  params =  {#'title': u"Speedup del computo de densidad electronica variando el tamaño del cacheo",
 #     'xlabel':u"Tamaño de la memoria global disponible [Mb]",
 #     'ylabel':u"Aceleración (en veces)",
      'yvalues':measures,
      'ylegend':'Aceleracion SCF',
      'ticks':(u'0',u'530', u'1060',u'1590',
		    u'2650',u'3180', u'3710',u'4240',),
      'ylim':(1,1.25),
      'filename':"global-fullereno.png"}
  lineGraph(**params)

def globalMemoryDetailed():
#iteration fullereno - giol - 2090 - master
  m2090_gpu0 = 3310800
  m2090_gpu1e_5 = 3067842
  m2090_gpu1e_4 = 2987461
  m2090_gpu1e_3 = 2832157
  m2090_gpu1e_2 = 2835134
  m2090_gpu1e_1 = 2807270

  vals = map(float, [m2090_gpu0, m2090_gpu1e_5, m2090_gpu1e_4, m2090_gpu1e_3,
      m2090_gpu1e_2, m2090_gpu1e_1 ])
  measures =  ( map((lambda x: (1/x) * (m2090_gpu0)), vals))


  params =  {#'title': u"Aceleracion del computo de densidad electronica variando el tamaño del cacheo",
      'xlabel':u"Tamaño de la memoria global disponible [Mb]",
      'ylabel':u"Aceleración de SCF (en veces)",
      'yvalues':measures,
      'ticks':(u'0',u'0.053', u'0.53',u'5.3',u'53',u'530'),
      'xvalues':np.concatenate(([0],(10**np.array(range(5)))*53/(1000.**1))),
      'ylegend':'Aceleracion SCF',
      'ylim':(1,1.25),
      'filename':"global-detailed-fullereno.png"}
  lineGraphConOtroEje(**params)

def acumuladoGlobalMemory():
#Acumulando los runtimes de funciones en Fullereno 2090 Giol
  fileformat = {'names': ('index','size','rmm','density','functions'),
        'formats' :('uint64','uint64','uint64','uint64','uint64')}
  measures = np.loadtxt("measures/tiempos_frac/fullerenos/size_tiempos", fileformat)
  ordered = np.sort(measures, order='size')
  runtimes_partials = np.cumsum(np.divide((ordered['functions']),
      np.float(np.sum(ordered['functions']))))

  params =  {#'title': u"Aceleración del calculo de SCF aplicando todas las optimizaciones",
      'xlabel':u"Tamaño de las matrices acumuladas [Gb]",
      'ylabel':u"Fracción del tiempo acumulado",
      'ylegend':u"Fracción del tiempo acumulado",
      'yvalues':runtimes_partials,
      'xvalues':np.divide(np.cumsum(ordered['size']),1024.**3),
      'filename':"global-functions-acc.png"}
  stackGraph(**params)

def predictorSizeInGpu():
#Runtime total por grupo vs sizeingpu vs cost en Fullereno k40 cecar
  fileformat = {'names': ('index','size','cost','runtime'),
        'formats' :('uint64','uint64','uint64','uint64')}
  files = [("measures/tiempos_frac_costos/fullereno/index_size_cost_tiempo","sizeingpu-predictor-fullereno.png","cost-predictor-fullereno.png"),
      ("measures/tiempos_frac_costos/hemo/index_size_cost_tiempo","sizeingpu-predictor-hemo.png","cost-predicto-hemo.png"),
      ("measures/tiempos_frac_costos/caroteno/index_size_cost_tiempo","sizeingpu-predictor-caroteno.png","cost-predictor-caroteno.png")]
  for f,fsizename,fcostname in files:
    measures = np.loadtxt(f, fileformat)
    ordered = np.sort(measures, order='size')
    a_total = ordered['runtime']

    params =  {#'title': u"Aceleración del calculo de SCF aplicando todas las optimizaciones",
        'xlabel':u"Tamaño de las matrices del grupo [Mb]",
        'ylabel':u"Runtime de un grupo [ms]",
        'yvalues':np.divide(a_total,1000.),
        'xvalues':np.divide(ordered['size'],1024.**2),
        'ylegend': 'Runtime de un grupo',
        'fitlegend': 'Fit lineal',
        'filename':fsizename}
    scatterGraphFitLineal(**params)
    params['xlabel'] = u"Estimado de costo computacional"
    params['xvalues'] = ordered['cost']
    params['filename'] = fcostname
    scatterGraphFitLineal(**params)


def speedupTotal():
  ref_1x2090 = 5005751
  change_iteration_1x2090 = 909456
  change_iteration_4x2090 = 320102
  measures = (#ref_1x2090/ref_1x2090,
      ref_1x2090/change_iteration_1x2090,
      ref_1x2090/change_iteration_4x2090)
  params =  {#'title': u"Aceleración del calculo de SCF aplicando todas las optimizaciones",
      'xlabel':u"",
      'ylabel':u"Aceleración de una iteración de SCF (en veces)",
      'yvalues':measures,
      'ylim':(1.0,16.0),
      'ticks':(#u'Referencia Fermi',
        u'Optimizado Fermi 1 placa', u'Optimizado Fermi 4 placas'),
      'filename':"final.png"}
  barGraph(**params)

def coalescienciaTranspose():
  #runtime density cecar hemo k40 c2075
  c2075_sin_transpose = 1030980.5102041
  c2075_con_transpose = 761192.87755102

  k40_sin_transpose = 467947.62
  k40_con_transpose = 372734.08

  measures = (c2075_sin_transpose/c2075_con_transpose, k40_sin_transpose/k40_con_transpose)

  params =  {#'title': u"Speedup del computo de density variando el tamaño de la estructuras",
      'xlabel':u"Arquitectura GPU",
      'ylabel':u"Aceleración del kernel density (en veces)",
      'yvalues':measures,
      'ylim':(1.0,1.5),
      'ticks':(u'Mejora Transpose (Fermi)', u'Mejora Transpose (Kepler)'),
      'filename':"transpose.png"}
  barGraph(**params)




if __name__ == '__main__':
  threading()
  texture()
  speedupSimple()
  speedupDoble()
  speedupTotal()
  variandoDBS()
  shared4vs3()
  globalMemory()
  globalMemoryDetailed()
  acumuladoGlobalMemory()
  predictorSizeInGpu()
  coalescienciaTranspose()
