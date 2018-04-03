function tPos = meanwave_pqrst(meanwave,rr)


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
%     wavepos
  tPos=(wavepos([1 3 4 6 9]))*1000/250;
