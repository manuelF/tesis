#ifndef __TIMER_H
#define __TIMER_H

#include <time.h>
#include <sstream>
#include <vector>

class TimeSource {
    public: 
        virtual double time() const = 0;
};

class ClockGetTimeSource : public TimeSource {
    public:
        double time() const;
};

class PapiTimeSource : public TimeSource {
    public:
        double time() const;
};

class Timer {
    public:
        Timer(const TimeSource *);
        void start();
        void pause();
        double nanosecs() const;
        double average() const;
        const std::vector<double> & times() const;

    private:
        friend std::ostream & operator<<(std::ostream & os, const Timer & t);

        std::vector<double> measurements;
        double latest;
        bool running;
        const TimeSource * source;
};

#endif
