#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys
import numpy as np
sys.path.insert(0, '../comun')
from graphs import *
import re

def itsXCPerDiaDouble():
  #total iter XC corriendo HEMO
  escala_xc_gpu = 1.95
  msec_dia = 24*60*60*1000
  ws_gpu1 = msec_dia / (2031.302)
  ws_gpu2 = msec_dia / (1022.369)
  ws_cpu = msec_dia / (2334.252)
  server_gpu1 = msec_dia/(808.937)
  server_gpu2 = msec_dia/(808.937 / escala_xc_gpu)
  server_cpu = msec_dia/(1340.147)
  measures = [ws_gpu1, ws_gpu2, ws_cpu, server_gpu1, server_gpu2, server_cpu]

  params =  {#'title': u"Speedup del computo de density variando el tamaño de la estructuras",
      'xlabel':u"Configuración",
      'ylabel':u"Iteraciones XC por día",
      'yvalues':measures,
      'ticks':(u'WS\n1xGPU', u'WS\n2xGPU', u'WS\nCPU',
        u'Server\n1xGPU' , u'Server *\n2xGPU',u'Server\nCPU'),
      'ylim':(0,350000),
      'filename':"its-xc-dia-double.png"}
  barGraph(**params)

def itsPerDiaDouble():
#total iter SCF corriendo HEMO
  escala_scf_gpu = 1.3
  # se calcula escalando solo G2G diviendo por 1.86 el runtime
  # y se obtiene el ratio  de los nuevos total iteration
  msec_dia = 24*60*60*1000
  ws_gpu1 = msec_dia / (2762.302)
  ws_gpu2 = msec_dia / (1497.302)
  ws_cpu = msec_dia / (2695.594)
  server_gpu1 = msec_dia/(1903.302)
  server_gpu2 = msec_dia/(1903.302 / escala_scf_gpu)
  server_cpu = msec_dia/(1950.775)
  measures = [ws_gpu1, ws_gpu2, ws_cpu, server_gpu1, server_gpu2, server_cpu]

  params =  {#'title': u"Speedup del computo de density variando el tamaño de la estructuras",
      'xlabel':u"Configuración",
      'ylabel':u"Iteraciones SCF por día",
      'yvalues':measures,
      'ylim':(0,130000),
      'ticks':(u'WS\n1xGPU', u'WS\n2xGPU', u'WS\nCPU',
        u'Server\n1xGPU' , u'Server *\n2xGPU',u'Server\nCPU'),
      'filename':"its-dia-double.png"}
  barGraph(**params)

def itsXCPerDia():
  #total iter XC corriendo HEMO
  escala_xc_gpu = 1.86
  msec_dia = 24*60*60*1000
  ws_gpu1 = msec_dia / (441.302)
  ws_gpu2 = msec_dia / (257.369)
  ws_cpu = msec_dia / (1306.605)
  server_gpu1 = msec_dia/(522.937)
  server_gpu2 = msec_dia/(522.937 / escala_xc_gpu)
  server_cpu = msec_dia/(746.147)
  measures = [ws_gpu1, ws_gpu2, ws_cpu, server_gpu1, server_gpu2, server_cpu]

  params =  {#'title': u"Speedup del computo de density variando el tamaño de la estructuras",
      'xlabel':u"Configuración",
      'ylabel':u"Iteraciones XC por día",
      'yvalues':measures,
      'ylim':(0,350000),
      'ticks':(u'WS\n1xGPU', u'WS\n2xGPU', u'WS\nCPU',
        u'Server\n1xGPU' , u'Server *\n2xGPU',u'Server\nCPU'),
      'filename':"its-xc-dia.png"}
  barGraph(**params)

def itsPerDia():
#total iter SCF corriendo HEMO
  escala_scf_gpu = 1.24
  # se calcula escalando solo G2G diviendo por 1.86 el runtime
  # y se obtiene el ratio  de los nuevos total iteration
  msec_dia = 24*60*60*1000
  ws_gpu1 = msec_dia / (1080.302)
  ws_gpu2 = msec_dia / (720.302)
  ws_cpu = msec_dia / (1702.045)
  server_gpu1 = msec_dia/(1331.302)
  server_gpu2 = msec_dia/(1331.302 / escala_scf_gpu)
  server_cpu = msec_dia/(1313.775)
  measures = [ws_gpu1, ws_gpu2, ws_cpu, server_gpu1, server_gpu2, server_cpu]

  params =  {#'title': u"Speedup del computo de density variando el tamaño de la estructuras",
      'xlabel':u"Configuración",
      'ylabel':u"Iteraciones SCF por día",
      'yvalues':measures,
      'ylim':(0,130000),
      'ticks':(u'WS\n1xGPU', u'WS\n2xGPU', u'WS\nCPU',
        u'Server\n1xGPU' , u'Server *\n2xGPU',u'Server\nCPU'),
      'filename':"its-dia.png"}
  barGraph(**params)

#def tamParticion():
##Runtime total por grupo vs sizeingpu vs cost en Fullereno k40 cecar
#  fileformat = {'names': ('runtimecpu', 'runtimegpu'),
#        'formats' :('float32','float32')}
#  files = [
#      ("measures/tiempos_hemo/big-times-3","cost-time-cpu-gpu-big-size-3.png"),
#      ("measures/tiempos_hemo/small-times-3","cost-time-cpu-gpu-small-size-3.png"),
#      ("measures/tiempos_hemo/big-times-7","cost-time-cpu-gpu-big-size-7.png"),
#      ("measures/tiempos_hemo/small-times-7","cost-time-cpu-gpu-small-size-7.png")
#      ]
#  for f,fname in files:
#    measures = np.loadtxt(f, fileformat)
#    indices = np.array(range(1,len(measures)+1))
#    a_cpu = measures['runtimecpu']
#    a_gpu = measures['runtimegpu']
#
#    params =  {
#        'xlabel':u"Cantidad grupos resueltos",
#        'ylabel':u"Tiempo acumulado de resolución de grupos [ms]",
#        'yvalues':map((lambda x: np.divide(x,1000.0)),[a_cpu, a_gpu]),
#        'xvalues':indices,
#        'ylegend': ['Tiempo CPU 12 threads', 'Tiempo GPU'],
#        'filename':fname}
#    lineGraph(**params)
#
def tamParticion():
#Runtime total por grupo vs sizeingpu vs cost en Fullereno k40 cecar
  cpu_chicos_3=254.975
  cpu_grandes_3=584.758
  gpu_chicos_3=1181.110
  gpu_grandes_3=295.015

  cpu_chicos_7=30.028
  cpu_grandes_7=1068.011
  gpu_chicos_7=95.647
  gpu_grandes_7=407.470

  labels = [u"Grupos chicos", u"Grupos grandes"]
  comparison = {
      u"CPU 12 threads": [cpu_chicos_3, cpu_grandes_3 ],
      u"GPU": [gpu_chicos_3, gpu_grandes_3],
  }

  params = {
      'values': comparison,
      'ticks': labels,
      'filename': u'cpu-gpu-size-3.png',
      'ylabel': u'Tiempo de ejecución [ms]',
  }

  multiComparativeBarChart(**params)

  comparison = {
      u"CPU 12 threads": [cpu_chicos_7, cpu_grandes_7 ],
      u"GPU": [gpu_chicos_7, gpu_grandes_7],
  }

  params = {
      'values': comparison,
      'ticks': labels,
      'filename': u'cpu-gpu-size-7.png',
      'ylabel': u'Tiempo de ejecución [ms]',
  }

  multiComparativeBarChart(**params)

if __name__ == '__main__':
  itsPerDia()
  itsXCPerDia()
  tamParticion()
  itsPerDiaDouble()
  itsXCPerDiaDouble()
