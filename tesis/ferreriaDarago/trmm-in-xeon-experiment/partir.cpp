#include <iostream>
#include <stdio.h>
#include <math.h>
#include <sstream>
#include <cstdlib>
#include "timer.h"

#ifdef MAGMA
#include <magma.h>
#include <magma_lapack.h>
#include <magma_types.h>
#else
#include <mkl.h>
#endif

using namespace std;

#ifdef MAGMA
magma_queue_t queue;
magma_device_t device;
#endif

float * allocmem(int size1, int size2) {
    #ifdef MAGMA
        float * ret, * init;
        magma_malloc( (void **) &ret, size1 * size2 * sizeof(float));
        magma_malloc_pinned( (void **) &init, size1 * size2 * sizeof(float));
        magma_ssetmatrix( size2, size1, init, 0, size2, ret, 0, size2, queue);
        return ret;
    #else
        float * init = (float *) mkl_calloc(size1 * size2, sizeof(float), 64);
        return init;
    #endif
}

void freemem(float * f) {
    #ifdef MAGMA
        magma_free(f);
    #else
        mkl_free(f);
    #endif
}

int main(int argc, char * argv[])
{
    if (argc <= 2) {
        printf("Faltan argumentos: %s <first size> <second size>\n", argv[0]);
        exit(1);
    }

    #ifdef MAGMA
    magma_init();

    magma_int_t num, err;
    err = magma_get_devices( &device, 1, &num);
    if ( err != MAGMA_SUCCESS || num < 1) {
        fprintf( stderr, "fuck you and your device mate\n");
        exit(1);
    }
    err = magma_queue_create(device, &queue);
    if (err != MAGMA_SUCCESS) {
        fprintf( stderr, "fuck you and your queue mate\n");
        exit(1);
    }
    #endif

    int size1 = atoi(argv[1]), size2 = atoi(argv[2]);
    float * mat1 = allocmem(size1,size1); 
    float * mat2 = allocmem(size1,size2); 

    Timer ts;

    const int TRIES = 11;
    for(int tries = 0; tries < TRIES; tries++) {
        ts.start();
        #ifndef MAGMA
            cblas_strmm(CblasRowMajor, CblasRight, CblasLower, CblasNoTrans, CblasNonUnit,
                size2, size1, 1.0, mat1, size1, mat2, size1);
        #else
            magma_sync_wtime(NULL);
            magma_strmm(MagmaRight, MagmaLower, MagmaNoTrans, MagmaNonUnit,
                size2, size1, 1.0, mat1, 0, size1, mat2, 0, size2, queue);
            magma_sync_wtime(NULL);
        #endif
        ts.pause(); 
    }

    long long ns = ts.nanosecs();
    cout << size1 << " " << size2 << " " << ns << endl;

    freemem(mat1);
    freemem(mat2);

    #ifdef MAGMA
    magma_queue_destroy(queue);
    magma_finalize();
    #endif

    return 0;
}
