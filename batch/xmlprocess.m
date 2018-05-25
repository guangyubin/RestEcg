%%
%% 1 Creat csv label

% path = 'E:\BaiduYunDownload\data\Classify_f';
% 
% list = dir(path);
% m = 0;
% for ii = 1:length(list)
%     if list(ii).isdir==1 && isempty(strfind(list(ii).name,'.'))
%         m = m +1;
%         path_list{m} = fullfile(path,list(ii).name);
%     end
% end


 path_list{1} = 'E:\BaiduYunDownload\data\Classify_f\正常心电图';
path_out = 'D:\DataBase\MUSE_Classify\MuseLargError';
path_out_PR = 'D:\DataBase\MUSE_Classify\Muse_LargePR';
path_out_QT = 'D:\DataBase\MUSE_Classify\Muse_LargeQT';
path_out_PW = 'D:\DataBase\MUSE_Classify\Muse_PWaveError';
if isdir(path_out_PR)
    rmdir(path_out_PR, 's');
    mkdir(path_out_PR);
else
    mkdir(path_out_PR);
end
if isdir(path_out)
    rmdir(path_out, 's');
    mkdir(path_out);
else
    mkdir(path_out);
end
if isdir(path_out_QT)
    rmdir(path_out_QT, 's');
    mkdir(path_out_QT);
else
    mkdir(path_out_QT);
end
if isdir(path_out_PW)
    rmdir(path_out_PW, 's');
    mkdir(path_out_PW);
else
    mkdir(path_out_PW);
end




c1 = 1;
c2 = 1;
c3 = 1;
c4 = 1;
m = 1;
for ipath = 1: length(path_list)
    path_muse = path_list{ipath};
    list = dir(fullfile(path_muse,'*.xml'));
    for kk = 1:length(list)
        
        fname = fullfile(path_muse,list(kk).name);
        Fname=list(kk).name;
        [wave,rpos,QRStype,wave_median,fs,label,Meas,Meas_Orig,diag,diag_orig,Meas_Matrix,adu,PatientInfo]=musexmlread(fname);
        if ~isempty(wave)
            [meanwave, rpos,QRStype ,pqrst,ecgmeas]  = matmgc('mat_restecg_Process',200*wave*adu/1000,fs,200);
            
            
            if isempty(Meas.POnset)
                Meas.POnset = 20;
                Meas.POffset = 20 ;
            end
            
            if isempty(Meas.PRInterval)
                Meas.PRInterval = nan;
            end
            if isempty(Meas.PAxis)
                Meas.PAxis= nan;
            end
            if isempty(Meas.QTInterval)
                Meas.QTInterval = nan;
            end
            
            a = [Meas.PRInterval Meas.QRSDuration Meas.QTInterval Meas.VentricularRate Meas.PAxis Meas.RAxis Meas.TAxis];
            b = [ecgmeas.PRInterval ecgmeas.QRSDuration ecgmeas.QTInterval ecgmeas.VentricularRate ecgmeas.PAxis ecgmeas.RAxis ecgmeas.TAxis];;
            a = double(a);
            b = double(b);
            param0(:,m) =  a;
            param1(:,m) =  b;
            
            m = m+1;
            disp(m);
            if (abs(a(2) - b(2))) > 60
                copyfile(fname,path_out);
                c1 = c1+1;
            end
            
            if   abs(Meas.PRInterval  - ecgmeas.PRInterval) > 60
                
                copyfile(fname,path_out_PR);
                c2 = c2+1;
            end
            
            if   abs(Meas.QTInterval  - ecgmeas.QTInterval) > 60
                
                copyfile(fname,path_out_QT);
                c3 = c3+1;
            end
            ecgmeas.AtrialRate = double(ecgmeas.AtrialRate);
            if   abs(ecgmeas.AtrialRate  - Meas.AtrialRate) > 10
                
                copyfile(fname,path_out_PW);
                c4 = c4+1;
            end
        end
    end
    
end

%%
disp([c1 c2 c3 c4]);
for ii = 1: size(param0,1)
    res(ii,:) = meas_qt(param0(ii,:),param1(ii,:));
end

clear matmgc


