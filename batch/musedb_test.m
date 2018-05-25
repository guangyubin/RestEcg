% load('D:\MGCDB\muse\dbindex.mat');
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

for ii = 1:length(dbindex)
    
    for kk = 1:length(typelist)
        if strfind(dbindex{ii,2},typelist{kk})
            outpth = ['D:\MGCDB\muse\classify\' typelist{kk}];
            if ~exist(outpth,'dir')
                mkdir(outpth);
            end
            fname = [dbindex{ii,1} '.mat'];
            copyfile(fullfile('D:\MGCDB\muse\mat\', fname) ,fullfile(outpth,fname));
        end
    end
end

    
    
    %%

m = 1;
param0 = [];
param1 = [];
for ii = 1:length(dbindex)
    type = 0 ; 
    if strfind(dbindex{ii,2},'一度房室阻滞')
        type = 1;
    end
     if strfind(dbindex{ii,2},'正常心电图')
         type = 2;
     end;
    if type ~=0
        load(['D:\MGCDB\muse\mat\'  dbindex{ii,1}]);
       [meanwave, rpos,QRStype ,pqrst,ecgmeas]  = matmgc('mat_restecg_Process',200*DATA.wave*DATA.adu/1000,DATA.fs,200);
        
        f = fieldnames(DATA.Meas);
        for kk = 1:length(f)
            if isempty(getfield(DATA.Meas,f{kk}))
                DATA.Meas = setfield(DATA.Meas,f{kk},nan);
            end;
        end
            
       a = [DATA.Meas.PRInterval DATA.Meas.QRSDuration DATA.Meas.QTInterval DATA.Meas.VentricularRate DATA.Meas.PAxis DATA.Meas.RAxis DATA.Meas.TAxis];
       b = [ecgmeas.PRInterval ecgmeas.QRSDuration ecgmeas.QTInterval ecgmeas.VentricularRate ecgmeas.PAxis ecgmeas.RAxis ecgmeas.TAxis];
       a = double(a);
       b = double(b);
       param0(:,m) =  a;
       param1(:,m) =  b;
       group(m) = type;
      m = m +1;
      if mod(m,100)==0
          disp(m)
      end;
    
    end
end

for ii = 1: size(param0,1)
    res(ii,:) = meas_qt(param0(ii,:),param1(ii,:));
end

%% 
figure;gscatter(param0(1,:),param1(1,:),group);
hold on;plot([0 0 ],[500 500],'r');

length(param0(1,:)>200)
length(param1(1,:)>200)