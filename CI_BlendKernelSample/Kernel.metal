#include <CoreImage/CoreImage.h>

extern "C" {
    namespace coreimage {

        float4 blend(sample_t foreground, sample_t background) {
            return (foreground + background) / 2.0;
        }

    }
}
