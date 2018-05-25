%%
%% 1 Creat csv label

path_muse = 'E:\download\bin\MUSE-100';
path_out = 'F:\MUSE';
list = dir(fullfile(path_muse,'*.xml'));

fid = fopen(fullfile(path_out,'index1.csv'),'w+');
title = 'DataID,PatientID,PatientLastName,PatientAge,Gender,HeightCM,WeightKG,VentricularRate,AtrialRate,PRInterval,QRSDuration,QTInterval,QTCorrected,PAxis,RAxis,TAxis,QRSCount,QOnset,QOffset,POnset,POffset,TOffset,ECGSampleBase,ECGSampleExponent,QTcFrederica,Diagnosis,BeatTime,BeatType,QOnset_B,dif_QOnset_B,QOffset_B,dif_QOffset_B,POnset_B,dif_POnset_B,POffset_B,dif_POffset_B,TOffset_B,dif_TOffset_B,PRInterval_B,dif_PRInterval,QRSDuration,dif_QRSDuration,QTInterval,dif_QTInterval,FName';
fprintf(fid,'%s\n',title);
fclose(fid);


%%
fid_csv = fopen(fullfile(path_out,'index1.csv'),'a+');
DataID = 0;
%{
for kk = 1 : length(list)
    fname = fullfile(path_muse,list(kk).name);
    Fname=list(kk).name;
    [wave,rpos,QRStype,wave_median,fs,label,Meas,Meas_Orig,diag,diag_orig,Meas_Matrix,adu,PatientInfo]=musexmlread(fname);
     [data, qrs, meanwave, pqrst2] = ProcRestEcg(wave*adu/1000,fs);
    if(isempty(Meas.QOnset)||isempty(Meas.QOffset)||isempty(Meas.POnset)||isempty(Meas.POffset)||isempty(Meas.TOffset)||isempty(pqrst2(4))||isempty(pqrst2(6))||isempty(pqrst2(1))||isempty(pqrst2(3))||isempty(pqrst2(9))||isempty(Meas.PRInterval)||isempty(Meas.QTInterval))
    x1=fullfile(path_muse,Fname);
        movefile(x1,'F:\Q','f'); 
    end
end
%}
list = dir(fullfile(path_muse,'*.xml'));
for kk = 1 : length(list)
    fname = fullfile(path_muse,list(kk).name);
    Fname=list(kk).name;
    [wave,rpos,QRStype,wave_median,fs,label,Meas,Meas_Orig,diag,diag_orig,Meas_Matrix,adu,PatientInfo]=musexmlread(fname);
    pqrst = [Meas.POnset,Meas.POffset,...
    Meas.QOnset,Meas.QOffset,Meas.TOffset] * fs/500;
    [data, qrs, meanwave, pqrst2] = ProcRestEcg(wave*adu/1000,fs);
    [data111, meanwave111,rpos111,QRStype111, pqrst2_111, ecgmeas2] = ProcRestEcg111(wave*adu/1000,fs);
    
    if  Meas.ECGSampleBase==500&& fs == 500 &&...
            ~isempty(Meas.PRInterval)&&~isempty(Meas.QTInterval)...
            &&~isempty(Meas.POffset)&&~isempty(Meas.POnset)&&~isempty(Meas.QOnset)&&~isempty(Meas.QOffset)&&~isempty(Meas.TOffset)&&~isempty(pqrst2(4))&&~isempty(pqrst2(6))&&~isempty(pqrst2(1))&&~isempty(pqrst2(3))&&~isempty(pqrst2(9))
        a1 = Meas.PRInterval-2*( Meas.QOnset - Meas.POnset);
        a2 = Meas.QTInterval - 2*(  Meas.TOffset-Meas.QOnset);
        a3 =  Meas.QRSDuration - 2*(  Meas.QOffset-Meas.QOnset);
        if a1==0 && a2==0 && a3 == 0
                DataID = DataID+1;
                Alg1(1)=pqrst2(4)/250*1000+100;
                Alg1(2)=Alg1(1)-pqrst(3)/fs*1000;
                Alg1(3)=pqrst2(6)/250*1000+100;
                Alg1(4)=Alg1(3)-pqrst(4)/fs*1000;
                Alg1(5)=pqrst2(1)/250*1000+100;
                Alg1(6)=Alg1(5)-pqrst(1)/fs*1000;
                Alg1(7)=pqrst2(3)/250*1000+100;
                Alg1(8)=Alg1(7)-pqrst(2)/fs*1000;
                Alg1(9)=pqrst2(9)/250*1000+100;
                Alg1(10)=Alg1(9)-pqrst(5)/fs*1000;
                Alg1(11)=ecgmeas2.PRInterval;
                Alg1(12)=Alg1(11)-Meas.PRInterval;
                Alg1(13)=ecgmeas2.QRSDuration;
                Alg1(14)=Alg1(13)-Meas.QRSDuration;
                Alg1(15)=ecgmeas2.QTInterval;
                Alg1(16)=Alg1(15)-Meas.QTInterval;
            writemuse2csv(fid_csv, PatientInfo,Meas,diag,rpos,QRStype,Alg1,Fname,DataID);
            %1. creat .hea file
            record = sprintf('%010d' , DataID );
            hfname = sprintf('%010d.hea' , DataID );
            fid = fopen(fullfile(path_out,hfname),'w+');
            fprintf(fid,'%010d %d %d %d\n',DataID,size(wave,2),Meas.ECGSampleBase,size(wave,1));
            for chan = 1:size(wave,2)
                fprintf(fid,'%010d %d %.2f %d 0 0 0 0 %s\n',DataID,16,1000/adu,16 , label{chan});
            end
            fclose(fid);
            
            dataname = sprintf('%010d.dat' , DataID );
            fid = fopen(fullfile(path_out,dataname),'w+');
            fwrite(fid,wave','short');
            fclose(fid);
            
            mdwname = sprintf('%010d.mwv' , DataID );
            fid = fopen(fullfile(path_out,mdwname),'w+');
            fwrite(fid,wave_median','short');
            fclose(fid);
            
            beat.time = floor(rpos'/2);
            type = [];
            tt = unique(QRStype);
            ntt = zeros(1,length(tt));
            for nn = 1 : length(tt)
                ntt(nn) = length(find(QRStype == tt(nn)));
            end
            [v ,idx] = max(ntt);
            type = [];
            type(QRStype'==tt(idx)) = 'N';
            type(QRStype'~=tt(idx)) = 'V';
            type = char(type');
            beat.anntyp =type;
            beat.subtyp = beat.anntyp;
            beat.chan = beat.anntyp;
            beat.num = beat.anntyp;
            beat.aux = beat.anntyp;
            atrname =  sprintf('%010d.atr' , DataID );
            writeannot(fullfile(path_out,atrname),beat);
        end
    end
end
    fclose(fid_csv);
    %%
