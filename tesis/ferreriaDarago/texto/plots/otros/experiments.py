#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys
import numpy as np
sys.path.insert(0, '../comun')
from graphs import *
import re

def itsXCPerDia():
  #total iter XC corriendo HEMO
  escala_xc_gpu = 1.86
  msec_dia = 24*60*60*1000
  ws_gpu1 = msec_dia / (1331.302)
  ws_gpu2 = msec_dia / (1331.302 / escala_xc_gpu)
  ws_cpu = msec_dia / (5331.302)
  server_gpu1 = msec_dia/(522.937)
  server_gpu2 = msec_dia/(522.937 / escala_xc_gpu)
  server_cpu = msec_dia/(846.177)
  measures = [ws_gpu1, ws_gpu2, ws_cpu, server_gpu1, server_gpu2, server_cpu]

  params =  {#'title': u"Speedup del computo de density variando el tamaño de la estructuras",
      'xlabel':u"Configuración",
      'ylabel':u"Iteraciones XC por día",
      'yvalues':measures,
      'ticks':(u'WSxx\n1xGPU', u'WSxx\n2xGPU', u'WSxx\nCPU',
        u'Server\n1xGPU' , u'Server *\n2xGPU',u'Server\nCPU'),
      'filename':"its-xc-dia.png"}
  barGraph(**params)

def itsPerDia():
#total iter SCF corriendo HEMO
  escala_scf_gpu = 1.24
  # se calcula escalando solo G2G diviendo por 1.86 el runtime
  # y se obtiene el ratio  de los nuevos total iteration
  msec_dia = 24*60*60*1000
  ws_gpu1 = msec_dia / (1331.302)
  ws_gpu2 = msec_dia / (1331.302 / escala_scf_gpu)
  ws_cpu = msec_dia / (5331.302)
  server_gpu1 = msec_dia/(1331.302)
  server_gpu2 = msec_dia/(1331.302 / escala_scf_gpu)
  server_cpu = msec_dia/(1541.868)
  measures = [ws_gpu1, ws_gpu2, ws_cpu, server_gpu1, server_gpu2, server_cpu]

  params =  {#'title': u"Speedup del computo de density variando el tamaño de la estructuras",
      'xlabel':u"Configuración",
      'ylabel':u"Iteraciones SCF por día",
      'yvalues':measures,
      'ticks':(u'WSxx\n1xGPU', u'WSxx\n2xGPU', u'WSxx\nCPU',
        u'Server\n1xGPU' , u'Server *\n2xGPU',u'Server\nCPU'),
      'filename':"its-dia.png"}
  barGraph(**params)

def tamParticion():
#Runtime total por grupo vs sizeingpu vs cost en Fullereno k40 cecar
  fileformat = {'names': ('cost','runtimecpu', 'runtimegpu'),
        'formats' :('uint64','uint64','uint64')}
  files = [("measures/tiempos_hemo/size3","cost-time-cpu-gpu-size3.png"),
    ("measures/tiempos_hemo/size7","cost-time-cpu-gpu-size7.png")]
  for f,fname in files:
    measures = np.loadtxt(f, fileformat)
    ordered = np.sort(measures, order='cost')
    indices = np.array(range(1,len(ordered)+1))
    a_cpu = np.cumsum(ordered['runtimecpu'])
    a_gpu = np.cumsum(ordered['runtimegpu'])

    params =  {
        'xlabel':u"Cantidad grupos resueltos",
        'ylabel':u"Runtime acumulado de resolucion de grupos [ms]",
        'yvalues':map((lambda x: np.divide(x,1000.0)),[a_cpu, a_gpu]),
        'xvalues':indices,
        'ylegend': ['Runtime CPU', 'Runtime GPU'],
        'filename':fname}
    lineGraph(**params)


if __name__ == '__main__':
  itsPerDia()
  itsXCPerDia()
  tamParticion()
