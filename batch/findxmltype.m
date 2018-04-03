function findxmltype(path,outpth,type,key)


if ~exist(outpth,'dir')
    mkdir(outpth);
end




list = dir(fullfile(path,'*.xml'));
%133
DATA = [];
m = 1;

% fprintf(fid , 'ID','PatientLastName','PatientAge','DateofBirth','HeightCM','WeightKG',
% 'VentricularRate','')
for ii = 1: length(list)
    fname = fullfile(path,list(ii).name);
    
%     [wave,rpos,QRStype,wave_median,sr,label,Meas,Meas_Orig,diag,diag_orig,Meas_Matrix,adu,PatientID]...
%         = musexmlread(fname);
     [diag,diag_orig] = musereaddiag(fname);
    diag_str = [];
    for kk = 1:length(diag)
        diag_str = [diag_str diag{kk}];
    end
    
    for kk = 1: length(type)
        
        if ~exist(fullfile(outpth,type{kk}),'dir')
            mkdir(fullfile(outpth,type{kk}));
        end
        if (~isempty(strfind(diag_str,key{kk,1}))) &&   (~isempty(strfind(diag_str,key{kk,2})))
            disp(type{kk});
            copyfile(fname,fullfile(outpth,type{kk}));
        end
    end
    
end