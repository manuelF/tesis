#!/bin/env python
import fileinput
import math

def avg(l):
    return sum(l) / len(l)


def stddev(l):
    a = avg(l)
    return math.sqrt(sum(map(lambda p: (p-a)**2, l)) / len(l))

def avgfromfile(fname):
    data = []
    with open(fname, "r") as f:
        lines = f.readlines()
        for line in lines:
            sec,nsec = line.split()
            data.append(float(sec)*1000000000 + float(nsec))
    return avg(data)

if __name__ == '__main__':
    a1 = avgfromfile("run-xeon.txt")
    a2 = avgfromfile("run-xeon-phi.txt")
    print "xeon-phi / xeon = %f mas rapido" % (a1/a2,)
