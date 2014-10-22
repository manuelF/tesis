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

if __name__ == '__main__':
  texture()
  speedupSimple()
  speedupDoble()
