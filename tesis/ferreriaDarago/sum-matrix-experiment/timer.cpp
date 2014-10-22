#include <time.h>
#include <sstream>
#include <algorithm>
#include <numeric>

#include <papi.h>
#include "timer.h"

using namespace std;

const long long NANOSINSEC = 1000000000;
const long long NANOSINMICRO = 1000;
double ClockGetTimeSource::time() const {
    struct timespec t;
    clock_gettime(CLOCK_MONOTONIC, &t);
    return NANOSINSEC*t.tv_sec + t.tv_nsec;
}

double PapiTimeSource::time() const {
    return ((double )PAPI_get_virt_usec()) * NANOSINMICRO;
}

static std::string printnanos(double nanos) {
    std::ostringstream os;
    long long nsecs = (long long) nanos;
    os << (nsecs / NANOSINSEC) << "s. " << (nsecs % NANOSINSEC) << "ns";
    return os.str();
}


Timer::Timer(const TimeSource * t) : running(false), source(t) { }

void Timer::start() {
    if(!running) {
        running = true;
        latest = source->time();    
    }
}

void Timer::pause() {
    if (running) {
        double current = source->time();
        measurements.push_back(current - latest);
    }
    running = false;
}

double Timer::nanosecs() const {
    return std::accumulate(measurements.begin(), measurements.end(), 0.0); 
}

double Timer::average() const {
    return nanosecs() / measurements.size();
}

const std::vector<double> & Timer::times() const {
    return measurements;
}

std::ostream & operator<<(std::ostream & os, const Timer & t)
{
    os << "total: " << printnanos(t.nanosecs()) << ", avg = " << printnanos(t.average());
    return os;
}
