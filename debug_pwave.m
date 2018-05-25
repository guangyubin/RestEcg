fname = 'D:\MGCDB\MUSE_Classify\Muse_LargePR\MUSE_20130414_225628_47000.XML';

[wave,rpos,QRStype,wave_median,sr,label,Meas,Meas_Orig,diag,diag_orig,Meas_Matrix,adu,PatientID]...
    = musexmlread(fname);
    fid = fopen('D:\\9.dat','wb'); fwrite(fid,wave,'int32');fclose(fid);
rpos = rpos/2;
clear matmgc;
%%
x = wave(:,3);;
y = x;
rpos(QRStype==-1) = [];
QRStype(QRStype==-1) = [];
bs = x - x;
for ii = 1 : length(rpos)
    tt = rpos(ii)-248 +  Meas.QOnset :rpos(ii)-248 +Meas.TOffset;
    if tt(end) < length(x)
    bs(tt) = wave_median(Meas.QOnset: Meas.TOffset,3);
    y(tt)  =   x(tt) - wave_median(Meas.QOnset: Meas.TOffset,3);
    end
end
figure;subplot(211);plot(x);hold on;plot(bs);subplot(212);plot(y);
% figure;plot(wave_median(Meas.QOnset: Meas.TOffset,3));

% figure;plot(meanwave);

