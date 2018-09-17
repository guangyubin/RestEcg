//
// File: tach_predict_types.h
//
// MATLAB Coder version            : 3.4
// C/C++ source code generated on  : 14-Aug-2018 16:01:54
//
#ifndef TACH_PREDICT_TYPES_H
#define TACH_PREDICT_TYPES_H

// Include Files
#include "rtwtypes.h"

// Type Definitions
typedef struct {
  double CutVar[621];
  double Children[1242];
  double ClassProb[3105];
  double CutPoint[621];
  double ClassNames[5];
  int ClassNamesLength[5];
  double Prior[5];
  double Cost[25];
} c_classreg_learning_coder_class;

#endif

//
// File trailer for tach_predict_types.h
//
// [EOF]
//
