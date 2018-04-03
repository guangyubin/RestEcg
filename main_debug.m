%%
[aaa sortres] = sort(res(:,5),'descend');
[aaa sortres] = sort(abs(tPos3(:,3) - tPos0(:,3)),'descend');
path = 'D:\MGCDB\muse\';
fs = 500;
ii = 7;

for kk =  1 %5:length(sortres); %1:length(datalist)
    ii = sortres(kk);
%     ii = 801;
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
      [dataout, qrs, meanwave, pqrst] = ProcRestEcg_v3(data,fs);
      
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
    beat00 = readannot(fullfile(path,atename));
    %4. use the bxb to compare the 'atr' and 'ate'
    resii= matmgc('mit_bxb',path,record,'atr','ate','00:00')';
    disp(resii')
    
    ecg = dataout;
%     plot_restEcg(ecg,fs,datalist(ii).rpos/2, datalist(ii).QRStype,0);
subplot(131);
        plot_restEcg(ecg,fs,beat0.time, beat0.anntyp,0);
         hold on;   plot_restEcg(ecg,fs,beat00.time, beat00.anntyp,1); hold off
         for mm = 1 : 8         
             beat1 = matmgc('rest_beat_classify',ecg(:,mm),250,beat00.time);
             beatlist(mm) = beat1;
             maxtype = FindMaxType(beat1.qrs(1,:));
%              beat1.anntyp(1:end) = '1';
%              beat1.anntyp(beat1.qrs(1,:)==maxtype) ='0';
             hold on;plot_restEcg(ecg,fs,beat1.time, beat1.qrs(1,:),-1-mm*4); hold off;
         end;
    title(b);
        subplot(133);plot_restMedianWave(meanwave,250,pqrst,'r');
           refpos = [datalist(ii).Meas.POnset ,datalist(ii).Meas.POffset,...
        datalist(ii).Meas.QOnset,datalist(ii).Meas.QOffset,datalist(ii).Meas.TOffset];
    subplot(132);plot_restMedianWave(datalist(ii).wave_median*datalist(ii).adu/1000,500,refpos,'r');
    
end;
clear matmgc;