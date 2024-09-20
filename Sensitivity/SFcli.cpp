#include <iostream>
#include <iomanip>
#include <cstdint>
#include "ScalingFunction.h"

using std::cout;
using std::endl;
using std::setw;

int main (int argc, char **argv) {

  if (argc == 0 || ((argc - 1) % 4) != 0) {
    cout << "Usage: " << argv[0] << " type offset base slope [type offset base slope [...]]" << endl;
    return -1;
  }

  int argcBase = 1;
  ScalingFunction::FunctionType type = (ScalingFunction::FunctionType)atoi(argv[argcBase++]);
  uint16_t offset = atoi(argv[argcBase++]);
  uint16_t base = atoi(argv[argcBase++]);
  float slope = atof(argv[argcBase++]);

  ScalingFunction scale(type, offset, base, slope);

  while (argc > argcBase) {
    type = (ScalingFunction::FunctionType)atoi(argv[argcBase++]);
    offset = atoi(argv[argcBase++]);
    base = atoi(argv[argcBase++]);
    slope = atof(argv[argcBase++]);
    scale.addOverlay(type, offset, base, slope);
  }

  for (uint16_t i = 0; i < 4096; i++) {
    cout << setw(5) << i << "; " 
      << scale[i]
      << endl;
  }

  return 0;
}