function [dataout, qrs, meanwave, pqrst] = ProcRestEcg_v2(data,fs)
%%
% load('D:\MGCDB\muse\musedb_500Hz');
% data = DATA(1).wave;
if fs == 500
    data = data(1:2:end,:);
end

rpos1 = [];
for mm = 1:8
    [rpos1,sqi(mm)] = matmgc('rest_qrs_detect',data(:,mm),250);     
end
[a ,b] = max(sqi);

 rpos = matmgc('rest_qrs_detect',data(:,b),250); 
 qrs = matmgc('rest_beat_classify',data(:,b),250,rpos);
 
 
QRSType = qrs.qrs(1,:);
rpos = qrs.time;
maxtype = FindMaxType(QRSType);
segdata = beat_segment(data,rpos,b,QRSType,maxtype,0.4,0.6,250);
meanwave = mean(segdata,3)';


rr = mean(diff(rpos))*1000/250;


% [pos1 , amp] = matmgc('analyze_beat_v1',meanwave(:,2)+meanwave(:,4),rr);

dataout = data;


[waveposabs , amp] = matmgc('analyze_beat_v1', mean(abs(meanwave),2),rr);
for kk = 1:size(meanwave,2)
    [wavepos8(kk,:),amp] =  matmgc('analyze_beat_v1',meanwave(:,kk),rr);
end
tmp  = floor(median(wavepos8,1));
wavepos= waveposabs;
wavepos(1:3) = wavepos8(2,1:3);  % P ������II����
wavepos(4:5) = waveposabs(4:5);  % Qonset����abs
wavepos(6) = tmp(6);   %  Qend����median
wavepos(7:9) = tmp(7:9)+1;   % Tend ����meidan

pqrst = wavepos;
