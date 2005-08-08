F77 = g77
CPP = c++

OBJ =     config.o cvemot.o  cvemotn.o  cvemotnn.o \
	   gamma.o lath.o   main.o  doda.o dado.o\
	   gauss.o  tepchr.o  newxyz.o corect.o corect2.o\
           fspher.o fspher2.o  printer.o  dipolos.o \
           qemot.o qtmotb.o  tepq.o tepchr2.o \
           inicio.o  fint.o fint2.o optim.o optimq.o\
           int.o drive.o SCF.o  func.o     \
           int2.o  int3.o int3G.o exch.o    \
           exch2.o pot.o int2G.o int1G.o \
           intSG.o write.o \
           dns.o dns2.o dnsg.o potg.o dip.o dipG.o  \
           int3N.o exchnum.o exchnum2.o grid.o\
           densg.o  exchfock.o cvemotn1.o\
           nwrite.o  SCFop.o\
           densgop.o dns2op.o dnsop.o exchnum2op.o\
           exchnumop.o potop.o alg.o eig.o svd.o \
           dnsgop.o potgop.o  dip2.o \
           intsolG.o intsol.o grilla.o\
           lalg.o int3mem.o int3lu.o ungles.o \
           cvemot1.o  proton.o dipcor.o  furim.o savestate.o
COMPFLG =  -O3 -pipe -fomit-frame-pointer -c\
           -falign-loops=2 -fno-strength-reduce \
           -ffast-math -falign-functions=2 -I/usr/include

#COMPFLG2 = -O -I/usr/include
#more or less general
LINKFLG = -lm  -lfmpich -lmpich -lmpichfsup -lpmpich -lpmpich++ -lmpe -lpthread 
CPP     = /lib/cpp
CPPFLAGS = -P 
DEFINE   = -Dpack

.SUFFIXES: .f .o .fpp

posta:  $(OBJ)
	$(F77) -o posta $(OBJ) $(LINKFLG)

clean:
	@echo "Removing Object files.";rm -f *.o; 

         
# config.o    : config.f COMM puto puto
# 	g77 $(COMPFLG) config.f 
# 
# cvemot.o    : cvemot.f COMM
# 	g77 $(COMPFLG) cvemot.f 
# 
# cvemotn.o   : cvemotn.f COMM
# 	g77 $(COMPFLG) cvemotn.f 
# 
# cvemotnn.o  : cvemotnn.f COMM
# 	g77 $(COMPFLG) cvemotnn.f
# 
# cvemot1.o   : cvemot1.f COMM
# 	g77 $(COMPFLG) cvemot1.f 
# 
# cvemotn1.o   : cvemotn1.f COMM
# 	g77 $(COMPFLG) cvemotn1.f 
# 
# gamma.o     : gamma.f COMM
# 	g77 $(COMPFLG) gamma.f
# 
# gauss.o    : gauss.f COMM
# 	g77 $(COMPFLG) gauss.f 
# 
# newxyz.o    : newxyz.f COMM
# 	g77 $(COMPFLG) newxyz.f 
# 
# lath.o     : lath.f COMM
# 	g77 $(COMPFLG) lath.f 
# 
# main.o    : main.f COMM param
# 	g77 $(COMPFLG) main.f 
# 
# doda.o    : doda.f COMM 
# 	g77 $(COMPFLG) doda.f 
# 
# dado.o    : dado.f COMM param
# 	g77 $(COMPFLG) dado.f 
# 
# tepchr.o     : tepchr.f COMM
# 	g77 $(COMPFLG) tepchr.f
# 
# tepchr2.o     : tepchr2.f COMM
# 	g77 $(COMPFLG) tepchr2.f
# 
# corect.o    : corect.f COMM
# 	g77 $(COMPFLG) corect.f 
# 
# corect2.o    : corect2.f COMM
# 	g77 $(COMPFLG) corect2.f
# 
# fspher.o     : fspher.f COMM
# 	g77 $(COMPFLG) fspher.f
# 
# fspher2.o     : fspher2.f COMM
# 	g77 $(COMPFLG) fspher2.f
# 
# furim.o    : furim.f COMM
# 	g77 $(COMPFLG) furim.f
# 
# printer.o     : printer.f COMM
# 	g77 $(COMPFLG) printer.f
# 
# dipolos.o     : dipolos.f COMM
# 	g77 $(COMPFLG) dipolos.f
# 
# qemot.o      : qemot.f COMM
# 	g77 $(COMPFLG) qemot.f
#  
# qtmotb.o      : qtmotb.f COMM
# 	g77 $(COMPFLG) qtmotb.f
#  
# tepq.o      : tepq.f COMM
# 	g77 $(COMPFLG) tepq.f
#  
# inicio.o      : inicio.f COMM
# 	g77 $(COMPFLG) inicio.f
#  
# fint.o      : fint.f COMM
# 	g77 $(COMPFLG) fint.f
# 
# fint2.o      : fint2.f COMM
# 	g77 $(COMPFLG) fint2.f
#  
# grilla.o      : grilla.f COMM
# 	g77 $(COMPFLG) grilla.f
# 
# optim.o      : optim.f COMM
# 	g77 $(COMPFLG) optim.f
#  
# optimq.o      : optimq.f COMM
# 	g77 $(COMPFLG) optimq.f
#  
# proton.o      : proton.f COMM
# 	g77 $(COMPFLG) proton.f
 
# int.o    : int.f param
# 	g77 $(COMPFLG) int.f 
# 
# int1G.o    : int1G.f param
# 	g77 $(COMPFLG) int1G.f 
# 
# drive.o : drive.f COMM param 
# 	g77 $(COMPFLG2) drive.f 
# 
# func.o : func.f
# 	g77 $(COMPFLG) func.f 

# int2.o    : int2.f param
# 	$(CPP) $(CPPFLAGS) $(DEFINE) int2.f int2_cpp.f 
# 	g77 $(COMPFLG) int2_cpp.f 
# 	mv int2_cpp.o int2.o
# 	rm -f int2_cpp.f

# int2G.o    : int2G.f param
# 	g77 $(COMPFLG) int2G.f 
# 
# int3G.o    : int3G.f param
# 	g77 $(COMPFLG) int3G.f 

# int3.o    : int3.f param
# 	$(CPP) $(CPPFLAGS) $(DEFINE) int3.f int3_cpp.f
# 	g77 $(COMPFLG) int3_cpp.f
# 	mv int3_cpp.o int3.o
# 	rm -f int3_cpp.f

# int3N.o    : int3N.f param
# 	$(CPP) $(CPPFLAGS) $(DEFINE) int3N.f int3N_cpp.f
# 	g77 $(COMPFLG) int3N_cpp.f
# 	mv int3N_cpp.o int3N.o
# 	rm -f int3N_cpp.f

# int3lu.o    : int3lu.f param
# 	$(CPP) $(CPPFLAGS) $(DEFINE) int3lu.f int3lu_cpp.f
# 	g77 $(COMPFLG) int3lu_cpp.f
# 	mv int3lu_cpp.o int3lu.o
# 	rm -f int3lu_cpp.f

# int3mem.o    : int3mem.f param
# 	g77 $(COMPFLG) int3mem.f

# exch.o    : exch.f param
# 	$(CPP) $(CPPFLAGS) $(DEFINE) exch.f exch_cpp.f
# 	g77 $(COMPFLG) exch_cpp.f
# 	mv exch_cpp.o exch.o
# 	rm -f exch_cpp.f

# exch2.o    : exch2.f param
# 	$(CPP) $(CPPFLAGS) $(DEFINE) exch2.f exch2_cpp.f
# 	g77 $(COMPFLG) exch2_cpp.f
# 	mv exch2_cpp.o exch2.o
# 	rm -f exch2_cpp.f

# pot.o    : pot.f 
# 	g77 $(COMPFLG) pot.f 

# SCF.o    : SCF.f param 
# 	$(CPP) $(CPPFLAGS) $(DEFINE) SCF.f SCF_cpp.f
# 	g77 $(COMPFLG) SCF_cpp.f 
# 	mv SCF_cpp.o SCF.o
# 	rm -f SCF_cpp.f

# intSG.o     : intSG.f param
# 	g77 $(COMPFLG) intSG.f 

# write.o     : write.f param
# 	$(CPP) $(CPPFLAGS) $(DEFINE) write.f write_cpp.f
# 	g77 $(COMPFLG) write_cpp.f
# 	mv write_cpp.o write.o
# 	rm -f write_cpp.f

# nwrite.o     : nwrite.f param
# 	$(CPP) $(CPPFLAGS) $(DEFINE) nwrite.f nwrite_cpp.f
# 	g77 $(COMPFLG) nwrite_cpp.f
# 	mv nwrite_cpp.o nwrite.o
# 	rm -f nwrite_cpp.f

# dns.o     : dns.f param
# 	g77 $(COMPFLG) dns.f 
# 
# dns2.o     : dns2.f param
# 	g77 $(COMPFLG) dns2.f 
# 
# dnsg.o     : dnsg.f param
# 	g77 $(COMPFLG) dnsg.f 
# 
# densg.o     : densg.f param
# 	g77 $(COMPFLG) densg.f 
# 
# potg.o     : potg.f 
# 	g77 $(COMPFLG) potg.f 
# 
# dip.o     : dip.f param
# 	g77 $(COMPFLG) dip.f 
# 
# dipG.o     : dipG.f param
# 	g77 $(COMPFLG) dipG.f 
# 
# dip2.o     : dip2.f param
# 	g77 $(COMPFLG) dip2.f 
# 
# exchnum.o     : exchnum.f param
# 	g77 $(COMPFLG) exchnum.f 
# 
# grid.o     : grid.f
# 	g77 $(COMPFLG) grid.f 
# 
# exchnum2.o     : exchnum2.f param
# 	g77 $(COMPFLG) exchnum2.f 
# 
# exchfock.o     : exchfock.f param
# 	g77 $(COMPFLG) exchfock.f 

# SCFop.o    : SCFop.f param COMM
# 	$(CPP) $(CPPFLAGS) $(DEFINE) SCFop.f SCFop_cpp.f
# 	g77 $(COMPFLG) SCFop_cpp.f
# 	mv SCFop_cpp.o SCFop.o
# 	rm -f SCFop_cpp.f

# densgop.o     : densgop.f param
# 	g77 $(COMPFLG) densgop.f
# 
# dns2op.o     : dns2op.f param
# 	g77 $(COMPFLG) dns2op.f
# 
# dnsop.o     : dnsop.f param
# 	g77 $(COMPFLG) dnsop.f
# 
# exchnum2op.o     : exchnum2op.f param
# 	g77 $(COMPFLG) exchnum2op.f
# 
# exchnumop.o     : exchnumop.f param
# 	g77 $(COMPFLG) exchnumop.f
# 
# potop.o     : potop.f param
# 	g77 $(COMPFLG) potop.f
# 
# potgop.o     : potgop.f 
# 	g77 $(COMPFLG) potgop.f
# 
# dnsgop.o     : dnsgop.f param
# 	g77 $(COMPFLG) dnsgop.f
# 
# alg.o     : alg.f 
# 	g77 $(COMPFLG) alg.f
# 
# eig.o     : eig.f
# 	g77 $(COMPFLG) eig.f
# 
# svd.o     : svd.f
# 	g77 $(COMPFLG) svd.f
# 
# intsol.o    : intsol.f param
# 	g77 $(COMPFLG) intsol.f 
# 
# intsolG.o    : intsolG.f param
# 	g77 $(COMPFLG) intsolG.f 
# 
# lalg.o    : lalg.f param
# 	g77 $(COMPFLG) lalg.f 
# 
# ungles.o    : ungles.f COMM param
# 	g77 $(COMPFLG) ungles.f 
# 
# dipcor.o    : dipcor.f COMM 
# 	g77 $(COMPFLG) dipcor.f 

.f.o: COMM param
	$(F77) $(COMPFLG) -c $<

.fpp.f:
	$(CPP) $(CPPFLAGS) $(DEFINE) $< $@
# 	$(F77) $(COMPFLG) int2_cpp.f 
# 	rm -f $@
