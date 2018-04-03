% ≤‚ ‘median wave database

%%

% load('D:\MGCDB\muse\MuseDB_500Hz.mat');
% datalist = DATA;


param0 = zeros(7,length(datalist));
param1 = param0;
for ii = 1:length(datalist)

Meas = datalist(ii).Meas;
    [dataout, meanwave, rpos,QRStype,  pqrst , ecgmeas] = ProcRestEcg(datalist(ii).wave,datalist(ii).fs);
%      ecgmeas.PAxis = acrdiac_EAxis(meanwave(:,1), meanwave(:,2), pqrst(1), pqrst(3));
%     ecgmeas.RAxis = acrdiac_EAxis(meanwave(:,1), meanwave(:,2), pqrst(4), pqrst(6));
%     ecgmeas.TAxis = acrdiac_EAxis(meanwave(:,1), meanwave(:,2), pqrst(6), pqrst(9));
   if isempty(Meas.PRInterval)
        Meas.PRInterval = nan;
   end
    
    if ~isfield(Meas,'PAxis') ||  isempty(Meas.PAxis) 
        Meas.PAxis= nan;
    end

    param0(1,ii) =  Meas.PRInterval;
    param0(2,ii) = Meas.QRSDuration;
    param0(3,ii) = Meas.QTInterval ;
    param0(4,ii) = Meas.VentricularRate;
    param0(5,ii) = Meas.PAxis;
    param0(6,ii) = Meas.RAxis;
    param0(7,ii) = Meas.TAxis;
    
    param1(1,ii) =  ecgmeas.PRInterval;
    param1(2,ii) = ecgmeas.QRSDuration;
    param1(3,ii) = ecgmeas.QTInterval ;
    param1(4,ii) = ecgmeas.VentricularRate;
    param1(5,ii) = ecgmeas.PAxis;
    param1(6,ii) = ecgmeas.RAxis;
    param1(7,ii) = ecgmeas.TAxis;

  


end
%%
for ii = 1: size(param0,1)
    meas_qt(param0(ii,:),param1(ii,:));
end

clear matmgc
