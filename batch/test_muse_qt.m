% ≤‚ ‘median wave database

%%

% load('D:\MGCDB\muse\MuseDB_500Hz.mat');
% datalist = DATA;

idx = 1:length(datalist);
fig = 0;
tPos0 = [];
tPos1 = [];
tPos3 = [];
tPos2 = [];
tPos4 = [];
for ii = 1:length(datalist)
    % postion of refernece
    refpos = [datalist(ii).Meas.POnset ,datalist(ii).Meas.POffset,...
        datalist(ii).Meas.QOnset,datalist(ii).Meas.QOffset,datalist(ii).Meas.TOffset] * 1000/500;
    tPos0(ii,:) =refpos;    
    
%    [dataout, qrs, meanwave, pqrst] = ProcRestEcg(datalist(ii).wave,datalist(ii).fs);
%     tPos1(ii,:) =(pqrst([1 3 4 6 9])+25)*1000/250;
     % 4 Our Method 
%     [dataout, qrs, meanwave, pqrst] = ProcRestEcg_v2(datalist(ii).wave,datalist(ii).fs);
     [dataout, meanwave, rpos,QRStype,  pqrst] = ProcRestEcg(datalist(ii).wave,datalist(ii).fs);
    tPos2(ii,:) =(pqrst([1 3 4 6 9])+25)*1000/250;
      
         % 4 Our Method 
%     [dataout, qrs, meanwave, pqrst] = ProcRestEcg_v4(datalist(ii).wave,datalist(ii).fs);
%     tPos3(ii,:) =(pqrst([1 3 4 6 9])+25)*1000/250;
%        tPos3(ii,:)  = meanwave_pqrst(meanwave,rr);
    % 5    using MUSE position and type of QRS_ 
     data = datalist(ii).wave(1:2:end,:);    
    QRSType = datalist(ii).QRStype;
    rpos =   floor(datalist(ii).rpos/2);    
    maxtype = FindMaxType(QRSType);
    segdata = beat_segment(data,rpos,QRSType,maxtype,0.4,0.6,250);  
    rr = mean(diff(rpos))*1000/250;    
    meanwave = mean(segdata,3)';
%     meanwave = meanwave(:,26:end)';   
    pqrst = matmgc('do_pqrst_of_meanwave',meanwave*200,rr);
      tPos5(ii,:)=(pqrst([1 3 4 6 9]))*1000/250;
      

     tPos4(ii,:)  = meanwave_pqrst(meanwave,rr);

    

end
clear matmgc
%%
 clc
disp('mean    mean_err   std     <5ms    <10ms    <20ms    <40ms   <100ms');
% disp('____________________________________________________________');
% disp('_______using MUSE  meadian wave__________________________________');
% % tPos3(:,5) = tPos3(:,5) +3;
% res= meas_qrst(tPos1,tPos2);
disp('_______Our Method V1________________________________');
% res= meas_qrst(tPos0,tPos1);
disp('_______Our Method V2_________________________________');
res= meas_qrst(tPos0,tPos2);
disp('_______Our Method V3_________________________________');
x = tPos2;
res= meas_qrst(tPos0,x);

disp('_______using MUSE position and type of QRS_________________________________');
res= meas_qrst(tPos0,tPos4+100);
disp('________________________________________');

% disp('mean    mean_err   std     <5ms    <10ms    <20ms    <40ms   <100ms');
% disp('____________________________________________________________');

% disp('____________________________________________________________');
% [a ,b] =sort(abs(tPos2(:,3) - tPos3(:,3)+1));