#ifndef __TIMER_H
#define __TIMER_H

#include <time.h>
#include <sstream>

const long long NANOSINSEC = 1000000000;
long long diff_in_nanos(struct timespec * fst, struct timespec * snd) {
    return NANOSINSEC*(snd->tv_sec - fst->tv_sec) + (snd->tv_nsec - fst->tv_nsec);
}

std::string printnanos(long long nsecs) {
    std::ostringstream os;
    os << (nsecs / NANOSINSEC) << "s. " << (nsecs % NANOSINSEC) << "ns. ";
    return os.str();
}


class Timer {
    public:
        Timer() {
            total = 0; running = false; first_run = true;
        }

        void start() {
            if(!running) {
                clock_gettime(CLOCK_MONOTONIC, &measurement);
                running = true;
            }
        }

        void pause() {
            if (running) {
                struct timespec t;
                clock_gettime(CLOCK_MONOTONIC, &t);
                if (!first_run) {
                    total += diff_in_nanos(&measurement, &t);
                }
                first_run = false;
            }
            running = false;
        }

        long long nanosecs() const {
            return total;
        }

    private:
        long long total;
        struct timespec measurement;
        bool running, first_run;
};

#endif
