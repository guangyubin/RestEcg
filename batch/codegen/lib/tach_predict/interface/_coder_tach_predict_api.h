/*
 * File: _coder_tach_predict_api.h
 *
 * MATLAB Coder version            : 3.4
 * C/C++ source code generated on  : 14-Aug-2018 16:01:54
 */

#ifndef _CODER_TACH_PREDICT_API_H
#define _CODER_TACH_PREDICT_API_H

/* Include Files */
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include <stddef.h>
#include <stdlib.h>
#include "_coder_tach_predict_api.h"

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

/* Function Declarations */
extern real_T tach_predict(real_T X[12]);
extern void tach_predict_api(const mxArray * const prhs[1], const mxArray *plhs
  [1]);
extern void tach_predict_atexit(void);
extern void tach_predict_initialize(void);
extern void tach_predict_terminate(void);
extern void tach_predict_xil_terminate(void);

#endif

/*
 * File trailer for _coder_tach_predict_api.h
 *
 * [EOF]
 */
