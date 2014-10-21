CXX=icpc
CXXFLAGS=-ggdb -vec-report=5 -ansi-alias -Wall -Wextra -O2 -I$(MKLROOT)/include -I/opt/papi/include

LDLIBS= -lpapi -lrt -mkl
LDFLAGS= -L/opt/papi/lib

SRCS:=$(wildcard *.cpp)
HEADERS:=$(wildcard *.h)
OBJS:=$(SRCS:%.cpp=%.o)

.PHONY: clean all

fast: LDLIBS += -openmp
fast: main
	mv main fast

slow: main
	mv main slow

tarball: clean
	tar zcvf experiment.tar.gz $(SRCS) $(HEADERS) Makefile 

clean:
	rm -rf *.d *.o main *.optrpt

-include $(OBJS:.o=.d)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) $*.cpp -c -o $*.o $(LDLIBS)
	@$(CXX) -MM $(CXXFLAGS) $*.cpp > $*.d
	@cp -f $*.d $*.d.tmp
	@sed -e 's/.*://' -e 's/\\$$//' < $*.d.tmp | fmt -1 | \
	  sed -e 's/^ *//' -e 's/$$/:/' >> $*.d
	@rm -f $*.d.tmp

main: $(OBJS)
	$(CXX) $(CXXFLAGS) $(LDFLAGS) $^ -o $@ $(LDLIBS)
