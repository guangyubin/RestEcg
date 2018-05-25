function [param0,param1,res] =  matStatisticpath(listname)


param0 = zeros(7,length(listname));
param1 = param0;

parfor ii = 1:length(listname)
    fname = listname{ii};
    a = load(fname);
    try
        DATA = a.DATA;
        f = fieldnames(DATA.Meas);
        for kk = 1:length(f)
            if isempty(getfield(DATA.Meas,f{kk}))
                DATA.Meas = setfield(DATA.Meas,f{kk},nan);
            end
        end
        [meanwave, rpos,QRStype ,pqrst,ecgmeas]  = matmgc('mat_restecg_Process',floor(200*DATA.wave*DATA.adu/1000),DATA.fs,200);
        a = [DATA.Meas.PRInterval DATA.Meas.QRSDuration DATA.Meas.QTInterval DATA.Meas.VentricularRate DATA.Meas.PAxis DATA.Meas.RAxis DATA.Meas.TAxis];
        b = [ecgmeas.PRInterval ecgmeas.QRSDuration ecgmeas.QTInterval ecgmeas.VentricularRate ecgmeas.PAxis ecgmeas.RAxis ecgmeas.TAxis];
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

