
%%

 
d = floor(200*DATA.wave);


fid = fopen('D:\\3.dat','wb'); fwrite(fid,d,'int32');fclose(fid);

  fid = fopen('D:\\3.dat','rb'); d1 = fread(fid,[DATA.fs*10 8],'int32');fclose(fid);



[meanwave, rpos,QRStype ,pqrst,meas , wave]  = matmgc('mat_restecg_Process',d,DATA.fs,200);


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