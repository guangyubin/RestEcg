
%%
fid = fopen('D:\MGCDB\muse\index1.csv','r');

m = 1;
typelist = {'正常心电图','窦性心律;','窦性心动过速','窦性心动过缓','窦性心律不齐'...
    '室性早搏','室性融合波','室性逸搏心律','成对室早','室性二联律','室性三联律','室性心动过速',...
    '心房颤动','心房扑动','室上性心动过速',...
    '一度房室阻滞','二度I型房室阻滞', '二度II型房室阻滞','三度房室阻滞','高度房室阻滞',...
    '右束支阻滞','左束支阻滞','室内阻滞','左前分支阻滞',...
    '电轴右偏','电轴左偏','电轴不确定',...
    'P波增高','P波增宽','P波高尖',...
    '左心室高电压','右心室高电压','肢体导联低电压','胸前导联低电压',...
    'QTc间期延长','QTc间期缩短',...
    '房性早搏','短阵房性心动过速','成对房早','房性逸搏心律',...
    'ST段弓背型抬高','r波递增不良',...
    '心房起搏','心室起搏',...
    '异常Q波','心电图不正常ST-T','心电图不正常ST','心电图不正常T' };


gcount= typelist'; 
for ii = 1:length(typelist)
    gcount{ii,2} = 0;
end;



str = fgetl(fid);
a = [];
m = 1 ; 
while ~feof(fid)
% for loops = 1:10
    str = fgetl(fid);
    in = strfind(str,',');
    in2 = [0 in length(str)+1];
    for ii = 1:length(in2)-1
        a{ii} = str(in2(ii)+1:in2(ii+1)-1);
    end
    fname = a{1};
    diag = a{2};
    diag_org = a{3};
    
    

    
 
   
    diag = strrep(diag, '左心室电压高', '左心室高电压');
    diag = strrep(diag, 'QT间期延长', 'QTc间期延长');
     diag = strrep(diag, '异常q波', '异常Q波');
       str_tmp = diag;
%     disp(diag)
    ss = [] ;
    for ii = 1:length(typelist)
        if contains(diag,typelist{ii},'IgnoreCase',true)
            
            type(ii) = 1;
            %             sprintf(fid2,'1,');
            ss = [ss '1,'];
            str_tmp = strrep(str_tmp,typelist{ii},[num2str(ii) ' ']);
             gcount{ii,2}  = gcount{ii,2} +1;
        else
            ss = [ss '0,'];
              type(ii) = 0;
            
        end
    end
    
    dbindex{m,1} = fname;
    dbindex{m,2} = diag;
    dbindex{m,3} = diag_org;
    dbindex{m,4} = str_tmp;
    dbindex{m,5} = type;
    m = m +1;

    %     disp(fname)
    
end
fclose(fid);





