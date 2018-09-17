//
// File: CompactClassificationTree.cpp
//
// MATLAB Coder version            : 3.4
// C/C++ source code generated on  : 14-Aug-2018 16:01:54
//

// Include Files
#include "rt_nonfinite.h"
#include "tach_predict.h"
#include "CompactClassificationTree.h"

// Function Definitions

//
// Arguments    : const double obj_CutVar[621]
//                const double obj_Children[1242]
//                const double obj_ClassProb[3105]
//                const double obj_CutPoint[621]
//                const double obj_ClassNames[5]
//                const double obj_Cost[25]
//                const double X[12]
// Return Type  : double
//
double c_CompactClassificationTree_pre(const double obj_CutVar[621], const
  double obj_Children[1242], const double obj_ClassProb[3105], const double
  obj_CutPoint[621], const double obj_ClassNames[5], const double obj_Cost[25],
  const double X[12])
{
  double m;
  static const signed char pruneList[621] = { 114, 111, 113, 110, 103, 112, 97,
    105, 107, 26, 85, 109, 99, 79, 66, 104, 0, 92, 96, 0, 0, 85, 69, 105, 108,
    95, 70, 0, 38, 66, 66, 0, 93, 92, 88, 75, 58, 85, 38, 48, 7, 102, 0, 0, 106,
    83, 95, 57, 0, 0, 23, 33, 0, 34, 66, 86, 93, 50, 65, 48, 37, 0, 49, 58, 31,
    85, 78, 0, 38, 48, 38, 0, 0, 101, 102, 81, 74, 0, 0, 89, 0, 0, 0, 0, 0, 0,
    27, 34, 22, 66, 39, 84, 80, 93, 48, 26, 0, 65, 9, 0, 35, 26, 26, 40, 19, 44,
    0, 0, 0, 56, 36, 0, 38, 0, 38, 0, 0, 18, 0, 100, 0, 98, 19, 81, 20, 50, 52,
    59, 0, 0, 0, 0, 0, 22, 22, 0, 47, 0, 0, 73, 48, 45, 80, 82, 53, 23, 26, 0, 0,
    16, 61, 0, 0, 0, 0, 20, 0, 0, 0, 9, 17, 3, 0, 27, 9, 21, 0, 36, 0, 10, 0, 0,
    0, 0, 18, 94, 100, 72, 54, 0, 14, 81, 0, 20, 8, 0, 34, 34, 52, 59, 37, 0, 0,
    22, 0, 0, 27, 11, 0, 0, 0, 0, 45, 48, 60, 79, 82, 26, 0, 0, 0, 0, 15, 0, 11,
    0, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 0, 0, 0, 0, 0, 36, 0, 10, 18, 0, 0, 94,
    87, 87, 7, 0, 0, 0, 14, 0, 77, 71, 0, 0, 8, 0, 0, 0, 34, 0, 23, 0, 59, 17, 0,
    0, 0, 22, 0, 7, 0, 0, 43, 45, 38, 0, 0, 43, 68, 0, 34, 82, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 18, 18, 94, 88, 72, 0, 62, 0, 0, 0, 0, 0, 27, 77, 0,
    0, 0, 8, 0, 0, 0, 0, 23, 0, 0, 17, 0, 0, 0, 0, 34, 43, 0, 0, 38, 0, 29, 43,
    0, 55, 0, 0, 0, 67, 18, 7, 18, 0, 88, 91, 38, 76, 17, 0, 62, 54, 0, 11, 30,
    20, 0, 0, 0, 0, 13, 0, 24, 34, 27, 17, 7, 0, 17, 0, 0, 43, 55, 41, 53, 20, 0,
    0, 0, 0, 0, 0, 47, 0, 91, 79, 11, 0, 0, 0, 0, 0, 0, 61, 7, 0, 0, 11, 0, 25,
    11, 0, 0, 13, 24, 0, 17, 0, 0, 0, 0, 0, 0, 0, 0, 7, 43, 41, 0, 48, 34, 0, 0,
    32, 0, 0, 27, 0, 23, 90, 23, 70, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 13,
    0, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 34, 5, 32, 0, 11, 0, 0, 0, 72, 0, 0, 0,
    0, 64, 0, 0, 0, 0, 0, 24, 0, 0, 0, 5, 0, 0, 11, 0, 0, 20, 63, 0, 7, 24, 0, 5,
    0, 0, 0, 7, 63, 42, 0, 1, 0, 24, 0, 0, 0, 7, 63, 46, 0, 0, 1, 0, 24, 24, 7,
    0, 63, 63, 46, 0, 1, 0, 24, 24, 0, 0, 0, 0, 17, 0, 51, 25, 46, 0, 0, 1, 24,
    0, 4, 24, 0, 7, 0, 34, 0, 0, 0, 46, 1, 0, 6, 24, 4, 4, 0, 21, 0, 7, 0, 20,
    17, 46, 0, 0, 2, 0, 21, 24, 0, 4, 0, 0, 0, 0, 0, 7, 11, 0, 0, 0, 0, 46, 0, 2,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 46, 12, 2, 0, 0, 0, 0, 46, 12, 0, 0, 2, 46, 46,
    12, 0, 0, 0, 42, 0, 0, 0, 0, 12, 0, 0, 0, 0 };

  int ixstart;
  double scores[5];
  double unusedU4[5];
  int itmp;
  int ix;
  boolean_T exitg1;
  m = 1.0;
  while ((m <= 621.0) && (!(pruneList[(int)m - 1] <= 0)) && (!rtIsNaN(X[(int)
           obj_CutVar[(int)m - 1] - 1]))) {
    if (X[(int)obj_CutVar[(int)m - 1] - 1] < obj_CutPoint[(int)m - 1]) {
      m = obj_Children[((int)m - 1) << 1];
    } else {
      m = obj_Children[1 + (((int)m - 1) << 1)];
    }
  }

  for (ixstart = 0; ixstart < 5; ixstart++) {
    scores[ixstart] = obj_ClassProb[((int)m + 621 * ixstart) - 1];
  }

  for (ixstart = 0; ixstart < 5; ixstart++) {
    unusedU4[ixstart] = 0.0;
    for (itmp = 0; itmp < 5; itmp++) {
      unusedU4[ixstart] += scores[itmp] * obj_Cost[itmp + 5 * ixstart];
    }
  }

  ixstart = 1;
  m = unusedU4[0];
  itmp = 0;
  if (rtIsNaN(unusedU4[0])) {
    ix = 2;
    exitg1 = false;
    while ((!exitg1) && (ix < 6)) {
      ixstart = ix;
      if (!rtIsNaN(unusedU4[ix - 1])) {
        m = unusedU4[ix - 1];
        itmp = ix - 1;
        exitg1 = true;
      } else {
        ix++;
      }
    }
  }

  if (ixstart < 5) {
    while (ixstart + 1 < 6) {
      if (unusedU4[ixstart] < m) {
        m = unusedU4[ixstart];
        itmp = ixstart;
      }

      ixstart++;
    }
  }

  return obj_ClassNames[itmp];
}

//
// File trailer for CompactClassificationTree.cpp
//
// [EOF]
//
