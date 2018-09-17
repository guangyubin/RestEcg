

%%
record = 'D:\\MGCDB\\CAREB1\\data\\00000000-1534387079000-8f00dc21beff';
matmgc('proc_raw',record);
[hd d ] = loadmgcdata(record);
figure;plot(d);
clear matmgc;

d2 = d;
figure;subplot(211);plot(d1);
subplot(212);plot(d2);