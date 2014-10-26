#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys
sys.path.insert(0, '../comun')
from graphs import *

def texture():
  params =  {'title': u"Speedup de uso de memorias de textura",
      'xlabel':u"Arquitectura GPU",
      'ylabel':u"Aceleración (en veces)",
      'values':(1.0,1.21,1.38),
      'ticks':(u'Referencia', u'Fermi', u'Kepler'),
      'filename':"texture.png"}
  barGraph(**params)

def speedupSimple():
  params =  {'title': u"Speedup en multiples M2090 (simple precision)",
      'xlabel':u"Cantidad de placas en un mismo nodo",
      'ylabel':u"Aceleración (en veces)",
      'values':(1.0,1.83,2.6,2.86),
      'ticks':(u'1 placa', u'2 placas', u'3 placas', u'4 placas'),
      'filename':"4placas-simple.png"}
  barGraph(**params)

def speedupDoble():
  params =  {'title': u"Speedup en multiples M2090 (doble precision)",
      'xlabel':u"Cantidad de placas en un mismo nodo",
      'ylabel':u"Aceleración (en veces)",
      'values':(1.0,2.03,2.92,3.8),
      'ticks':(u'1 placa', u'2 placas', u'3 placas', u'4 placas'),
      'filename':"4placas-doble.png"}
  barGraph(**params)

def threading():
  ref_m2090 = 3915307.0
  change_m2090 = 3077739.0
  ref_kepler = 4358695.0
  change_kepler = 1929594.0
  measures = (ref_m2090/ref_m2090, ref_m2090/change_m2090,
      ref_kepler/ref_kepler, ref_kepler/change_kepler)

  params =  {'title': u"Speedup de density cambiando el threading",
      'xlabel':u"Arquitecturas GPU",
      'ylabel':u"Aceleración (en veces)",
      'values':measures,
      'ticks':(u'Referencia Fermi', u'Optimizado Fermi',
        u'Referencia Kepler', u'Optimizado Kepler'),
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
      'values':measures,
      'ticks':(u'Fermi DBS 32', u'Fermi DBS 64',u'Fermi DBS 128',
         u'Kepler DBS 32', u'Kepler DBS 64',u'Keploer DBS 128',),
      'filename':"dbs.png"}
  barGraph(**params)

def shared4vs3():
  m2090_shared3 = 638061.0
  m2090_shared4 = 631758.0

  k40_shared3 = 401664.0
  k40_shared4 = 423654.0

  measures = (m2090_shared4/m2090_shared3, k40_shared4/k40_shared3)

  params =  {'title': u"Speedup del computo de density variando el tamaño de la estructuras",
      'xlabel':u"Tamaño de los elementos en la shared",
      'ylabel':u"Aceleracion en veces del kernel density [us]",
      'values':measures,
      'ticks':(u'Fermi float3 contra float4',
        u'Kepler float3 contra float4',),
      'filename':"shared-4vs3.png"}
  barGraph(**params)

def globalMemory():
#iteration fullereno
  m2090_gpu0 = 3241784.483871
  m2090_gpu1 = 2775760.1935484
  m2090_gpu2 = 2688267.2580645
  m2090_gpu3 = 2745970.8709677
  m2090_gpu4 = 2742110.2903226
  m2090_gpu5 = 2710770.3870968
  m2090_gpu6 = 2722721.9677419
  m2090_gpu7 = 2653487.0
  
  measures = (m2090_gpu0/m2090_gpu0, 
    m2090_gpu0/m2090_gpu1,m2090_gpu0/m2090_gpu2,
    m2090_gpu0/m2090_gpu3,m2090_gpu0/m2090_gpu4,
    m2090_gpu0/m2090_gpu5,m2090_gpu0/m2090_gpu6,
    m2090_gpu0/m2090_gpu7)

  params =  {'title': u"Speedup del computo de densidad electronica variando el tamaño del cacheo",
      'xlabel':u"Tamaño de la memoria global disponible",
      'ylabel':u"Aceleración (en veces)",
      'values':measures,
      'ticks':(u'0 Mb',u'530 Mb', u'1060 Mb',u'1590 Mb',
		    u'2650 Mb',u'3180 Mb', u'3710 Mb',u'4240 Mb',),
      'filename':"global-fullereno.png"}
  barGraph(**params)

def speedupTotal():
  ref_1x2090 = 5005751
  change_iteration_1x2090 = 909456
  change_iteration_4x2090 = 320102
  measures = (ref_1x2090/ref_1x2090,
      ref_1x2090/change_iteration_1x2090,
      ref_1x2090/change_iteration_4x2090)
  print measures
  params =  {'title': u"Speedup del calculo de SCF aplicando todas las optimizaciones",
      'xlabel':u"Arquitecturas GPU",
      'ylabel':u"Aceleración (en veces)",
      'values':measures,
      'ticks':(u'Referencia Fermi', u'Optimizado Fermi 1 placa', u'Optimizado Fermi 4 placas'),
      'filename':"final.png"}
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
