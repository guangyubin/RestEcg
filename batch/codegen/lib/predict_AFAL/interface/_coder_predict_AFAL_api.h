/*
 * File: _coder_predict_AFAL_api.h
 *
 * MATLAB Coder version            : 3.4
 * C/C++ source code generated on  : 15-Aug-2018 16:03:15
 */

#ifndef _CODER_PREDICT_AFAL_API_H
#define _CODER_PREDICT_AFAL_API_H

/* Include Files */
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include <stddef.h>
#include <stdlib.h>
#include "_coder_predict_AFAL_api.h"

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

/* Function Declarations */
extern real_T predict_AFAL(real_T X[12]);
extern void predict_AFAL_api(const mxArray * const prhs[1], const mxArray *plhs
  [1]);
extern void predict_AFAL_atexit(void);
extern void predict_AFAL_initialize(void);
extern void predict_AFAL_terminate(void);
extern void predict_AFAL_xil_terminate(void);
extern real_T predict_tach(real_T X[12]);
extern void predict_tach_api(const mxArray * const prhs[1], const mxArray *plhs
  [1]);

#endif

/*
 * File trailer for _coder_predict_AFAL_api.h
 *
 * [EOF]
 */
