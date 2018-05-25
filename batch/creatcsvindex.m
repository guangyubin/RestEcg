%%
%% 1 Creat csv label

path_muse = 'D:\MGCDB\MUSE_Classify\MuseLargError';
path_out = 'D:\MGCDB\muse';

fid_csv = fopen(fullfile(path_out,'index1.csv'),'w+');

typelist = {'正常心电图','窦性心率','室性早搏','室性逸搏心律','心房颤动','房扑','1度房室传导阻滞','异常Q波','右束支传导阻滞','左束支传导阻滞','ST段弓背型抬高','R波递增不良'};
title = 'FileName,diag,diag_orig';
fprintf(fid_csv,'FileName,');
for ii = 1:length(typelist)
    fprintf(fid_csv,'%s,', typelist{ii});
end
fprintf(fid_csv,'diag,diag_orig\n');


%%
list = dir(fullfile(path_muse,'*.xml'));
for kk = 1 : 2 %length(list)
    fname = fullfile(path_muse,list(kk).name);
    Fname=list(kk).name;
    [DATA.wave,DATA.rpos,DATA.QRStype,DATA.wave_median,DATA.fs,DATA.label,DATA.Meas,DATA.Meas_Orig,DATA.diag,DATA.diag_orig,DATA.Meas_Matrix,DATA.adu,DATA.PatientInfo]=musexmlread(fname);
   
    save(fullfile(path_out,Fname(1:end-4)),'DATA');    
    fprintf(fid_csv,'%s,',Fname(1:end-4));
    diag_str = [];
    for ii = 1:length(DATA.diag)
        str = DATA.diag{ii};
        str(str ==',') = ';';
        diag_str = [diag_str str];
        
    end    
   diagorg_str = [];
    for ii = 1:length(DATA.diag_orig)
        str = DATA.diag_orig{ii};
        str(str ==',') = ';';
         diagorg_str = [diagorg_str str];
      
    end
    for ii = 1:length(typelist)
        if contains(diag_str,typelist{ii})
             fprintf(fid_csv,'1,');
        else
             fprintf(fid_csv,'0,');
        end
    end
    fprintf(fid_csv,'%s,',diag_str);
   fprintf(fid_csv,'%s,',diagorg_str);
    fprintf(fid_csv,'\n');
    
    
end
fclose(fid_csv);

%%

%%
