function findxmltype(path,outpth,type, filetype)

if ~exist(outpth,'dir')
    mkdir(outpth);
end

if strcmp(filetype,'mat')
    list = dir(fullfile(path,'*.mat'));
end
if strcmp(filetype,'xml')
    list = dir(fullfile(path,'*.xml'));
end


for ii = 1: length(list)
    fname = fullfile(path,list(ii).name);
    if strcmp(filetype,'mat')
        load(fname);
        diag = DATA.diag;
    else
        [diag,diag_orig] = musereaddiag(fname);
    end
    diag_str = [];
    for kk = 1:length(diag)
        diag_str = [diag_str  diag{kk}];
    end
%     for mm = 1:length(diag_orig)
%         diag_str = [diag_str diag_orig{mm}];
%     end

    
    for jj = 1: length(type)
        
        if ~exist(fullfile(outpth,type{jj}),'dir')
            mkdir(fullfile(outpth,type{jj}));
        end
        if contains(diag_str,type{jj}) && ~contains(diag_str,['²»' type{jj}])
            disp(type{jj});
            copyfile(fname,fullfile(outpth,type{jj}));
        end
%         if (~isempty(strfind(diag_str,key{jj,1}))) &&   (~isempty(strfind(diag_str,key{jj,2})))
%             disp(type{jj});
%             copyfile(fname,fullfile(outpth,type{jj}));
%         end
    end
    
end