//
// File: tach_predict.cpp
//
// MATLAB Coder version            : 3.4
// C/C++ source code generated on  : 14-Aug-2018 16:01:54
//

// Include Files
#include "rt_nonfinite.h"
#include "tach_predict.h"
#include "CompactClassificationTree.h"
#include "CompactTree.h"

// Function Definitions

//
// Arguments    : const double X[12]
// Return Type  : double
//
double tach_predict(const double X[12])
{
  int i;
  c_classreg_learning_coder_class Mdl7;
  signed char I[25];
  for (i = 0; i < 5; i++) {
    Mdl7.ClassNames[i] = 1.0 + (double)i;
    Mdl7.ClassNamesLength[i] = 1;
  }

  CompactTree_CompactTree(&Mdl7);
  for (i = 0; i < 25; i++) {
    I[i] = 0;
  }

  for (i = 0; i < 5; i++) {
    I[i + 5 * i] = 1;
  }

  for (i = 0; i < 25; i++) {
    Mdl7.Cost[i] = 1.0 - (double)I[i];
  }

  return c_CompactClassificationTree_pre(Mdl7.CutVar, Mdl7.Children,
    Mdl7.ClassProb, Mdl7.CutPoint, Mdl7.ClassNames, Mdl7.Cost, X);
}

//
// File trailer for tach_predict.cpp
//
// [EOF]
//
