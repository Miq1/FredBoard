#include <iostream>
#include <iomanip>
#include <cstdint>
#include "ScalingFunction.h"

using std::cout;
using std::endl;
using std::setw;

int main (int argc, char **argv) {
  ScalingFunction plainLinear;
  ScalingFunction linearJustOffset(ScalingFunction::FT_LINEAR_PLUS, 450);
  ScalingFunction linearOffsetAndBase(ScalingFunction::FT_LINEAR_PLUS, 800, 1200);
  ScalingFunction linearOffsetBaseAndSlope(ScalingFunction::FT_LINEAR_PLUS, 200, 200, 2);
  ScalingFunction linearDecreasing(ScalingFunction::FT_LINEAR_PLUS, 0, 4095, -1.05);
  ScalingFunction logarithmic(ScalingFunction::FT_LOG, 1200, 1000, 1.8);
  ScalingFunction squareRoot(ScalingFunction::FT_SQRT, 0, 100, 4.5);

  for (uint16_t i = 0; i < 4096; i++) {
    cout << setw(5) << i << ": " 
      << plainLinear[i] << ", " 
      << linearJustOffset[i] << ", " 
      << linearOffsetAndBase[i]  << ", "
      << linearOffsetBaseAndSlope[i]  << ", "
      << linearDecreasing[i] << ", "
      << logarithmic[i] << ", "
      << squareRoot[i]
      << endl;
  }

  return 0;
}