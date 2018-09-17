#ifndef __AHA_ECG_DIAG_H__
#define __AHA_ECG_DIAG_H__

#include "Binary.h"
#include <string>
#include "base_type.h"
using namespace std;

namespace aha_ecg
{
	#define Primary_Max_Class   20
	enum Primary
	{
		Overall_Interpreation = 0,
		Technical = 1,
		SinusNode_Arrhymias = 2,
		Supravntricular_Arrhythmias = 3,
		Supravntricular_Tachyarrhythmias = 4,
		Ventricular_Arrhythmias = 5,
		Ventricular_Tachyarrhythmias = 6,
		Atriventricular_Conduction = 7,
		Intraventricular_Intra_Atrial_Conduction = 8,
		Axis_Voltage = 9,
		Chamber_Hypertrophy_Enlargement = 10,
		ST_Segment_T_U_Wave = 11,
		Myocardial_Infarction = 12,
		Pacemaker = 13,
		QAbnormal = 14,
		STAbnormal = 15,
		TAbnormal = 16,
		ST_TAbnormal = 17
	};


typedef struct {
	int     primary_code;
	char    description[150];
	char    description_CH[150];
}Diagnostic_Description;


#define	BIT0	0
#define	BIT1	1
#define	BIT2	2
#define	BIT3	3
#define	BIT4	4
#define	BIT5	5
#define	BIT6	6
#define	BIT7	7
#define	BIT8	8
#define	BIT9	9
#define	BIT10	10
#define	BIT11	11
#define	BIT12	12
#define	BIT13	13
#define	BIT14	14
#define	BIT15	15
#define	BIT16	16
#define	BIT17	17
#define	BIT18	18
#define	BIT19	19
#define	BIT20	20
#define	BIT21	21
#define	BIT22	22
#define	BIT23	23
#define	BIT24	24
#define	BIT25	25
#define	BIT26	26
#define	BIT27	27
#define	BIT28	28
#define	BIT29	29
#define	BIT30	30
#define	BIT31	31


#define SetBit( x, nbit)		(x |= (1 << nbit))
	//******************************************************************************
	//Overall_Interpreation
	//******************************************************************************
#define	Normal_ECG	BIT0
#define	Otherwise_Normal_ECG	BIT1
#define	Abnormal_ECG	BIT2
#define	Uninterpretable_ECG	BIT3
//******************************************************************************
//Technical
//******************************************************************************

#define	Extremity_Electrode_Reversal	BIT0
#define	Misplaced_Precordial_Electrode	BIT1
#define	Missing_Lead	BIT2
#define	RightSided_Precordial_Electrode	BIT3
#define	Atrifact	BIT4
#define	Poor_Quality_Data	BIT5
#define	Posterior_Electrode	BIT6

//*******************************************************************************
//SinusNode_Arrhymias
//*******************************************************************************
#define	Sinus_Rhythm	BIT0
#define	Sinus_Tachycardia	BIT1
#define	Sinus_Bradycardia	BIT2
#define	Sinus_Arrhythmia	BIT3
#define	Sinoatrial_Block_I	BIT4
#define	Sinoatrial_Block_II	BIT5
#define	Sinus_Pause_Arrest	BIT6
#define	Uncertain_Supraventricular_Rhythm	BIT7
#define Long_RR_interval	BIT8

//******************************************************************************
// Supraventricular arrhythmias 
//******************************************************************************
#define	Atrial_Premature_Complex	BIT0
#define	Atrial_Premature_Nonconducted	BIT1
#define	Retrograde_Atrial_Activation	BIT2
#define	Wandering_Atrial_Pacemaker	BIT3
#define	Ectopic_Atrial_Rhythm	BIT4
#define	Ectopic_Atrial_Rhythm_Multifocal	BIT5
#define	Junctional_Premature	BIT6
#define	Junctional_Escape	BIT7
#define	Junctional_Rhythm	BIT8
#define	Accelerated_Junctional_Rhythm	BIT9
#define	Supraventricular_Rhythm	BIT10
#define	Supraventricular_Complex	BIT11
#define	Bradycardia_Nonsinus	BIT12
#define Atrial_Premature_Paired	BIT13
#define Atrial_Premature_Bigeminy	BIT14
#define Atrial_Premature_Trigeminy	BIT15
#define Atrial_Premature_Aberrant 	BIT16




//******************************************************************************
//Supravntricular_Tachyarrhythmias
//******************************************************************************
#define	Atrial_Fibrillation	BIT0
#define	Atrial_Flutter	BIT1
#define	Ectopic_Atrial_Tachycardia_Unifocal	BIT2
#define	Ectopic_Atrial_Tachycardia_Multifocal	BIT3
#define	Junctional_Aachycardia	BIT4
#define	Supraventricular_Tachycardia	BIT5
#define	Narrow_QRS_Tachycardia	BIT6

//******************************************************************************
//Ventricular arrhythmias
//******************************************************************************
#define	Ventricular_Premature_Complex	BIT0
#define	Fusion_complex	BIT1
#define	Ventricular_escape_complex	BIT2
#define	Idioventricular_rhythm	BIT3
#define	Accelerated_idioventricular_rhythm	BIT4
#define	Fascicular_rhythm	BIT5
#define	Parasystole	BIT6
#define Ventricular_Premature_Paired	BIT7
#define Ventricular_Premature_Bigeminy	BIT8
#define Ventricular_Premature_Trigeminy	BIT9

//******************************************************************************
//		Ventricular tachyarrhythmias
//******************************************************************************

#define	Ventricular_tachycardia	BIT0
#define	Ventricular_tachycardia_unsustained	BIT1
#define	Ventricular_tachycardia_polymorphous	BIT2
#define	Ventricular_tachycardia_torsades_de_pointes	BIT3
#define	Ventricular_fibrillation	BIT4
#define	Fascicular_tachycardia	BIT5
#define	Wide_QRS_tachycardia	BIT6
//******************************************************************************
//	Atrioventricular conduction
//******************************************************************************

#define	Short_PR_interval	BIT0
#define	AV_conduction_ratio_ND	BIT1
#define	Prolonged_PR_interval	BIT2
#define	AV_block_Mobitz_typeI 	BIT3
#define	AV_block_Mobitz_typeII	BIT4
#define	AV_block_2_1	BIT5
#define	AV_block_varying_conduction	BIT6
#define	AV_block_advanced	BIT7
#define	AV_block_complete 	BIT8
#define	AV_dissociation	BIT9
//******************************************************************************
//Intraventricular and intra - atrial conduction
//******************************************************************************

#define	Aberrant_conduction_of_supraventricular_beat	BIT0
#define	Left_anterior_fascicular_block	BIT1
#define	Left_posterior_fascicular_block	BIT2
#define	Left_bundle_branch_block	BIT4
#define	Incomplete_right_bundle_branch_block	BIT5
#define	Right_bundle_branch_block	BIT6
#define	Intraventricular_conduction_delay	BIT7
#define	Ventricular_preexcitation	BIT8
#define	Right_atrial_conduction_abnormality	BIT9
#define	Left_atrial_conduction_abnormality	BIT10
#define	Epsilon_wave	BIT11
//******************************************************************************
//Axis and voltage
//******************************************************************************

#define	Right_axis_deviation	BIT0
#define	Left_axis_deviation	BIT1
#define	Right_superior_axis	BIT2
#define	Indeterminate_axis	BIT3
#define	Electrical_alternans	BIT4
#define	Low_voltage	BIT5
#define	Abnormal_precordial_R_wave_progression	BIT6
#define	Abnormal_P_wave_axis	BIT7
#define Left_Ventricular_High_Voltage    BIT8
#define  Right_Ventricular_High_Voltage   BIT9
//******************************************************************************
//Chamber hypertrophy or enlargement
//******************************************************************************

#define	Left_atrial_enlargement	BIT0
#define	Right_atrial_enlargement	BIT1
#define	Left_ventricular_hypertrophy	BIT2
#define	Right_ventricular_hypertrophy	BIT3
#define	Biventricular_hypertrophy	BIT4
//******************************************************************************
//L.ST segment, T wave, and U wave
//******************************************************************************

#define ST_Deviation                                   BIT0
#define ST_Deviation_T_wave_change                     BIT1
#define T_wave_abnormality                             BIT2
#define Prolonged_QT_Interval                          BIT3
#define Short_QT_Interval                              BIT4
#define Prominent_Uwaves                               BIT5
#define Inverted_Uwaves                                BIT6
#define TU_fusion                                      BIT7
#define ST_T_change_ventricular_hypertrophy            BIT8
#define Osborn_wave                                    BIT9
#define Early_repolarization                           BIT10


//******************************************************************************
//Myocardial infarction
//******************************************************************************
#define	Anterior_MI	BIT0
#define	Inferior_MI	BIT1
#define	Posterior_MI	BIT2
#define	Lateral_MI	BIT3
#define	Anteroseptal_MI	BIT4
#define	Extensive_anterior_MI	BIT5
#define	MI_in_presence_of_left_bundle_branch_block	BIT6
#define	Right_ventricular_MI	BIT7
//******************************************************************************
//N Pacemaker
//******************************************************************************

#define	Atrial_paced_complex_or_rhythm	BIT0
#define	Ventricular_paced_complex_or_rhythm	BIT1
#define	Ventricular_pacing_of_non_right_ventricular_apical_origin	BIT2
#define	Atrial_sensed_ventricular_paced_complex_or_rhythm	BIT3
#define	AV_dual_paced_complex_or_rhythm	BIT4
#define	Failure_to_capture_atrial	BIT5
#define	Failure_to_capture_ventricular	BIT6
#define	Failure_to_inhibit_atrial	BIT7
#define	Failure_to_inhibit_ventricular	BIT8
#define	Failure_to_pace_atrial	BIT9
#define	Failure_to_pace_ventricular	BIT10

//******************************************************************************
//Modifiers  Arrhythmias and tachyarrhythmias
//******************************************************************************
#define	Modifiers_Couplets	BIT16
#define	Modifiers_Bigeminy	BIT17
#define	Modifiers_Trigeminy	BIT18
#define	Modifiers_Monomorphic	BIT19
#define	Modifiers_Multifocal	BIT20
#define	Modifiers_Unifocal	BIT21
#define	Modifiers_With_rapid_ventricular_response	BIT22
#define	Modifiers_With_slow_ventricular_response	BIT23
#define	Modifiers_With_capture_beat	BIT24
#define	Modifiers_With_aberrancy	BIT25
#define	Modifiers__Polymorphic	BIT26


//******************************************************************************
//Beat Type
//******************************************************************************
enum ECGBeatType{
Sinus_Type = 0,                           // N
Ventricular_Type = 1,                     // V
Supraventricular_Type = 2,                // S
};



// 导联定义
#define   Lead_I      0
#define   Lead_II     1
#define   Lead_III    2
#define   Lead_avR    3
#define   Lead_avL    4
#define   Lead_avF    5
#define   Lead_V1     6
#define   Lead_V2     7
#define   Lead_V3     8
#define   Lead_V4     9
#define   Lead_V5     10
#define   Lead_V6     11


/**************************************************************************************************************
QRS 形态
***************************************************************************************************************/

enum Q_Morph_Type {
	Q_Morph_0 = -1,
	Q_Morph_q = 0,
	Q_Morph_Q = 1,

};

enum S_Morph_Type {
	S_Morph_0 = -1,
	S_Morph_s = 0,
	S_Morph_S = 1,

};

enum R_Morph_Type {
	R_Morph_0 = -1,
	R_Morph_r = 0,
	R_Morph_R = 1,
	R_Morph_rR = 2,
	R_Morph_Rr = 3,
	R_Morph_RR = 3,

};

enum QRS_Morph_Type {
	QRS_Morph_0 = -1,
	QRS_Morph_QS = 0,
	QRS_Morph_QR = 1,
	QRS_Morph_Qr = 2,
	QRS_Morph_Qrs = 3,
	QRS_Morph_qRS = 4,
	QRS_Morph_QrS = 5,
	QRS_Morph_qrS = 6,
	QRS_Morph_QRs = 7,
	QRS_Morph_rS = 8,
	QRS_Morph_RS,
	QRS_Morph_qRs,
	QRS_Morph_R,
	QRS_Morph_Rs,
	QRS_Morph_Rr,
	QRS_Morph_rR,
	QRS_Morph_rsr,
	QRS_Morph_rSr,
	QRS_Morph_qRr,
};

typedef struct tag_QRS_Morph
{
	Q_Morph_Type  _q_morph_type;
	R_Morph_Type  _r_morph_type;
	S_Morph_Type  _s_morph_type;
	QRS_Morph_Type  _qrs_morph_type;
	char            _qrs_type[10];
}QRS_Morph;

/**************************************************************************************************************
ST-T 形态
***************************************************************************************************************/
/*enum ST_Morph
{
ST_
};*/

/**************************************************************************************************************
测量矩阵
***************************************************************************************************************/
typedef struct tag_WaveMeasurement {
	int   PA;      // P波幅度
	int   PPA;    // P'波幅度
	int   QA;      // Q波幅度
	int   QD;      // Q波宽度
	int   RA;      // R波幅度
	int   RD;      // R波宽度
	int   SA;      // S波幅度
	int   SD;      // R波宽度
	int   RPA;     // R'波幅度
	int   RPD;     // R'波宽度
	int   SPA;     // S'波幅度
	int   STJ;     // ST J点
	int   STM;     // ST均值（不确定）
	int   STE;     // ST抬高（不确定）
	int   TA;      // T波幅度
	int   TPA;     // T波最大幅度

}WaveMeasurement;



typedef struct tag_MedianMeasureResult
{
	QRS_Morph		_qrs_morph_type;
	WaveMeasurement _wave_measurement;
}MedianMeasureResult;

/**************************************************************************************************************
AHA_ECG_Helper
***************************************************************************************************************/
//class AHA_ECG_Helper
//{
//public:
//static string  Get_Ventricular_Arrhythmias_Desp(int type);
//static string  Get_IntraVentricularConduction_Desp(int type);
//static string  Get_Supravntricular_Tachyarrhythmias_Desp(int type);
//};

string parase_diagnostic_array(int *diag, int lag =1);

}
#endif