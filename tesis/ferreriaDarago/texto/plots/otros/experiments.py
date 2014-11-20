#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys
import numpy as np
sys.path.insert(0, '../comun')
from graphs import *
import re
def itsPerDia():
#total iter SCF corriendo HEMO
  escala_scf_gpu = 1.24
  # se calcula escalando solo G2G diviendo por 1.86 el runtime
  # y se obtiene el ratio  de los nuevos total iteration
  msec_dia = 24*60*60*1000
  ws_gpu1 = msec_dia / (1331.302)
  ws_gpu2 = msec_dia / (1331.302 / 1.24)
  ws_cpu = msec_dia / (5331.302)
  server_gpu1 = msec_dia/(1111.302)
  server_gpu2 = msec_dia/(1111.302 / 1.24)
  server_cpu = msec_dia/(1300.302)
  measures = [ws_gpu1, ws_gpu2, ws_cpu, server_gpu1, server_gpu2, server_cpu]

  params =  {#'title': u"Speedup del computo de density variando el tamaño de la estructuras",
      'xlabel':u"Configuración",
      'ylabel':u"Iteraciones SCF por día",
      'yvalues':measures,
      'ticks':(u'WS\n1xGPU', u'WS\n2xGPU', u'WS\nCPU',
        u'Server\n1xGPU' , u'Server\n2xGPU',u'Server\nCPU'),
      'filename':"its-dia.png"}
  barGraph(**params)

if __name__ == '__main__':
  itsPerDia()
