#include "AHA_ECG_Diag.h"
using namespace aha_ecg;

const char Default_Description[] = "";
/************************************************************************************************************************************
AAAAAAAAAA
*************************************************************************************************************************************/
Diagnostic_Description  A_Overall_Interpreation_Desp[] = {
{ Normal_ECG,                            "Normal_ECG"  ,                     "正常心电图"         },
{ Otherwise_Normal_ECG,                  "Otherwise_Normal_ECG" ,            "其它正常心电图"     },
{ Abnormal_ECG, 	                     "Abnormal_ECG" ,                    "异常心电图"         },
};
/************************************************************************************************************************************
B
*************************************************************************************************************************************/
Diagnostic_Description  B_Technical_Desp[] = {
{ Extremity_Electrode_Reversal,          "Extremity_Electrode_Reversal" ,    "肢体导联反接"       },
{ Misplaced_Precordial_Electrode,        "Misplaced_Precordial_Electrode" ,  "胸导联位置错误"     },
{ Missing_Lead, 	                     "Missing_Lead",                     "导联脱落"           },
{ RightSided_Precordial_Electrode, 	     "RightSided_Precordial_Electrode",  "右心前区导联"       },
{ Atrifact, 	                         "Atrifact" ,                        "人工伪差"           },
{ Poor_Quality_Data, 	                 "Poor_Quality_Data",                "数据质量差"         },
{ Posterior_Electrode, 	                 "Posterior_Electrode",              "后壁导联"           },
};
/************************************************************************************************************************************
C
*************************************************************************************************************************************/
Diagnostic_Description  C_Sinus_Rhythm_Desp[] = {
{ Sinus_Rhythm,                          "Sinus_Rhythm" ,                    "窦性心律"           },
{ Sinus_Tachycardia,                     "Sinus_Tachycardia",                "窦性心动过速"       },
{ Sinus_Bradycardia, 	                 "Sinus_Bradycardia",                "窦性心动过缓"       },
{ Sinus_Arrhythmia, 	                 "Sinus_Arrhythmia",                 "窦性心律失常"       },
{ Sinoatrial_Block_I, 	                 "Sinoatrial_Block_I",               "一度窦房阻滞"       },
{ Sinoatrial_Block_II, 	                 "Sinoatrial_Block_II",              "二度窦房阻滞"       },
{ Sinus_Pause_Arrest, 	                 "Sinus_Pause_Arrest",               "窦性停搏"           },
{ Uncertain_Supraventricular_Rhythm, 	"Uncertain_Supraventricular_Rhythm",  "不确定性室上性心律"},
};

/************************************************************************************************************************************
D
*************************************************************************************************************************************/
Diagnostic_Description  D_Supravntricular_Arrhythmias_Desp[] = {
{ Atrial_Premature_Complex,             "Atrial_Premature_Complex" ,          "房性早搏"           },
{ Atrial_Premature_Nonconducted,        "Atrial_Premature_Nonconducted" ,     "房性早搏未下传"     },
{ Retrograde_Atrial_Activation, 	    "Retrograde_Atrial_Activation",       "折返性房性早搏"     },
{ Wandering_Atrial_Pacemaker, 	        "Wandering_Atrial_Pacemaker",         "不稳定性心房起搏"   },
{ Ectopic_Atrial_Rhythm, 	            "Ectopic_Atrial_Rhythm",              "心房异位节律"       },
{ Ectopic_Atrial_Rhythm_Multifocal, 	"Ectopic_Atrial_Rhythm_Multifocal",   "多源性心房异位节律" },
{ Junctional_Premature, 	            "Junctional_Premature",               "交界性早搏"         },
{ Junctional_Escape, 	                "Junctional_Escape",                  "交界性逸搏"         },
{ Junctional_Rhythm, 	                "Junctional_Rhythm",                  "交界性心律"         },
{ Accelerated_Junctional_Rhythm, 	    "Accelerated_Junctional_Rhythm",      "加速交界性心律"     },
{ Supraventricular_Rhythm, 	            "Supraventricular_Rhythm",            "室上性心律"         },
{ Supraventricular_Complex, 	        "Supraventricular_Complex",           "室上性"             },
{ Bradycardia_Nonsinus, 	            "Bradycardia_Nonsinus",               "非窦性心动过缓"     },
{ Atrial_Premature_Paired, 	            "Atrial_Premature_Paired",            "成对房早"           },// 非指南
{ Atrial_Premature_Bigeminy, 	        "Atrial_Premature_Bigeminy" ,         "房早成二联律"       },//非指南
{ Atrial_Premature_Trigeminy, 	        "Atrial_Premature_Trigeminy" ,        "房早成三联律"       },//非指南
{ Atrial_Premature_Aberrant, 	        "Atrial_Premature_Aberrant" ,         "房早伴差传"         },//非指南

};
/************************************************************************************************************************************
E
*************************************************************************************************************************************/
Diagnostic_Description  E_Supravntricular_Tachyarrhythmias_Desp[] = {
{ Atrial_Fibrillation,                  "Atrial_Fibrillation",                   "心房颤动"          },
{ Atrial_Flutter	,                   "Atrial_Flutter",                        "心房扑动"          },
{ Ectopic_Atrial_Tachycardia_Unifocal , "Ectopic_Atrial_Tachycardia_Unifocal",   "单源性异位房性心动过速" },
{ Ectopic_Atrial_Tachycardia_Multifocal,"Ectopic_Atrial_Tachycardia_Multifocal", "多源性异位房性心动过速" },
{ Junctional_Aachycardia ,               "Junctional_Aachycardia",               "交界性心动过速"   },
{ Supraventricular_Tachycardia ,         "Supraventricular_Tachycardia",         "室上性心动过速" },
{ Narrow_QRS_Tachycardia ,               "Narrow_QRS_Tachycardia",               "窄QRS波群心动过速" }
};

/************************************************************************************************************************************
F
*************************************************************************************************************************************/
Diagnostic_Description  F_Ventricular_Arrhythmias_Desp[] = {
{ Ventricular_Premature_Complex,          "Ventricular_Premature_Complex",      "室性早搏"           },
{ Fusion_complex, 				           "Fusion_complex",                    "融合波"             },
{ Ventricular_escape_complex, 	           "Ventricular_escape_complex",        "室性逸搏"           },
{ Idioventricular_rhythm, 	           	   "Idioventricular_rhythm",            "室性自主心律"       },
{ Accelerated_idioventricular_rhythm, 	   "Accelerated_idioventricular_rhythm", "加速性室性自主心律" },
{ Fascicular_rhythm, 	                   "Fascicular_rhythm",                  "分支性节律"        },
{ Parasystole, 	           				   "Parasystole",                        "并行收缩"           },
{ Ventricular_Premature_Paired, 	       "Ventricular_Premature_Paired" ,      "成对室性早搏"},
{ Ventricular_Premature_Bigeminy, 	       "Ventricular_Premature_Bigeminy",     "室性早搏成二联律" },
{ Ventricular_Premature_Trigeminy, 	       "Ventricular_Premature_Trigeminy",    "室性早搏成三联律" },

};
/************************************************************************************************************************************
G
*************************************************************************************************************************************/
Diagnostic_Description  G_Ventricular_Tachyarrhythmias_Desp[] = {
	{ Ventricular_tachycardia,                 "Ventricular_tachycardia" ,                    "室性心动过速"},
{ Ventricular_tachycardia_unsustained, 	       "Ventricular_tachycardia_unsustained",         "非持续性室性心动过速" },
{ Ventricular_tachycardia_polymorphous,         "Ventricular_tachycardia_polymorphous" ,      "多源性室性心动过速" },
{ Ventricular_tachycardia_torsades_de_pointes, "Ventricular_tachycardia_torsades_de_pointes", "尖端扭转型室性心动过速" },
{ Ventricular_fibrillation, 	               "Ventricular_fibrillation",                    "心室颤动" },
{ Fascicular_tachycardia, 	           		   "Fascicular_tachycardia",                      "分支性心动过速" },
{ Wide_QRS_tachycardia, 	                    "Wide_QRS_tachycardia",                       "宽QRS波心动过速" },
};
/************************************************************************************************************************************
H
*************************************************************************************************************************************/
Diagnostic_Description  H_Atriventricular_Conduction_Desp[] = {
{ Short_PR_interval,          "Short_PR_interval",                          "PR间期过短" },
{ AV_conduction_ratio_ND, 		  "AV_conduction_ratio_ND",		            "房室传导比N:D" },
{ Prolonged_PR_interval, 	       "Prolonged_PR_interval",    	            "PR间期延长" },
{ AV_block_Mobitz_typeI, 	       "AV_block_Mobitz_typeI",    	            "二度房室阻滞莫氏I型" },
{ AV_block_Mobitz_typeII, 	       "AV_block_Mobitz_typeII",                "II度传导阻滞莫氏II型" },
{ AV_block_2_1 ,                   "AV_block_2_1",                          "2：1房室传导" },
{ AV_block_varying_conduction, 	   "AV_block_varying_conduction",           "房室阻滞（不稳定传导）" },
{ AV_block_advanced, 	           	"AV_block_advanced",			        "高度房室阻滞" },
{ AV_block_complete ,               "AV_block_complete",                    "三度房室阻滞（完全性）"},
{ AV_dissociation, 	                "AV_dissociation",                      "房室分离" },
};


/************************************************************************************************************************************
I
*************************************************************************************************************************************/
Diagnostic_Description  I_IntraVentricularConduction_Desp[] = {
{ Aberrant_conduction_of_supraventricular_beat,        "Aberrant_conduction_of_supraventricular_beat",  "室上节律异常传导" },
{ Left_anterior_fascicular_block, 				       "Left_anterior_fascicular_block",         "左前分支阻滞" },
{ Left_posterior_fascicular_block, 	           	       "Left_posterior_fascicular_block",        "左后分支阻滞" },
{ Left_bundle_branch_block, 	           	            "Left_bundle_branch_block",              "左束支阻滞" },
{ Incomplete_right_bundle_branch_block, 	            "Incomplete_right_bundle_branch_block",  "不完全性右束支阻滞" },
{ Right_bundle_branch_block ,                          "Right_bundle_branch_block" ,             "右束支传导阻滞" },
{ Intraventricular_conduction_delay, 	               "Intraventricular_conduction_delay",      "室内差异性传导" },
{ Ventricular_preexcitation, 	           				"Ventricular_preexcitation" ,            "心室预激" },
{ Right_atrial_conduction_abnormality, 	               "Right_atrial_conduction_abnormality" ,   "右心房传导异常" },
{ Left_atrial_conduction_abnormality, 	               "Left_atrial_conduction_abnormality" ,    "左心房传导异常" },
{ Epsilon_wave, 	                                   "Epsilon_wave",                           "Epsilon波" },

};
//******************************************************************************
// J Axis and voltage
//******************************************************************************
Diagnostic_Description  J_Axis_Voltage_Desp[] = {
{ Right_axis_deviation,                                "Right_axis_deviation",                "电轴右偏" },
{ Left_axis_deviation, 				                   "Left_axis_deviation",                 "电轴左偏" },
{ Right_superior_axis, 	           	                   "Right_superior_axis",                 "右上电轴" },
{ Indeterminate_axis, 	           	                   "Indeterminate_axis",                  "不确定电轴" },
{ Electrical_alternans, 	                           "Electrical_alternans",                "电交替" },
{ Low_voltage ,                                        "Low_voltage" ,                        "低电压" },
{ Abnormal_precordial_R_wave_progression, 	           "Abnormal_precordial_R_wave_progression",      "心前区R波异常增高" },
{ Abnormal_P_wave_axis, 	           				    "Abnormal_P_wave_axis" ,              "P波电轴异常" },
{ Left_Ventricular_High_Voltage,                        "Left_Ventricular_High_Voltage",      "左心室高电压"},
{ Right_Ventricular_High_Voltage,                       "Right_Ventricular_High_Voltage",     "右心室高电压" },
};

//******************************************************************************
// K Chamber hypertrophy or enlargement
//******************************************************************************
Diagnostic_Description  K_Chamber_hypertrophy_Desp[] = {
	{ Left_atrial_enlargement,                                "Left_atrial_enlargement",                "左房肥大" },
{ Right_atrial_enlargement, 				              "Right_atrial_enlargement",               "右房肥大" },
{ Left_ventricular_hypertrophy, 	           	          "Left_ventricular_hypertrophy",           "左心室肥厚" },
{ Right_ventricular_hypertrophy, 	           	          "Right_ventricular_hypertrophy",          "右心室肥厚" },
{ Biventricular_hypertrophy, 	                          "Biventricular_hypertrophy",              "室间隔肥厚" },
};


//******************************************************************************
//L.ST segment, T wave, and U wave
//******************************************************************************
Diagnostic_Description  L_ST_T_U_Desp[] = {
{ ST_Deviation,                                "ST_Deviation",                               "ST段改变" },
{ ST_Deviation_T_wave_change, 				   "ST_Deviation_T_wave_change",                 "ST-T改变" },
{ T_wave_abnormality, 	           	           "T_wave_abnormality",                         "T波异常" },
{ Prolonged_QT_Interval, 	           	       "Prolonged_QT_Interval",                      "QT间期延长" },
{ Short_QT_Interval, 	                       "Short_QT_Interval",                          "短QT间期" },
{ Prominent_Uwaves ,                           "Prominent_Uwaves" ,                          "U波高尖" },
{ Inverted_Uwaves, 	                           "Inverted_Uwaves",                            "插入性U波" },
{ TU_fusion, 	           				       "TU_fusion" ,                                 "T波U波融合" },
{ ST_T_change_ventricular_hypertrophy, 	       "ST_T_change_ventricular_hypertrophy",        "心室肥厚所致的ST-T改变" },
{ Osborn_wave ,                                "Osborn_wave" ,                               "Osborn波" },
{ Early_repolarization, 	                   "Early_repolarization",                       "过早复极" },

};



//******************************************************************************
//M  Myocardial infarction
//******************************************************************************
Diagnostic_Description M_MyocardialInfarction_Desp[] = {
{ Anterior_MI,                                "Anterior_MI",                                         "前壁心肌梗死" },
{ Inferior_MI, 				                  "Inferior_MI",                                         "下壁心肌梗死" },
{ Posterior_MI, 	           	              "Posterior_MI",                                        "后壁心肌梗死" },
{ Lateral_MI, 	           	                  "Lateral_MI",                                          "侧壁心肌梗死" },
{ Anteroseptal_MI, 	                          "Anteroseptal_MI",                                     "前间壁心肌梗死" },
{ Extensive_anterior_MI, 	           	      "Extensive_anterior_MI",                               "广泛前壁心肌梗死" },
{ MI_in_presence_of_left_bundle_branch_block, "MI_in_presence_of_left_bundle_branch_block",          "心肌梗死合并左束支阻滞" },
{ Right_ventricular_MI, 	                  "Right_ventricular_MI",                                "右室心肌梗死" },

};


//******************************************************************************
//N Pacemaker
//******************************************************************************
Diagnostic_Description N_Pacemaker_Desp[] = {
{ Atrial_paced_complex_or_rhythm,                                "Atrial_paced_complex_or_rhythm",                            "心房起搏心律" },
{ Ventricular_paced_complex_or_rhythm, 				             "Ventricular_paced_complex_or_rhythm",                       "心室起搏心律" },
{ Ventricular_pacing_of_non_right_ventricular_apical_origin, 	 "Ventricular_pacing_of_non_right_ventricular_apical_origin", "非右室心尖来源的心室起搏" },
{ Atrial_sensed_ventricular_paced_complex_or_rhythm, 	         "Atrial_sensed_ventricular_paced_complex_or_rhythm",         "心房感知心室起搏波或节律" },
{ AV_dual_paced_complex_or_rhythm, 	                             "AV_dual_paced_complex_or_rhythm",                           "房室双腔起搏" },
{ Failure_to_capture_atrial, 	           	                     "Failure_to_capture_atrial",                                 "心房失夺获" },
{ Failure_to_capture_ventricular,                                "Failure_to_capture_ventricular",                           "心室失夺获" },
{ Failure_to_inhibit_atrial, 	                                  "Failure_to_inhibit_atrial",                                "心房感知不良" },
{ Failure_to_inhibit_ventricular, 	                             "Failure_to_inhibit_ventricular",                            "心室感知不良" },
{ Failure_to_pace_atrial, 	           	                         "Failure_to_pace_atrial",                                    "心房起搏不良" },
{ Failure_to_pace_ventricular,                                    "Failure_to_pace_ventricular",                              "心室起搏不良" },


};

//******************************************************************************
//O  Q波异常
//******************************************************************************
Diagnostic_Description O_Q_T_ST_Abnormal_Desp[] = {
{ Lead_I,                                "I",                        "I" },
{ Lead_II, 				                 "II",                       "II" },
{ Lead_III, 	                         "III",                      "III" },
{ Lead_avR, 	                         "avR",                      "aVR" },
{ Lead_avL, 	                         "avL",                      "aVL" },
{ Lead_avF, 	           	             "avF",                      "aVF" },
{ Lead_V1,                                "V1",                      "V1" },
{ Lead_V2, 	                              "V2",                      "V2" },
{ Lead_V3, 	                              "V3",                      "V3" },
{ Lead_V4, 	           	                  "V4",                      "V4" },
{ Lead_V5,                                "V5",                      "V5" },
{ Lead_V6,                                "V6",                      "V6" },

};





//Axis_Voltage = 9,
//Chamber_Hypertrophy_Enlargement = 10,
//ST_Segment_T_U_Wave = 11,
//Myocardial_Infarction = 12,
//Pacemaker = 13,//
//
//#define Ventricular_Arrhythmias_Desp_Len     (sizeof(Ventricular_Arrhythmias_Desp) / sizeof(Ventricular_Arrhythmias_Desp[0]))
//
//
//#define IntraVentricularConduction_Desp_Len  (sizeof(IntraVentricularConduction_Desp) / sizeof(IntraVentricularConduction_Desp[0]))
//
///************************************************************************************************************************************
//*************************************************************************************************************************************/
//
//
//#define Supravntricular_Tachyarrhythmias_Desp_Len  (sizeof(Supravntricular_Tachyarrhythmias_Desp) / sizeof(Supravntricular_Tachyarrhythmias_Desp[0]))
//
///************************************************************************************************************************************
//*************************************************************************************************************************************/
//
//string  AHA_ECG_Helper::Get_Ventricular_Arrhythmias_Desp(int type)
//{
//	string ret;
//	bool normal = true;
//	for (int i = 0; i < Ventricular_Arrhythmias_Desp_Len; i++)
//	{
//		int bit = Ventricular_Arrhythmias_Desp[i].primary_code;
//		int code = (type >> bit) & 1;
//		if (code > 0) {
//			ret += Ventricular_Arrhythmias_Desp[i].description;
//			ret += "\r\n";
//			normal = false;
//		}
//	}
//	if (normal == false)  return ret;
//	return  Default_Description;
//}
//
//string AHA_ECG_Helper::Get_IntraVentricularConduction_Desp(int type)
//{
//	string ret ;
//	bool normal = true;
//	for (int i = 0; i < IntraVentricularConduction_Desp_Len; i++)
//	{
//		int bit = IntraVentricularConduction_Desp[i].primary_code;
//		int code = (type >> bit) & 1;
//		if (code > 0) {
//			ret += IntraVentricularConduction_Desp[i].description;
//			ret += "\r\n";
//			normal = false;
//		}
//	}
//	if (normal == false)  return ret;
//	return  Default_Description;
//}
//
//string AHA_ECG_Helper::Get_Supravntricular_Tachyarrhythmias_Desp(int type)
//{
//	string ret;
//	bool normal = true;
//	for (int i = 0; i < Supravntricular_Tachyarrhythmias_Desp_Len; i++)
//	{
//		int bit = Supravntricular_Tachyarrhythmias_Desp[i].primary_code;
//		int code = (type >> bit) & 1;
//		if (code > 0) {
//			ret += Supravntricular_Tachyarrhythmias_Desp[i].description;
//			ret += "\r\n";
//			normal = false;
//		}
//	}
//	if (normal == false)  return ret;
//	return  Default_Description;
//}

string parase_diagnostic(const Diagnostic_Description *des,int len, int type , int lag)
{
	string ret;
	bool normal = true;


	for (int i = 0; i < len; i++)
	{
		int bit = des[i].primary_code;
		int code = (type >> bit) & 1;
		if (code > 0) {
			if(lag==1)
				ret += des[i].description;
			else
				ret += des[i].description_CH;
			ret += ";";
			normal = false;
		}
	}
	if (normal == false)  return ret;
	return  Default_Description;

}
string parase_diagnostic(const Diagnostic_Description *des, int len, string overall, int type, int lag)
{
	string ret;
	bool normal = true;

	ret = overall +"(";

	for (int i = 0; i < len; i++)
	{
		int bit = des[i].primary_code;
		int code = (type >> bit) & 1;
		if (code > 0) {
			if (lag == 1)
				ret += des[i].description;
			else
				ret += des[i].description_CH;
			ret += ",";
			normal = false;
		}
	}
	ret += ")";
	if (normal == false)  return ret;
	return  Default_Description;

}
string aha_ecg::parase_diagnostic_array(int *diag ,int lag )
{


	string sA = parase_diagnostic(A_Overall_Interpreation_Desp, sizeof(A_Overall_Interpreation_Desp) / sizeof(Diagnostic_Description), diag[Overall_Interpreation], lag);
	string sB = parase_diagnostic(B_Technical_Desp, sizeof(B_Technical_Desp) / sizeof(Diagnostic_Description), diag[Technical], lag);
	string sC = parase_diagnostic(C_Sinus_Rhythm_Desp, sizeof(C_Sinus_Rhythm_Desp) / sizeof(Diagnostic_Description), diag[SinusNode_Arrhymias], lag);
	string sD = parase_diagnostic(D_Supravntricular_Arrhythmias_Desp, sizeof(D_Supravntricular_Arrhythmias_Desp) / sizeof(Diagnostic_Description), diag[Supravntricular_Arrhythmias], lag);
	string sE = parase_diagnostic(E_Supravntricular_Tachyarrhythmias_Desp, sizeof(E_Supravntricular_Tachyarrhythmias_Desp) / sizeof(Diagnostic_Description), diag[Supravntricular_Tachyarrhythmias], lag);
	string sF = parase_diagnostic(F_Ventricular_Arrhythmias_Desp, sizeof(F_Ventricular_Arrhythmias_Desp) / sizeof(Diagnostic_Description), diag[Ventricular_Arrhythmias], lag);
	string sG = parase_diagnostic(G_Ventricular_Tachyarrhythmias_Desp, sizeof(G_Ventricular_Tachyarrhythmias_Desp) / sizeof(Diagnostic_Description), diag[Ventricular_Tachyarrhythmias], lag);
	string sH = parase_diagnostic(H_Atriventricular_Conduction_Desp, sizeof(H_Atriventricular_Conduction_Desp) / sizeof(Diagnostic_Description), diag[Atriventricular_Conduction], lag);
	string sI = parase_diagnostic(I_IntraVentricularConduction_Desp, sizeof(I_IntraVentricularConduction_Desp) / sizeof(Diagnostic_Description), diag[Intraventricular_Intra_Atrial_Conduction], lag);
	string sJ = parase_diagnostic(J_Axis_Voltage_Desp, sizeof(J_Axis_Voltage_Desp) / sizeof(Diagnostic_Description), diag[Axis_Voltage], lag);
	string sK = parase_diagnostic(K_Chamber_hypertrophy_Desp, sizeof(K_Chamber_hypertrophy_Desp) / sizeof(Diagnostic_Description), diag[Chamber_Hypertrophy_Enlargement], lag);
	string sL = parase_diagnostic(L_ST_T_U_Desp, sizeof(L_ST_T_U_Desp) / sizeof(Diagnostic_Description), diag[ST_Segment_T_U_Wave], lag);
	string sM = parase_diagnostic(M_MyocardialInfarction_Desp, sizeof(M_MyocardialInfarction_Desp) / sizeof(Diagnostic_Description), diag[Myocardial_Infarction], lag);
	string sN = parase_diagnostic(N_Pacemaker_Desp, sizeof(N_Pacemaker_Desp) / sizeof(Diagnostic_Description), diag[Pacemaker], lag);
	
	
	string sO1 = parase_diagnostic(O_Q_T_ST_Abnormal_Desp, sizeof(O_Q_T_ST_Abnormal_Desp) / sizeof(Diagnostic_Description), "Q波异常",diag[QAbnormal], lag);
	string sO2 = parase_diagnostic(O_Q_T_ST_Abnormal_Desp, sizeof(O_Q_T_ST_Abnormal_Desp) / sizeof(Diagnostic_Description), "ST异常", diag[STAbnormal], lag);
	string sO3 = parase_diagnostic(O_Q_T_ST_Abnormal_Desp, sizeof(O_Q_T_ST_Abnormal_Desp) / sizeof(Diagnostic_Description), "T波异常", diag[TAbnormal], lag);
	string sO4 = parase_diagnostic(O_Q_T_ST_Abnormal_Desp, sizeof(O_Q_T_ST_Abnormal_Desp) / sizeof(Diagnostic_Description), "ST-T异常", diag[ST_TAbnormal], lag);
	return sA+sB+sC+sD+sE+sF+sG+sH+sI+sJ+sK+sL+sM+sN + sO1+ sO2 + sO3 + sO4;
}


