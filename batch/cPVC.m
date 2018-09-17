path = 'D:\MGCDB\muse\classify\正常心电图';
disp(path)
listname = listfile(path);
[param0,param1,res,PVC] =  matStatisticpath(listname);



[v, index] = sort( abs(param1(2,:) - param0(2,:)) );
for ii = 1:length(listname)
    [filepath,name,ext] = fileparts(listname{index(ii)});
    listname2{ii} = [name ext];
end

save(fullfile(path,'sortlist.mat'),'listname2');
%%
disp('室性早搏===============================================================')

listname2 = [];
[v, index] = sort(PVC);
for ii = 1:length(listname)
    [filepath,name,ext] = fileparts(listname{index(ii)});
    listname2{ii} = [name ext];
end

save(fullfile(path,'sortlist.mat'),'listname2');
disp(length(PVC))