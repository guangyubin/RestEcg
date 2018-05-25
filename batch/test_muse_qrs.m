
%%
load('D:\MGCDB\muse\MuseDB_500Hz.mat');
datalist = DATA;
%%
path = 'D:\MGCDB\muse\';
fs = 500;
ii = 7;
res = [];
for ii = 301 % 1:length(datalist)
 
    %1. creat .hea file
    record = sprintf('%05d' , ii );
    hfname = sprintf('%05d.hea' , ii );
    fid = fopen(fullfile(path,hfname),'w+');
    fprintf(fid,'%05d %d %d %d\n',ii,1,250,3000);
    fprintf(fid,'%05d %d %.2f %d 0 0 0 0 II\n',ii,16,200,16);
    fclose(fid);
    %2. beat_detector, get the 'ate' files
    qrsname = sprintf('%05d.qrs' , ii );
    atename = sprintf('%05d.ate' , ii );

    data = datalist(ii).wave;
    fs = 500;
%   [dataout, qrs, meanwave, pqrst] = ProcRestEcg(data,fs);
    [dataout, meanwave, rpos,QRStype,  pqrst , ecgmeas] = ProcRestEcg(wave*adu/1000,fs);
%  qrs = matmgc('mat_restecg_Process',data*200,fs,200);
    maxtype = FindMaxType(qrs.qrs(1,:));
    qrs.anntyp(1:end) = 'V';
    qrs.anntyp(qrs.qrs(1,:)==maxtype) = 'N';
    qrs2atr(fullfile(path,atename),qrs);
       
    %3. creat the 'atr' 
    
    beat.time = floor(datalist(ii).rpos'/2);
    type = [];
    maxtype = FindMaxType(datalist(ii).QRStype);
    type(datalist(ii).QRStype'==maxtype) = 'N';
    type(datalist(ii).QRStype'~=maxtype) = 'V';
    type = char(type);
    beat.anntyp =type';
    beat.subtyp = beat.anntyp;
    beat.chan = beat.anntyp;
    beat.num = beat.anntyp;
    beat.aux = beat.anntyp;
    atrname =  sprintf('%05d.atr' , ii );
    writeannot(fullfile(path,atrname),beat);
    beat0 = readannot(fullfile(path,atrname));    
    %4. use the bxb to compare the 'atr' and 'ate'
   res(ii,:)= matmgc('mit_bxb',path,record,'atr','ate','00:01')';
end;

clear matmgc

A1 = sum(res,1);
disp("Sen    | PPV    | Sen    | PPV    | Sen    | PPV    |");
str = sprintf('%.4f | %.4f | %.4f | %.4f | %.4f | %.4f | %.4f | %.4f | %.4f',...
    A1(1)/(A1(1)+A1(3)),...
    A1(1)/(A1(1)+A1(2)),...
    A1(4)/(A1(4)+A1(6)),...
    A1(4)/(A1(4)+A1(5)),...
    A1(7)/(A1(7)+A1(9)),...
    A1(7)/(A1(7)+A1(8)));
disp(str);
clear matmgc;
[a index12] = sort(res(:,6));
[a index13] = sort(res(:,5));
% subplot(211); plot_ecg_beat_type(x,beat0.time,beat0.anntyp);
% subplot(212);  plot_ecg_beat_type(x,beat1.time,beat1.anntyp);