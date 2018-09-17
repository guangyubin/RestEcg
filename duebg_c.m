
%%

d = floor(200*DATA.wave);
if DATA.fs==500
    d = d(1:2:end,:);
end
fs = 250;
fid = fopen('D:\\3.dat','wb'); fwrite(fid,d,'int32');fclose(fid);

  fid = fopen('D:\\3.dat','rb'); d1 = fread(fid,[fs*10 8],'int32');fclose(fid);



[meanwave, rpos,QRStype ,ppos,pqrst, meas , wave , pout , pmeanwave, pchan]  = matrestecg('mat_restecg_Process',d1,fs,200);
figure;
ch = pchan+1 ;
subplot(211);;plot(pout(:,ch)); hold on;plot(ppos+1,pout(ppos+1,ch),'.r'); hold on;plot(rpos+1,pout(rpos+1,ch),'*r');
subplot(212);plot(pmeanwave(:,ch));
% figure;plot(d(:,1));
% figure;plot(d(:,1));
clear matrestecg
%%
figure;subplot(211);plot(meanwave(:,2),meanwave(:,3),'.');
subplot(212);plot(DATA.wave_median(:,2),DATA.wave_median(:,3),'.');
 %%
 d = floor(200*DATA.wave);
[meanwave, rpos,QRStype ,pqrst,meas , wave]  = matmgc('mat_restecg_Process',d,DATA.fs,200);
 x = meanwave(:,8);
 fid = fopen('D:\2.dat','wb');
 fwrite(fid,x,'int32');
 fclose(fid);
 figure;plot(smooth(x,5));
 
  fid = fopen('D:\2.dat','rb');
 x = fread(fid,'int32');
 fclose(fid);
 [y1 ,y2]=matmgc('analyze_beat_v1',x/200,1000);
 figure;plot(x);hold on;plot(y1,x(y1),'.r');
 

clear matmgc