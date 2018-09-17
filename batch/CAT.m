% 心动过速判别
% 心率大于100bpm， 分类室性心动过速，室上性心动过速，房颤，房扑和窦性心动过速
%%
pathlist = {'D:\MGCDB\muse\classify\窦性心动过速',...
    'D:\MGCDB\muse\classify\室性心动过速',...
    'D:\MGCDB\muse\classify\室上性心动过速',...
    'D:\MGCDB\muse\classify\心房颤动',...
    'D:\MGCDB\muse\classify\心房扑动'};

listname = [];
listlabel = [];;
group = [];
m = 1;
for type = 1:length(pathlist)
    path = pathlist{type};
    list = dir(fullfile(path ,'*.mat'));
    for ii = 1:length(list)
        fname = fullfile(path,list(ii).name);
        clear DATA;
        load(fname);
        try
            if DATA.Meas.VentricularRate >100
                label = label_tachycardia(DATA);
                if (label(6)==1 && label(2)~=1) | max(label)==0
                    disp(1);
                else
                    listname{m} = fullfile(path,list(ii).name);
                    [listlabel(m,:) ,label_name] = label_tachycardia(DATA);    
                    group(m) = find(listlabel(m,1:5)==1);
                    m = m +1;
                end
                
            end
        catch
        end
    end
end

save('D:\MGCDB\muse\classify\listfile_心动过速.mat','listname','listlabel');
%%
load('D:\MGCDB\muse\classify\listfile_心动过速.mat');

tachycardia = [];
group = [];
for ii = 1:length(listname)
    load(listname{ii});
    d = floor(200*DATA.wave*DATA.adu/1000);
    if DATA.fs==500
        d = d(1:2:end,:);
    end;
    [meanwave, rpos,QRStype ,ppos,pqrst, ecgmeas , wave , pout , pmeanwave, pchan,av,m_DiagnosticTach,tachycardia(ii,:)]  = matrestecg('mat_restecg_Process',d,250,200);
     label = label_tachycardia(DATA);
    group(ii) = find(label(1:5)==1);
end

clear matrestecg;

%%
X = tachycardia;
Y = group;
% Y(Y==4) = 3;
% Y(Y==5) = 3;
Mdl7 = fitctree(X,Y,'Prior','uniform','OptimizeHyperparameters','auto'  );

% Mdl7 = fitctree(X,Y,'Prior','uniform','MaxNumSplits',8  );

label = predict(Mdl7,X);
confusion_matrix(group',label,1);

% classError7 = kfoldLoss(Mdl7)
view(Mdl7,'Mode','graph')
%%
saveCompactModel(Mdl7,'Md17_tach');
%%
% [v, index] = sort(bvta);
% listname = listname(index);
% save('D:\MGCDB\muse\classify\listfile_心动过速.mat','listname','group');