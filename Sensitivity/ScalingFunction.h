#ifndef __SCALING_FUNCTION
#define __SCALING_FUNCTION
#include <math.h>
#include <cstdint>

#define DEBUGMODE 0

#if DEBUGMODE==1
#include <iostream>
#include <iomanip>
using std::cout;
using std::endl;
#endif

class ScalingFunction {
public:
  // Type list
  enum FunctionType : uint8_t { FT_LINEAR, FT_LINEAR_PLUS, FT_LOG, FT_SQRT };

  // Constructor
  explicit ScalingFunction(FunctionType t = FT_LINEAR, uint16_t o = 0, uint16_t b = 0, float s = 1.0) {
    _init(0, t, o, b, s);
  }
  
  uint16_t operator[](uint16_t index) { return (index < 4096 ? pv[index] : 0); }

  uint8_t addOverlay(FunctionType t = FT_LINEAR, uint16_t o = 0, uint16_t b = 0, float s = 1.0) {
    return _init(1, t, o, b, s);
  }
  
protected:
  uint16_t pv[4096];

  uint8_t _init(uint8_t overlay = 0, FunctionType type = FT_LINEAR, uint16_t offset = 0, uint16_t base = 0, float slope = 1.0) {
    // Guard in call values
    if (offset > 4095) offset = 4095;
    if (base > 4095) base = 4095;

#if DEBUGMODE==1
    cout << "Overlay=" << (unsigned int)overlay << ", offset=" << offset << ", base=" << base << ", slope=" << slope <<  endl;
#endif
    // Apply offset initialization, if necessary
    if (offset && overlay == 0) {
      for (uint16_t i = 0; i < offset; i++) {
        pv[i] = 0;
      }
    }

    // Calculate values
    for (uint16_t i = offset; i < 4096; i++) {
      int value = overlay ? pv[i] : 0;  // Take current value as a base when overlaying
#if DEBUGMODE==1
      cout << i << ": before=" << value;
#endif

      switch(type) {
      case FT_LINEAR_PLUS:   // linear function  with offset and initial lift
        value += base + (i - offset) * slope;
        break;
      case FT_LOG:   // logarithmic
        value += base + log(i - offset) * slope;
        break;
      case FT_SQRT:   // square root
        value += base + sqrt(i - offset) * slope;
        break;
      default:  // default is linear without offset or initial lift
        value += i;
        break;
      }
      // Guard in value
      value = value < 4096 ? (value >= 0 ? value : 0) : 4095;
#if DEBUGMODE==1
      cout << " after=" << value << endl;
#endif
      pv[i] = value;
    }
    return 0;
  }

};
#endif
