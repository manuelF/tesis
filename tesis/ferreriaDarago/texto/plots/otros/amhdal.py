#!/usr/bin/env python
# -*- coding: utf-8 -*-

import pylab
import numpy as np
def amdahl(B):
  return lambda n: 1.0 / (B + (1.0 / n) * (1.0 -B) )

cores = np.linspace(1, 100, 100)
pylab.xlabel(u"Cantidad de núcleos")
pylab.ylabel(u"Aceleración (en xN)")
pylab.title(u"Ley de Amdahl")
for v in [0.50, 0.75, 0.90, 0.95]:
  B = 1.0 - v
  pylab.plot(cores, amdahl(B)(cores), label=u"{0}% paralelo".format(v * 100))
pylab.legend()
pylab.show()
