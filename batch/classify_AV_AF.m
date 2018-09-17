% �Ķ������б�
% ���ʴ���100bpm�� ���������Ķ����٣��������Ķ����٣����������˺�����Ķ�����
%%
pathlist = {'D:\MGCDB\muse\classify\�����ĵ�ͼ',...
    'D:\MGCDB\muse\classify\һ�ȷ�������',...
    'D:\MGCDB\muse\classify\����I�ͷ�������',...
    'D:\MGCDB\muse\classify\����II�ͷ�������',...
    'D:\MGCDB\muse\classify\���ȷ�������',...
    'D:\MGCDB\muse\classify\�ķ�����',...
    'D:\MGCDB\muse\classify\�ķ��˶�'};



listname = [];
listlabel = [];;
group = [];
m = 1;
for type = 1:length(pathlist)
    path = pathlist{type};
    list = dir(fullfile(path ,'*.mat'));
    for ii = 1:min(5000,length(list))
        fname = fullfile(path,list(ii).name);
        clear DATA;
        load(fname);
        try
            if DATA.Meas.VentricularRate <=100

                    listname{m} = fullfile(path,list(ii).name);
                    [listlabel(m,:) ,label_name] = label_tachycardia(DATA);    
                    group(m) =type;
                    m = m +1;         
                
            end
        catch
            
        end
    end
end

save('D:\MGCDB\muse\classify\listfile_AF_AV.mat','listname','listlabel');
%%
load('D:\MGCDB\muse\classify\listfile_AF_AV.mat');
tachycardia = [];
for ii = 1:length(listname)
    load(listname{ii});
    d = floor(200*DATA.wave*DATA.adu/1000);
    if DATA.fs==500
        d = d(1:2:end,:);
    end;
    [meanwave, rpos,QRStype ,ppos,pqrst, ecgmeas , wave , pout , pmeanwave, pchan,av,m_DiagnosticTach,tachycardia(ii,:)]  = matrestecg('mat_restecg_Process',d,250,200);
 
end

clear matrestecg;

%%

X = tachycardia;
Y = group;
Y(Y==1|Y==2 | Y==3 | Y==4 | Y==5) = 0;
Y(Y==6) = 4;
Y(Y==7) = 4;
Mdl7 = fitctree(X,Y,'OptimizeHyperparameters','auto' ,'Prior' ,[ 4 1 1 ] );

% Mdl7 = fitctree(X,Y,'MaxNumSplits',12 ,'Prior' ,[ 3 1] );

label = predict(Mdl7,X);
%%
confusion_matrix(label,Y' ,1);

% classError7 = kfoldLoss(Mdl7)
%%
view(Mdl7,'Mode','graph')
%%
saveCompactModel(Mdl7,'Md17_AV_AF');
%%
% [v, index] = sort(bvta);
% listname = listname(index);
% save('D:\MGCDB\muse\classify\listfile_�Ķ�����.mat','listname','group');