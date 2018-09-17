//
// File: predict_AFAL.cpp
//
// MATLAB Coder version            : 3.4
// C/C++ source code generated on  : 15-Aug-2018 16:03:15
//

// Include Files
#include "rt_nonfinite.h"
#include "predict_AFAL.h"
#include "predict_tach.h"
#include "CompactClassificationTree.h"
#include "CompactTree.h"

// Function Definitions

//
// Arguments    : const double X[12]
// Return Type  : double
//
double predict_AFAL(const double X[12])
{
  int i;
  c_classreg_learning_coder_class Mdl7;
  signed char I[4];
  for (i = 0; i < 2; i++) {
    Mdl7.ClassNames[i] = 4.0 * (double)i;
    Mdl7.ClassNamesLength[i] = 1;
  }

  CompactTree_CompactTree(&Mdl7);
  for (i = 0; i < 4; i++) {
    I[i] = 0;
  }

  for (i = 0; i < 2; i++) {
    I[i + (i << 1)] = 1;
  }

  for (i = 0; i < 4; i++) {
    Mdl7.Cost[i] = 1.0 - (double)I[i];
  }

  return c_CompactClassificationTree_pre(Mdl7.CutVar, Mdl7.Children,
    Mdl7.ClassProb, Mdl7.CutPoint, Mdl7.ClassNames, Mdl7.Cost, X);
}

//
// File trailer for predict_AFAL.cpp
//
// [EOF]
//
