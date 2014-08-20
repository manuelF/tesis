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

float * random_array(int numbers)
{
    float * data = memalign(64, numbers * sizeof(float));
    int i;
    for(i = 0; i < numbers; ++i){
        float denom = 0;
        while(denom == 0) denom = rand();
        data[i] = rand() / denom;
    }
    return data;
}

void dowork(float * data1, float * data2, float * data3, int numbers)
{
    int i;

    #pragma omp parallel for 
    #pragma ivdep
    for(i = 0; i < numbers; i++) {
        data3[i] = data1[i] * data2[i];
    }
}

int main(int argc, const char * argv[])
{
    srand(time(NULL)); 
    int numbers = (argc > 1) ? atoi(argv[1]) : 512000000;
    float * data1 = random_array(numbers);
    float * data2 = random_array(numbers);
    float * data3 = memalign(64, numbers * sizeof(float));
    int try, tries = (argc > 2) ? atoi(argv[2]) : 10;
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
    free(data1);
    free(data2);
    free(data3);
    return 0;
}
