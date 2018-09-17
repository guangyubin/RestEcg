void test_restecg()
{
	FILE *fp = fopen("D:\\3.dat", "rb");
	if (fp == NULL)  return;
	fseek(fp, 0, SEEK_END);
	int filesize = ftell(fp);
	int fs = 250;

	//int fs = 250;
	fseek(fp, 0, SEEK_SET);
	int len =  filesize/(8*4);

	int *data =new int[len * 8];
	fread(data, sizeof(int), len * 8, fp);



	restecg_meas_medextech res1;
    medextech_restecg_process(data, len, 8, 200,fs , &res1);
	printf("基本参数: QTInterval =%d  QRSDuration = %d PRInterval =  %d   VentricularRate = %d\n", res1.QTInterval, res1.QRSDuration, res1.PRInterval , res1.VentricularRate);
	
	cout << "测量矩阵:" << endl;

	cout << "PA  " << "PPA  " << "QA " << "QD  " << "RA  " <<"RD  "<< "SA  " << "SD  " << "RPA " << "RPD  " << "SPA  " << "STJ  " << "STM " << "STE  " << "TA  " << "TPA  " << endl;

	for (int i = 0; i < 12; i++)
	{
		for (int j = 0; j < 16; j++)
			cout << res1.MeasMatrix[i * 16 + j] << "  ";

		cout << endl;
	}
	
	cout <<"诊断结果:"<<  medextech_parase_diagnostic_array(res1.DiagnosticArray, 2) << endl;


	//vector<int> rpos = medextech_restecg_QrsDetector(data, len, 8, 200, fs);
	int a = 0;

}