#!/usr/bin/env python

import itertools
import sys 

if __name__ == '__main__':
    handles = map(lambda s: open(s, "r"), sys.argv[1:])

    l = [map(lambda s: s.strip().rsplit(" ", 3), h.readlines()) for h in handles]
    grouped = sorted([v for sl in l for v in sl], key=lambda s: s[0:2]) 

    for sizes, times in itertools.groupby(grouped, key=lambda s: s[0:2]):
        sizes = map(int, sizes)
        toprint = " ".join(map(lambda s: s[2], list(times)))
        print "%d %s" % (sizes[1] * sizes[0]** 2, toprint)
