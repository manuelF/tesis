#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys
import numpy as np
sys.path.insert(0, '../comun')
from graphs import *

def texture():
  params =  { #'title': u"Speedup de uso de memorias de textura",
      'xlabel':u"Arquitectura GPU",
      'ylabel':u"Aceleración (en veces)",
      'yvalues':(1.0,1.21,1.38),
      'ylim':(0.0,2.0),
      'ticks':(u'Referencia', u'Fermi', u'Kepler'),
      'filename':"texture.png"}
  barGraph(**params)

def speedupSimple():
  params =  {'title': u"Speedup en multiples M2090 (simple precision)",
      'xlabel':u"Cantidad de placas en un mismo nodo",
      'ylabel':u"Aceleración (en veces)",
      'yvalues':(1.0,1.83,2.6,2.86),
      'ylim':(0.0,4.0),
      'ticks':(u'1 placa', u'2 placas', u'3 placas', u'4 placas'),
      'filename':"4placas-simple.png"}
  barGraph(**params)

def speedupDoble():
  params =  {'title': u"Speedup en multiples M2090 (doble precision)",
      'xlabel':u"Cantidad de placas en un mismo nodo",
      'ylabel':u"Aceleración (en veces)",
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

  params =  {'title': u"Aceleracion de density cambiando el threading",
      'xlabel':u"Arquitecturas GPU",
      'ylabel':u"Aceleración (en veces)",
      'yvalues':measures,
      'ylim':(0.0,3.),
      'ticks':(u'Aceleracion Fermi', u'Aceleracion Kepler'),
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

  params =  {'title': u"Tiempo del computo de density variando el tamaño del bloque",
      'xlabel':u"Tamaño del bloque",
      'ylabel':u"Tiempo del kernel density [us]",
      'yvalues':measures,
      'ylim':(0.0,max(list(measures))*1.1),
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
      'ylabel':u"Aceleracion en veces del kernel density [us]",
      'yvalues':measures,
      'ylim':(0.0,1.2),
      'ticks':(u'Fermi float3 contra float4',
        u'Kepler float3 contra float4',),
      'filename':"shared-4vs3.png"}
  barGraph(**params)

def globalMemory():
#iteration fullereno - giol - 2090 - master
  m2090_gpu0 = 3358165.5555556
  m2090_gpu1 = 2768049.2222222
  m2090_gpu2 = 2824399.3333333
  m2090_gpu3 = 2674648.2222222
  m2090_gpu4 = 2630395.0
  m2090_gpu5 = 2619868.3333333
  m2090_gpu6 = 2690540.5555556
  m2090_gpu7 = 2675686.2222222

  vals = [m2090_gpu0, m2090_gpu1, m2090_gpu2, m2090_gpu3,
      m2090_gpu4, m2090_gpu5, m2090_gpu6, m2090_gpu7]
  measures =  tuple( map((lambda x: (1/x) * (m2090_gpu0)), vals))

  params =  {#'title': u"Speedup del computo de densidad electronica variando el tamaño del cacheo",
      'xlabel':u"Tamaño de la memoria global disponible",
      'ylabel':u"Aceleración (en veces)",
      'yvalues':measures,
      'ylim':(0.8,1.4),
      'ticks':(u'0 Mb',u'530 Mb', u'1060 Mb',u'1590 Mb',
		    u'2650 Mb',u'3180 Mb', u'3710 Mb',u'4240 Mb',),
      'filename':"global-fullereno.png"}
  barGraph(**params)

def globalMemoryDetailed():
#iteration fullereno - giol - 2090 - master
  m2090_gpu0 = 3358165.5555556
  m2090_gpu1e_5 = 3078160.6666667
  m2090_gpu1e_4 = 2909544.8888889
  m2090_gpu1e_3 = 2807708.6666667
  m2090_gpu1e_2 = 2815344.3333333
  m2090_gpu1e_1 = 2768049.2222222

  vals = [m2090_gpu0, m2090_gpu1e_5, m2090_gpu1e_4, m2090_gpu1e_3,
      m2090_gpu1e_2, m2090_gpu1e_1 ]
  measures =  tuple( map((lambda x: (1/x) * (m2090_gpu0)), vals))


  params =  {#'title': u"Aceleracion del computo de densidad electronica variando el tamaño del cacheo",
      'xlabel':u"Tamaño de la memoria global disponible",
      'ylabel':u"Aceleración (en veces)",
      'yvalues':measures,
      'ylim':(0.8,1.4),
      'ticks':(u'0 Mb',u'0.053 Mb', u'0.53 Mb',u'5.3 Mb',
		    u'53 Mb',u'530 Mb'),
      'filename':"global-detailed-fullereno.png"}
  barGraph(**params)

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
      'yvalues':runtimes_partials,
      'xvalues':np.divide(np.cumsum(ordered['size']),1024.**3),
      'ylim' : (0,1),
      'xlim' : (0, 1e8),
      'filename':"global-functions-acc.png"}
  stackGraph(**params)

def predictorSizeInGpu():
#Runtime total por grupo vs sizeingpu en Fullereno 2090 Giol
  fileformat = {'names': ('index','size','rmm','density','functions'),
        'formats' :('uint64','uint64','uint64','uint64','uint64')}
  measures = np.loadtxt("measures/tiempos_frac/fullerenos/size_tiempos", fileformat)
  ordered = np.sort(measures, order='size')
  a_total = ordered['rmm'] + ordered['density'] + ordered['functions']

  params =  {#'title': u"Aceleración del calculo de SCF aplicando todas las optimizaciones",
      'xlabel':u"Tamaño de las matrices del grupo [Mb]",
      'ylabel':u"Runtime de un grupo [ms]",
      'yvalues':np.divide(a_total,1000.),
      'xvalues':np.divide(ordered['size'],1024.**2),
      'ylim' : (1,130),
      'xlim' : (0, 300),
      'ylegend': 'Runtime de un grupo',
      'fitlegend': 'Fit lineal',
      'filename':"sizeingpu-predictor-fullereno.png"}
  scatterGraphFitLineal(**params)

def speedupTotal():
  ref_1x2090 = 5005751
  change_iteration_1x2090 = 909456
  change_iteration_4x2090 = 320102
  measures = (ref_1x2090/ref_1x2090,
      ref_1x2090/change_iteration_1x2090,
      ref_1x2090/change_iteration_4x2090)
  params =  {'title': u"Aceleración del calculo de SCF aplicando todas las optimizaciones",
      'xlabel':u"",
      'ylabel':u"Aceleración (en veces)",
      'yvalues':measures,
      'ylim':(0.0,16),
      'ticks':(u'Referencia Fermi', u'Optimizado Fermi 1 placa', u'Optimizado Fermi 4 placas'),
      'filename':"final.png"}
  barGraph(**params)

def coalescienciaTranspose():
  # Medir runtime antes y despues del transpose
  pass


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
