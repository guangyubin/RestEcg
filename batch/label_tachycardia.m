
function [label ,label_name] = label_tachycardia(DATA)
if isfield(DATA,'diag')
    diag = 'Diag = ';
    for kk = 1:length(DATA.diag)
        diag = [diag '  '  DATA.diag{kk}];
    end;
end

label_name = {'����Ķ�����','�����Ķ�����','�������Ķ�����','�ķ�����','�ķ��˶�','�����������Ķ�����','F��','P��ȱʧ'};

label = zeros(1,8);
if strfind(diag,'����Ķ�����')
    label(1) = 1;
    if strfind(diag,'�����Ķ�����')
        label(6) = 1;
    end
end

a = strfind(diag,'�����Ķ�����') ;
if length(strfind(diag,'�����Ķ�����')) > 0  && ~length(strfind(diag,'���������Ķ�����')>0) &&~ length(strfind(diag,'���')>0)&&~length(strfind(diag,'����Ķ�����')>0)&& ~length(strfind(diag,'�������Ķ�����')>0)&&~length(strfind(diag,'�ķ�����')>0)&&~length(strfind(diag,'�ķ��˶�')>0)
    label(2) = 1;
end


if strfind(diag,'�������Ķ�����')
    label(3) = 1;
    if strfind(diag,'�����Ķ�����')
        label(6) = 1;
    end
end

if strfind(diag,'�ķ�����')
    label(4) = 1;
    
    if strfind(diag,'�����Ķ�����')
        label(6) = 1;
    end
    
    if  DATA.Meas.AtrialRate-DATA.Meas.VentricularRate >100
        label(7) = 1;
    else
        label(8) = 1;
    end;
end

if strfind(diag,'�ķ��˶�')
    label(5) = 1;
    if strfind(diag,'�����Ķ�����')
        label(6) = 1;
    end
        if  DATA.Meas.AtrialRate-DATA.Meas.VentricularRate >100
        label(7) = 1;
    else
        label(8) = 1;
    end;
end


                