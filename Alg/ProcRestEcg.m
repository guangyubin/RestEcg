function [dataout, meanwave, rpos,QRStype,  pqrst,meas] = ProcRestEcg(data,fs)
%%
% load('D:\MGCDB\muse\musedb_500Hz');
% data = DATA(1).wave;
if fs == 500
    data = data(1:2:end,:);
end

dataout = data;

[meanwave, rpos,QRStype ,pqrst,meas]  = matmgc('mat_restecg_Process',data*200,250,200);

meanwave = meanwave/200;
clear matmgc


% 
% II = data(:,2);
% V2 = data(:,4);
% V3 = data(:,5);
% 
% qrs = matmgc('beat_detector_classify',(II+V2)/2,250);
% QRSType = qrs.qrs(1,:);
% rpos = qrs.time;
% maxtype = FindMaxType(QRSType);
% segdata = beat_segment(data,rpos,2,QRSType,maxtype,0.4,0.6,250);
% meanwave = mean(segdata,3)';
% 
% 
% rr = mean(diff(rpos))*1000/250;
% 
% 
% % [pos1 , amp] = matmgc('analyze_beat_v1',meanwave(:,2)+meanwave(:,4),rr);
% 
% dataout = data;
% 
% 
% [waveposabs , amp] = matmgc('analyze_beat_v1', mean(abs(meanwave),2),rr);
% for kk = 1:size(meanwave,2)
%     [wavepos8(kk,:),amp] =  matmgc('analyze_beat_v1',meanwave(:,kk),rr);
% end
% tmp  = floor(median(wavepos8,1));
% wavepos= waveposabs;
% wavepos(1:3) = wavepos8(2,1:3);  % P 波采用II导联
% wavepos(4:5) = waveposabs(4:5);  % Qonset采用abs
% wavepos(6) = tmp(6);   %  Qend采用median
% wavepos(7:9) = tmp(7:9)+1;   % Tend 采用meidan
% 
% pqrst = wavepos;
