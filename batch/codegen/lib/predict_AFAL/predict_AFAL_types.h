//
// File: predict_AFAL_types.h
//
// MATLAB Coder version            : 3.4
// C/C++ source code generated on  : 15-Aug-2018 16:03:15
//
#ifndef PREDICT_AFAL_TYPES_H
#define PREDICT_AFAL_TYPES_H

// Include Files
#include "rtwtypes.h"

// Type Definitions
typedef struct {
  double CutVar[309];
  double Children[618];
  double ClassProb[618];
  double CutPoint[309];
  double ClassNames[2];
  int ClassNamesLength[2];
  double Prior[2];
  double Cost[4];
} c_classreg_learning_coder_class;

typedef struct {
  double CutVar[621];
  double Children[1242];
  double ClassProb[3105];
  double CutPoint[621];
  double ClassNames[5];
  int ClassNamesLength[5];
  double Prior[5];
  double Cost[25];
} d_classreg_learning_coder_class;

#endif

//
// File trailer for predict_AFAL_types.h
//
// [EOF]
//
