CXX=icpc
CXXFLAGS=-g -Wall -O3 -I$(MKLROOT)/include -I/opt/magma/include

LDLIBS=-lrt 

xeon: LDLIBS+=-mkl
xeon: partir
	mv partir xeon

xeon-phi: LDLIBS+=-mkl
xeon-phi: partir
	mv partir xeon-phi

xeon-magma: LDFLAGS+=-L/opt/magma/lib -L/opt/intel/mic/coi/host-linux-release/lib
xeon-magma: LDLIBS+=-lscif -lcoi_host -lmicmagma 
xeon-magma: CXXFLAGS+=-DMAGMA -DHAVE_MIC -DADD_ 
xeon-magma: partir
	mv partir xeon-magma

clean:
	rm -rf xeon xeon-phi partir xeon-magma
