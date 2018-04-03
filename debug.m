%%
%% 1 Creat csv label

path_muse = 'D:\DataBase\MUSE';
path_muse = 'D:\DataBase\MuseLargError';


list = dir(fullfile(path_muse,'*.xml'));
param0 = zeros(7,length(list));
param1 = param0;
for kk = 1 : length(list)
    fname = fullfile(path_muse,list(kk).name);
    Fname=list(kk).name;
    [wave,rpos,QRStype,wave_median,fs,label,Meas,Meas_Orig,diag,diag_orig,Meas_Matrix,adu,PatientInfo]=musexmlread(fname);
     [dataout, meanwave, rpos,QRStype,  pqrst , ecgmeas] = ProcRestEcg(wave*adu/1000,fs);
    
    if isempty(Meas.POnset)
        Meas.POnset = 20;
        Meas.POffset = 20 ;
    end
%     pqrst0 = floor([Meas.POnset,Meas.POffset,...
%         Meas.QOnset,Meas.QOffset,Meas.TOffset] * fs/500);
%     ecgmeas.PAxis = acrdiac_EAxis(wave_median(:,1), wave_median(:,2), pqrst0(1), pqrst0(2));
%     ecgmeas.RAxis = acrdiac_EAxis(wave_median(:,1), wave_median(:,2), pqrst0(3), pqrst0(4));
%     ecgmeas.TAxis = acrdiac_EAxis(wave_median(:,1), wave_median(:,2), pqrst0(4), pqrst0(5));
%     
%     ecgmeas.PAxis = acrdiac_EAxis(meanwave(:,1), meanwave(:,2), pqrst(1), pqrst(3));
%     ecgmeas.RAxis = acrdiac_EAxis(meanwave(:,1), meanwave(:,2), pqrst(4), pqrst(6));
%     ecgmeas.TAxis = acrdiac_EAxis(meanwave(:,1), meanwave(:,2), pqrst(6), pqrst(9));
    
    if isempty(Meas.PRInterval)
        Meas.PRInterval = nan;
    end
    if isempty(Meas.PAxis)
        Meas.PAxis= nan;
    end

    param0(1,kk) =  Meas.PRInterval;
    param0(2,kk) = Meas.QRSDuration;
    param0(3,kk) = Meas.QTInterval ;
    param0(4,kk) = Meas.VentricularRate;
    param0(5,kk) = Meas.PAxis;
    param0(6,kk) = Meas.RAxis;
    param0(7,kk) = Meas.TAxis;
    
    param1(1,kk) =  ecgmeas.PRInterval;
    param1(2,kk) = ecgmeas.QRSDuration;
    param1(3,kk) = ecgmeas.QTInterval ;
    param1(4,kk) = ecgmeas.VentricularRate;
    param1(5,kk) = ecgmeas.PAxis;
    param1(6,kk) = ecgmeas.RAxis;
    param1(7,kk) = ecgmeas.TAxis;

    
end

%%

for ii = 1: size(param0,1)
    meas_qt(param0(ii,:),param1(ii,:));
end

clear matmgc
%%
% list = dir(fullfile(path_muse,'*.xml'));
% for ii = 1:length(list)
%       fname = fullfile(path_muse,list(ii).name);
%         [wave,rpos,QRStype,wave_median,fs,label,Meas,Meas_Orig,diag,diag_orig,Meas_Matrix,adu,PatientInfo]=musexmlread(fname);
% 
%               fid = fopen(fullfile(path_out,[list(ii).name(1:end-4) '.dat' ]),'wb');
%       fwrite(fid,200*wave*adu/1000,'int32');
%       fclose(fid);
% end;
%%


