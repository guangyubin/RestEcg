
function muse_deletepatientinfo(path0,path1)
% fname0 = 'D:\DataBase\MUSE_Classify\ÏÂ±Ú¹£ËÀ\MUSE_20130414_165614_69000.xml';
% fname_new = 'D:\DataBase\MUSE_Classify\ÏÂ±Ú¹£ËÀ\MUSE_20130414_165614_69000_3.xml';

list = dir(fullfile(path0,'*.xml'));
for kk = 1 : 10
    fname0 = fullfile(path0,list(kk).name);
    fname_new = fullfile(path1,list(kk).name);
    
    fid = fopen(fname0,'r','native','UTF-8');
    fid1 = fopen(fname_new,'w','native','UTF-8');
    
    bsave = 1;
    while ~feof(fid)
        tline = fgetl(fid);    
        if bsave == 1
            if contains(tline, 'PatientDemographics')  || contains(tline, 'TestDemographics') || contains(tline, 'PharmaData')
                bsave = 0 ;
            end
            fprintf(fid1,'%s\n',tline);            
        end        
        if contains(tline,  '/PatientDemographics>')   || contains(tline, '/TestDemographics')  || contains(tline, '/PharmaData')
            fprintf(fid1,'%s\n',tline);
            bsave = 1 ;
        end
        
        
%         disp(tline)
    end
    fclose(fid);
    fclose(fid1);
end


