#include <iostream>
#include <iomanip>
#include <cstdint>
#include <array>
#include "ScalingFunction.h"

using std::cout;
using std::endl;
using std::setw;
using std::array;

#include "SFcli.h"

int main (int argc, char **argv) {

  ScalingFunction plainLinear;
  ScalingFunction linearJustOffset(ScalingFunction::FT_LINEAR_PLUS, 450);
  ScalingFunction linearOffsetAndBase(ScalingFunction::FT_LINEAR_PLUS, 800, 1200);
  ScalingFunction linearOffsetBaseAndSlope(ScalingFunction::FT_LINEAR_PLUS, 200, 200, 2);
  ScalingFunction linearDecreasing(ScalingFunction::FT_LINEAR_PLUS, 0, 4095, -1.05);
  ScalingFunction logarithmic(ScalingFunction::FT_LOG, 1200, 1000, 210);
  ScalingFunction squareRoot(ScalingFunction::FT_SQRT, 0, 100, 4.5);
  ScalingFunction overlayed(ScalingFunction::FT_LINEAR, 0, 0, 3);
  overlayed.addOverlay(ScalingFunction::FT_SQRT, 1000, 0, -45.0);

  plainLinear = _WOZZMYNAME_;

  for (uint16_t i = 0; i < 4096; i++) {
    cout << setw(5) << i << "; " 
      << plainLinear[i] << "; " 
      << linearJustOffset[i] << "; " 
      << linearOffsetAndBase[i]  << "; "
      << linearOffsetBaseAndSlope[i]  << "; "
      << linearDecreasing[i] << "; "
      << logarithmic[i] << "; "
      << squareRoot[i] << "; "
      << overlayed[i]
      << endl;
  }

  return 0;
}