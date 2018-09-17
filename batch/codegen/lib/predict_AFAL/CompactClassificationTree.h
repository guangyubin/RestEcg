//
// File: CompactClassificationTree.h
//
// MATLAB Coder version            : 3.4
// C/C++ source code generated on  : 15-Aug-2018 16:03:15
//
#ifndef COMPACTCLASSIFICATIONTREE_H
#define COMPACTCLASSIFICATIONTREE_H

// Include Files
#include <stddef.h>
#include <stdlib.h>
#include <string.h>
#include "rt_nonfinite.h"
#include "rtwtypes.h"
#include "predict_AFAL_types.h"

// Function Declarations
extern double c_CompactClassificationTree_pre(const double obj_CutVar[309],
  const double obj_Children[618], const double obj_ClassProb[618], const double
  obj_CutPoint[309], const double obj_ClassNames[2], const double obj_Cost[4],
  const double X[12]);
extern double d_CompactClassificationTree_pre(const double obj_CutVar[621],
  const double obj_Children[1242], const double obj_ClassProb[3105], const
  double obj_CutPoint[621], const double obj_ClassNames[5], const double
  obj_Cost[25], const double X[12]);

#endif

//
// File trailer for CompactClassificationTree.h
//
// [EOF]
//
