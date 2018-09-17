#ifndef __LIB__REST___ECT___H__
#define __LIB__REST___ECT___H__

#define LIB_OUTPUT

#ifdef LIB_OUTPUT
#define MGCLIB_API
#else
#ifdef MGCLIB_EXPORTS
#define MGCLIB_API __declspec(dllexport)
#else
#define MGCLIB_API __declspec(dllimport)
#endif
#endif 


 

#include <vector>
#include <string.h>
using namespace std;

//#include "restecg/AHA_ECG_Diag.h"

struct restecg_meas
{
	int VentricularRate;
	int AtrialRate;
	int PRInterval;
	int QRSDuration;
	int QTInterval;
	int QTCorrected;
	int PAxis;
	int RAxis;
	int TAxis;
	int QRSCount;
	int BeatPos[50];
	int BeatType[50];
	int MedianWave[250*8];
	int SmapleRateBase;
	int Diag[20];

};

/*=========================================================================================
Input:
data:      10秒8导联的心电数据，nsmp*nchan
排列方式：  CH0(0)----CH0(nsmp)  CH1(0)-CH1(nsmp)   CH2(0)-CH2(nsmp)
datalen：  数据的采样点数, 5000或者2500
nchan:     通道数
gain:      x/gain后的单位为mV
fs :       数据采样率， 目前采样率必须为250Hz的整数倍

Output: restecg_meas_medextech
算法内核以250Hz采样率进行计算，

============================================================================================*/
struct restecg_meas_medextech
{
	int VentricularRate;
	int AtrialRate;
	int PRInterval;
	int QRSDuration;
	int QTInterval;
	int QTCorrected;
	int PAxis;
	int RAxis;
	int TAxis;
	int resv[100];
	int DiagnosticArray[20];
	int MeasMatrix[32 * 16];
	int QOnset;
	int	QOffset;
	int	POnset;
	int	POffset;
	int	TOffset;
	int MedianWave[500 * 16];
	int QRSCount;
	int BeatPos[500];
	int BeatType[500];
};

MGCLIB_API string medextech_parase_diagnostic_array(int *diag, int lag = 1);
MGCLIB_API  int medextech_restecg_process(int *data, int nsmp, int nchan, float gain, int fs, restecg_meas_medextech * meas);
MGCLIB_API  int medextech_restecg_version();
MGCLIB_API  vector<int>  medextech_restecg_QrsDetector(int *ecg, int nsmp, int nchan, float gain, int fs);

// 输入ecg， 1个通道的数据，采样率为250Hz，数据长度为250个点。
// QRS位置-400ms ： QRS+600ms 
// rr: 这一段心电图的rr间期， 单位为ms。 如果未知，设为800ms
// OUT:  Ponset , Poffset, Qonset, Qoffst , Toffset
MGCLIB_API void medextech_restecg_ptdetector(int *ecg, int rr , float gain, int *out);
#endif
