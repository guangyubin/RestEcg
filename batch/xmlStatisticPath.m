%%
%% 1 Creat csv label

path = 'D:\MGCDB\muse\classify_xml';

list = dir(path);
m = 0;
path_list = [];
for ii = 1:length(list)
    if list(ii).isdir==1 && isempty(strfind(list(ii).name,'.'))
        m = m +1;
        path_list{m} = fullfile(path,list(ii).name);
    end
end

m = 1;
path_list = [];
path_list{1} = 'D:\MGCDB\muse\classify_xml\正常心电图';
path_list{2} = 'D:\MGCDB\muse\classify_xml\一度房室阻滞';
path_list{3} = 'D:\MGCDB\muse\classify_xml\完全性右束支阻滞';
fname_list = [] ;
for ipath = 1: length(path_list)
    path_muse = path_list{ipath};
    list = dir(fullfile(path_muse,'*.xml'));
    for kk = 1: length(list)
        fname_list{m} = fullfile(path_muse,list(kk).name);
        m = m+1;
    end
end
disp(length(fname_list));
param0 = zeros(7,length(fname_list));;
param1 = param0;


parfor mm = 1: length(fname_list) 
     fname = fname_list{mm};
    [wave,rpos,QRStype,wave_median,fs,label,Meas,Meas_Orig,diag,diag_orig,Meas_Matrix,adu,PatientInfo]=musexmlread(fname);
    if ~isempty(wave)
        [meanwave, rpos,QRStype ,pqrst,ecgmeas]  = matmgc('mat_restecg_Process',floor(200*wave*adu/1000),fs,200);
        
        names = fieldnames(Meas);
        for ii = 1:length(names)
            if isempty(getfield(Meas,names{ii}))
                Meas = setfield(Meas,names{ii},nan);
            end
        end
            
        a = [Meas.PRInterval Meas.QRSDuration Meas.QTInterval Meas.VentricularRate Meas.PAxis Meas.RAxis Meas.TAxis];
        b = [ecgmeas.PRInterval ecgmeas.QRSDuration ecgmeas.QTInterval ecgmeas.VentricularRate ecgmeas.PAxis ecgmeas.RAxis ecgmeas.TAxis];
        if length(a) == length(b)
            param0(:,mm) =  a;
            param1(:,mm) =  b;            
        end        
    end    
end

%%
for ii = 1: size(param0,1)
    res(ii,:) = meas_qt(param0(ii,:),param1(ii,:));
end

PR = param1(1,:);
length(PR(PR< 200))
clear matmgc




