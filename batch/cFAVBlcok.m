
path = 'D:\MGCDB\muse\classify\一度房室阻滞';
list = dir(fullfile(path ,'*.mat'));
listname = [];
PR1= [];
PR0 = [];
for ii = 1:length(list)
    fname = fullfile(path,list(ii).name);
    load(fname);
    f = fieldnames(DATA.Meas);
    for kk = 1:length(f)
        if isempty(getfield(DATA.Meas,f{kk}))
            DATA.Meas = setfield(DATA.Meas,f{kk},nan);
        end
    end    
    [meanwave, rpos,QRStype ,pqrst,ecgmeas]  = matmgc('mat_restecg_Process',floor(200*DATA.wave*DATA.adu/1000),DATA.fs,200);
    PR1(ii) = ecgmeas.PRInterval;    
    PR0(ii) = DATA.Meas.PRInterval;
    listname{ii} = list(ii).name;
end

disp('一度房室阻滞===============================================================')
disp([length(PR1((PR1)<200)) (length(PR0(PR0<200)) + length(PR0(isnan(PR0))))  length(PR1)]);
meas_qt(PR0,PR1);


[v, index] = sort(PR1);
for ii = 1:length(listname)
    [filepath,name,ext] = fileparts(listname{index(ii)});
    listname2{ii} = [name ext];
end

save(fullfile(path,'sortlist.mat'),'listname2');

%%

path = 'D:\MGCDB\muse\classify\正常心电图';
list = dir(fullfile(path ,'*.mat'));
listname = [];
for ii = 1:length(list)
    fname = fullfile(path,list(ii).name);
    load(fname);
    f = fieldnames(DATA.Meas);
    for kk = 1:length(f)
        if isempty(getfield(DATA.Meas,f{kk}))
            DATA.Meas = setfield(DATA.Meas,f{kk},nan);
        end
    end    
    [meanwave, rpos,QRStype ,pqrst,ecgmeas]  = matmgc('mat_restecg_Process',floor(200*DATA.wave*DATA.adu/1000),DATA.fs,200);
    PR1_2(ii) = ecgmeas.PRInterval;    
    PR0_2(ii) = DATA.Meas.PRInterval;
    listname{ii} = list(ii).name;
end
%%

disp('正常心电图================================================================')
disp([length(PR1_2((PR1_2)<200)) (length(PR0_2(PR0_2<200)) + length(PR0_2(isnan(PR0_2))))  length(PR1_2)]);

meas_qt(PR0_2,PR1_2-4);

listname2 = [];
[v, index] = sort(abs(double(PR1_2)));  %-PR0_2));
for ii = 1:length(index)
    [filepath,name,ext] = fileparts(listname{index(ii)});
    listname2{ii} = [name ext];
end

save(fullfile(path,'sortlist.mat'),'listname2');

clear matmgc
