#include <iostream>
#include <omp.h>
#include <stdlib.h>
#include <math.h>
#include <stdio.h>
#include <mkl.h>
#include <xmmintrin.h>
#include <cassert>
#include <math.h>

#include <papi.h>

#include "matrix.h"
#include "timer.h"

using namespace std;

const float PI = 3.14159;
const int MAX_TIMES = 20;

float do_work(const Matrix<float> & m, int threads)
{
    int size1 = m.ncols(), size2 = m.nrows();
    float result = 0;
    #pragma omp parallel num_threads(threads)
    {
        for(int times = 0; times < MAX_TIMES; times++) {
            #pragma omp for reduction(+:result) schedule(static)
            for(int i = 0; i < size2; i++) {
                float v = 0; 

                for(int j = 0; j < size1; j++) {
                    float val = m(i,j);
                    v += exp(val * val) + cos(sqrt(val)) + tan(val * val * PI);
                }
                result += v;
            }
        }
    }
    return result;
}

int main(int argc, const char * argv[])
{
    if(argc < 4) {
        printf("Uso: %s <size1> <size2> <num threads>\n", argv[0]);
        exit(0);
    }

    if (PAPI_library_init(PAPI_VER_CURRENT) != PAPI_VER_CURRENT) {
        printf("No se pudo abrir la libreria PAPI");
        exit(1);
    }

    float v = random();
    float r = v / (v + 2.5);
    const int size1 = atoi(argv[1]), size2 = atoi(argv[2]), threads = atoi(argv[3]);

    assert(size1 * sizeof(float) % 64 == 0);
    assert(size2 * sizeof(float) % 64 == 0);

    printf("SIZE = %d, %d, THREADS = %d, version = %s\n", size1, size2, threads, argv[0]);

    Matrix<float> m(size2, size1);
    m.fill(r);

    ClockGetTimeSource source;
    Timer all(&source);

    int ret; 

    const int EVS = 4;
    int events[EVS] = { PAPI_L1_DCM, PAPI_L2_DCM, PAPI_L3_TCM, PAPI_FP_OPS };
    long long values[EVS];

    all.start();
    if((ret = PAPI_start_counters(events, EVS)) != PAPI_OK) {
        fprintf(stderr, "Se rompieron los contadores: %s\n", PAPI_strerror(ret));
        exit(1);
    }
    
    float result = do_work(m, threads);

    if((ret = PAPI_read_counters(values, EVS)) != PAPI_OK) {
        fprintf(stderr, "Se rompieron los contadores al leerlos: %s\n", PAPI_strerror(ret));
        exit(1);
    }
    all.pause();
    
    float perelem = exp(r * r) + cos(sqrt(r)) + tan(r * r * PI);
    float expect = perelem*size1*size2*MAX_TIMES;
    if(abs((result - expect) / expect) > 1e-6) {
        cout << "Respuesta erronea! " << expect << " " << result << endl;
        exit(1);
    }

    printf("Total L1 Cache misses: %lld\n", values[0]);
    printf("Total L2 Cache misses: %lld\n", values[1]);
    printf("Total L3 Cache misses: %lld\n", values[2]);
    printf("Total FP Operations: %lld\n", values[3]);
    cout << "all = " << all << endl;
    return 0;
}
