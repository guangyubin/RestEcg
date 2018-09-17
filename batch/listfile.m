function listname = listfile(path)

list = dir(fullfile(path ,'*.mat'));
listname = [];
for ii = 1:length(list)-1
     listname{ii} = fullfile(path,list(ii).name);
end