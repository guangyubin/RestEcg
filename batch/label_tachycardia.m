
function [label ,label_name] = label_tachycardia(DATA)
if isfield(DATA,'diag')
    diag = 'Diag = ';
    for kk = 1:length(DATA.diag)
        diag = [diag '  '  DATA.diag{kk}];
    end;
end

label_name = {'窦性心动过速','室性心动过速','室上性心动过速','心房颤动','心房扑动','短暂性室性心动过速','F波','P波缺失'};

label = zeros(1,8);
if strfind(diag,'窦性心动过速')
    label(1) = 1;
    if strfind(diag,'室性心动过速')
        label(6) = 1;
    end
end

a = strfind(diag,'室性心动过速') ;
if length(strfind(diag,'室性心动过速')) > 0  && ~length(strfind(diag,'短阵室性心动过速')>0) &&~ length(strfind(diag,'窦性')>0)&&~length(strfind(diag,'窦性心动过速')>0)&& ~length(strfind(diag,'室上性心动过速')>0)&&~length(strfind(diag,'心房颤动')>0)&&~length(strfind(diag,'心房扑动')>0)
    label(2) = 1;
end


if strfind(diag,'室上性心动过速')
    label(3) = 1;
    if strfind(diag,'室性心动过速')
        label(6) = 1;
    end
end

if strfind(diag,'心房颤动')
    label(4) = 1;
    
    if strfind(diag,'室性心动过速')
        label(6) = 1;
    end
    
    if  DATA.Meas.AtrialRate-DATA.Meas.VentricularRate >100
        label(7) = 1;
    else
        label(8) = 1;
    end;
end

if strfind(diag,'心房扑动')
    label(5) = 1;
    if strfind(diag,'室性心动过速')
        label(6) = 1;
    end
        if  DATA.Meas.AtrialRate-DATA.Meas.VentricularRate >100
        label(7) = 1;
    else
        label(8) = 1;
    end;
end


                