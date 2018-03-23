% 测试median wave database

%%

% load('D:\MGCDB\muse\MuseDB_500Hz.mat');
% datalist = DATA;

idx = 1:length(datalist);
fig = 0;
tPos1 = [];
tPos3 = [];
tPos2 = [];
tPos4 = [];
for ii = 1:length(datalist)
    % postion of refernece
    refpos = [datalist(ii).Meas.POnset ,datalist(ii).Meas.POffset,...
        datalist(ii).Meas.QOnset,datalist(ii).Meas.QOffset,datalist(ii).Meas.TOffset] * 1000/500;
    tPos1(ii,:) =refpos;
    
      % 2 _using MUSE  meadian wave_
    rr = floor(60000/ datalist(ii).Meas.VentricularRate);
    x = datalist(ii).wave_median(1:2:end,2)*datalist(ii).adu/1000;
    x = ((x - mean(x)));
    [pos , amp] = matmgc('analyze_beat_v1',x,rr);
    tPos2(ii,:) =(pos([1 3 4 6 9]))*1000/250;
    
    data = datalist(ii).wave(1:2:end,:);
    II = data(:,2)';
    V2 = data(:,4)';
    V3 = data(:,5)'; 
    
    
     % 3 using MUSE position and type of QRS_ 
    QRSType = datalist(ii).QRStype;
    rpos =   floor(datalist(ii).rpos/2);
    
    maxtype = FindMaxType(QRSType);
    segdata = beat_segment(data,rpos,QRSType,maxtype,0.5,0.7,250);
    meanwave = mean(segdata,3)';
    rr = mean(diff(rpos))*1000/250;
    [pqrst , amp] = matmgc('analyze_beat_v1',meanwave(:,2),rr);
    tPos3(ii,:) =(pqrst([1 3 4 6 9]))*1000/250;
    
     % 4 Our Method 
    [dataout, qrs, meanwave, pqrst] = ProcRestEcg(datalist(ii).wave,datalist(ii).fs);
    tPos4(ii,:) =(pqrst([1 3 4 6 9])+25)*1000/250;
  
    % 5  combined 8 channels
    meanwave = mean(segdata,3);
    meanwave = meanwave(:,26:end)';
   [waveposabs , amp] = matmgc('analyze_beat_v1', mean(abs(meanwave),2),rr);
   for kk = 1:size(meanwave,2)
        [wavepos8(kk,:),amp] =  matmgc('analyze_beat_v1',meanwave(:,kk),rr);
   end 
    tmp  = floor(median(wavepos8,1));
    wavepos= waveposabs;
    wavepos(1:3) = wavepos8(2,1:3);  % P 波采用II导联
    wavepos(4:5) = waveposabs(4:5);  % Qonset采用abs
    wavepos(6) = tmp(6);   %  Qend采用median
    wavepos(7:9) = tmp(7:9)+1;   % Tend 采用meidan
    tPos5(ii,:) =(wavepos([1 3 4 6 9])+25)*1000/250;
end
clear matmgc
%%
 clc
disp('mean    mean_err   std     <5ms    <10ms    <20ms    <40ms   <100ms');
% disp('____________________________________________________________');
% disp('_______using MUSE  meadian wave__________________________________');
% % tPos3(:,5) = tPos3(:,5) +3;
% res= meas_qrst(tPos1,tPos2);
% disp('_______using MUSE position and type of QRS__________________________________');
% res= meas_qrst(tPos1,tPos3);
disp('_______Our Method__________________________________');
res= meas_qrst(tPos1,tPos4);

disp('_______using MUSE position and type of QRS_________________________________');
res= meas_qrst(tPos1,tPos5);
% disp('mean    mean_err   std     <5ms    <10ms    <20ms    <40ms   <100ms');
% disp('____________________________________________________________');

% disp('____________________________________________________________');
% [a ,b] =sort(abs(tPos2(:,3) - tPos3(:,3)+1));