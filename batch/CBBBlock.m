path = 'D:\MGCDB\muse\classify\完全性左束支阻滞';
disp(path)
listname = listfile(path);
[param0,param1,res] =  matStatisticpath(listname);


%%
disp('完全性左束支阻滞===============================================================')
PR0 = param0(2,:);
PR1 = param1(2,:);
disp([length(PR1((PR1)<120)) (length(PR0(PR0<120)) + length(PR0(isnan(PR0))))  length(PR1)]);

listname2 = [];
[v, index] = sort(PR1);
for ii = 1:length(listname)
    [filepath,name,ext] = fileparts(listname{index(ii)});
    listname2{ii} = [name ext];
end

save(fullfile(path,'sortlist.mat'),'listname2');

%%
path = 'D:\MGCDB\muse\classify\完全性右束支阻滞';
disp(path)
listname = listfile(path);
[param0,param1,res] =  matStatisticpath(listname);


%%
disp('完全性右束支阻滞===============================================================')
PR0 = param0(2,:);
PR1 = param1(2,:);
disp([length(PR1((PR1)<120)) (length(PR0(PR0<120)) + length(PR0(isnan(PR0))))  length(PR1)]);

listname2 = [];
[v, index] = sort(PR1);
for ii = 1:length(listname)
    [filepath,name,ext] = fileparts(listname{index(ii)});
    listname2{ii} = [name ext];
end

save(fullfile(path,'sortlist.mat'),'listname2');

%%

path = 'D:\MGCDB\muse\classify\正常心电图';
disp(path)
listname = listfile(path);
[param0,param1,res] =  matStatisticpath(listname);
%%
PR0 = param0(2,:);
PR1 = param1(2,:)-4;
meas_qt(PR0,PR1);
disp([length(PR1((PR1)<120)) (length(PR0(PR0<120)) + length(PR0(isnan(PR0))))  length(PR1)]);

listname2 = [];
[v, index] = sort(PR1);
for ii = 1:length(listname)
    [filepath,name,ext] = fileparts(listname{index(ii)});
    listname2{ii} = [name ext];
end

save(fullfile(path,'sortlist.mat'),'listname2');
clear matmgc;