

metric_Regular = [];
label = [];
m = 1;

path = 'D:\MGCDB\muse\classify\�ķ�����';
list = dir(fullfile(path ,'*.mat'));
for ii = 1:length(list)
    fname = fullfile(path,list(ii).name);
    load(fname); 
    d = floor(200*DATA.wave*DATA.adu/1000);
    if DATA.fs==500
        d = d(1:2:end,:);
    end
    [meanwave, rpos,QRStype ,ppos,pqrst, ecgmeas , wave , pout , pmeanwave, pchan,av,metric_Regular(m,:)]  = matrestecg('mat_restecg_Process',d,250,200);
 
    label(m,:) = 1;
    m = m +1;
end

path = 'D:\MGCDB\muse\classify\�ķ��˶�';
list = dir(fullfile(path ,'*.mat'));
for ii = 1:length(list)
    fname = fullfile(path,list(ii).name);
    load(fname); 
    d = floor(200*DATA.wave*DATA.adu/1000);
    if DATA.fs==500
        d = d(1:2:end,:);
    end
    [meanwave, rpos,QRStype ,ppos,pqrst, ecgmeas , wave , pout , pmeanwave, pchan,av,metric_Regular(m,:)]  = matrestecg('mat_restecg_Process',d,250,200);
    label(m,:) = 2;
    m = m +1;
end

path = 'D:\MGCDB\muse\classify\�����ĵ�ͼ';
list = dir(fullfile(path ,'*.mat'));
for ii = 1:length(list)
    fname = fullfile(path,list(ii).name);
    load(fname); 
    d = floor(200*DATA.wave*DATA.adu/1000);
    if DATA.fs==500
        d = d(1:2:end,:);
    end
    [meanwave, rpos,QRStype ,ppos,pqrst, ecgmeas , wave , pout , pmeanwave, pchan,av,metric_Regular(m,:)]  = matrestecg('mat_restecg_Process',d,250,200);
    label(m,:) = 0;
    m = m +1;
end
%%
path = 'D:\MGCDB\muse\classify\һ�ȷ�������';
list = dir(fullfile(path ,'*.mat'));
for ii = 1:length(list)
    fname = fullfile(path,list(ii).name);
    load(fname); 
    d = floor(200*DATA.wave*DATA.adu/1000);
    if DATA.fs==500
        d = d(1:2:end,:);
    end
    [meanwave, rpos,QRStype ,ppos,pqrst, ecgmeas , wave , pout , pmeanwave, pchan,av,metric_Regular(m,:)]  = matrestecg('mat_restecg_Process',d,250,200);
    label(m,:) = 3;
    m = m +1;
end

path = 'D:\MGCDB\muse\classify\����I�ͷ�������';
list = dir(fullfile(path ,'*.mat'));
for ii = 1:length(list)
    fname = fullfile(path,list(ii).name);
    load(fname); 
    d = floor(200*DATA.wave*DATA.adu/1000);
    if DATA.fs==500
        d = d(1:2:end,:);
    end
    [meanwave, rpos,QRStype ,ppos,pqrst, ecgmeas , wave , pout , pmeanwave, pchan,av,metric_Regular(m,:)]  = matrestecg('mat_restecg_Process',d,250,200);
    label(m,:) = 4;
    m = m +1;
end

path = 'D:\MGCDB\muse\classify\����II�ͷ�������';
list = dir(fullfile(path ,'*.mat'));
for ii = 1:length(list)
    fname = fullfile(path,list(ii).name);
    load(fname); 
    d = floor(200*DATA.wave*DATA.adu/1000);
    if DATA.fs==500
        d = d(1:2:end,:);
    end
    [meanwave, rpos,QRStype ,ppos,pqrst, ecgmeas , wave , pout , pmeanwave, pchan,av,metric_Regular(m,:)]  = matrestecg('mat_restecg_Process',d,250,200);
    label(m,:) = 5;
    m = m +1;
end
path = 'D:\MGCDB\muse\classify\������ɲ���';
list = dir(fullfile(path ,'*.mat'));
for ii = 1:length(list)
    fname = fullfile(path,list(ii).name);
    load(fname); 
    d = floor(200*DATA.wave*DATA.adu/1000);
    if DATA.fs==500
        d = d(1:2:end,:);
    end
    [meanwave, rpos,QRStype ,ppos,pqrst, ecgmeas , wave , pout , pmeanwave, pchan,av,metric_Regular(m,:)]  = matrestecg('mat_restecg_Process',d,250,200);
    label(m,:) = 6;
    m = m +1;
end
%%
path = 'D:\MGCDB\muse\classify\�����粫';
list = dir(fullfile(path ,'*.mat'));
for ii = 1:length(list)
    fname = fullfile(path,list(ii).name);
    load(fname); 
    d = floor(200*DATA.wave*DATA.adu/1000);
    if DATA.fs==500
        d = d(1:2:end,:);
    end
    
    [meanwave, rpos,QRStype ,ppos,pqrst, ecgmeas , wave , pout , pmeanwave, pchan,av,metric_Regular(m,:)]  = matrestecg('mat_restecg_Process',d,250,200);
    label(m,:) = 7;
    m = m +1;
    
end
