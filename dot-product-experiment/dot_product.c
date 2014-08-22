#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <time.h>
#include <malloc.h>

typedef struct timespec timespec;

timespec diff(timespec start, timespec end)
{
	timespec temp;
	if ((end.tv_nsec-start.tv_nsec)<0) {
		temp.tv_sec = end.tv_sec-start.tv_sec-1;
		temp.tv_nsec = 1000000000+end.tv_nsec-start.tv_nsec;
	} else {
		temp.tv_sec = end.tv_sec-start.tv_sec;
		temp.tv_nsec = end.tv_nsec-start.tv_nsec;
	}
	return temp;
}

#define alloc_floats(n) _mm_malloc((n) * sizeof(float), 64)

float * random_array(int numbers)
{
    float * data = alloc_floats(numbers);
    int i;
    for(i = 0; i < numbers; ++i){
        float denom = 0;
        while(denom == 0) denom = rand();
        data[i] = rand() / denom;
    }
    return data;
}

void dowork(float *restrict data1, float *restrict data2, float *restrict data3, int numbers)
{
    int i, chunksize = numbers / 128;
    #pragma omp parallel for
    for(int chunk = 0; chunk < numbers; chunk += chunksize){
        #pragma ivdep
        #pragma vector aligned nontemporal 
        for(i = chunk; i < chunk+chunksize; i++) {
            data3[i] = data1[i] * data2[i];
        }
    }
}

int main(int argc, const char * argv[])
{
    srand(time(NULL)); 
    unsigned int numbers = (argc > 1) ? atoi(argv[1]) : 64000000;
    printf("%lf\n", numbers * sizeof(float));
    int try, tries = (argc > 2) ? atoi(argv[2]) : 15;
    float * data1 = random_array(numbers);
    float * data2 = random_array(numbers);
    float * data3 = alloc_floats(numbers);
    for(try = 0; try < tries; ++try){
        volatile timespec start, end;

        clock_gettime(CLOCK_REALTIME, (timespec*) &start);
        dowork(data1,data2,data3, numbers);
        clock_gettime(CLOCK_REALTIME, (timespec*) &end);

	    timespec d = diff(start,end);
	    fprintf(stderr,"%ld %ld\n", d.tv_sec, d.tv_nsec);
    }
    int i; double res = 0;
	for(i = 0; i < numbers; i++) {
	    res += data3[i];
    }
    printf("%lf\n",res);
    return 0;
}
