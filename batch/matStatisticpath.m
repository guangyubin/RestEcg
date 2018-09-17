function [param0,param1,res,PVC] =  matStatisticpath(listname)

% path = 'D:\MGCDB\muse\classify\ÊÒÐÔÔç²«';
% disp(path)
% listname = listfile(path);
param0 = zeros(7,length(listname));
param1 = param0;
PVC = zeros(1,length(listname));
for ii = 1:length(listname)
    fname = listname{ii};
    disp(fname)
    a = load(fname);
    try
        DATA = a.DATA;
        f = fieldnames(DATA.Meas);
        for kk = 1:length(f)
            if isempty(getfield(DATA.Meas,f{kk}))
                DATA.Meas = setfield(DATA.Meas,f{kk},nan);
            end
        end
%         [meanwave, rpos,QRStype ,pvcindex,pqrst2,ecgmeas2 , dataout]
         [meanwave, rpos,QRStype ,pvcindex,pqrst,ecgmeas , dataout] = matrestecg('mat_restecg_Process',floor(200*DATA.wave*DATA.adu/1000),DATA.fs,200);
        a = [DATA.Meas.PRInterval DATA.Meas.QRSDuration DATA.Meas.QTInterval DATA.Meas.VentricularRate DATA.Meas.PAxis DATA.Meas.RAxis DATA.Meas.TAxis];
        b = [ecgmeas.PRInterval ecgmeas.QRSDuration ecgmeas.QTInterval ecgmeas.VentricularRate ecgmeas.PAxis ecgmeas.RAxis ecgmeas.TAxis];
        PVC(:,ii) = max(pvcindex);
        if length(a) == length(b)
            param0(:,ii) =  a;
            param1(:,ii) =  b;
        end
    catch
    end
    
end
res= zeros(7,7);
for ii = 1: size(param0,1)
    res(ii,:) = meas_qt(param0(ii,:),param1(ii,:));
end

