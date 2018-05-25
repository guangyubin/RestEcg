% load('D:\MGCDB\muse\dbindex.mat');
typelist = {'�����ĵ�ͼ','�������;','����Ķ�����','����Ķ�����','������ɲ���'...
    '�����粫','�����ںϲ�','�����ݲ�����','�ɶ�����','���Զ�����','����������','�����Ķ�����',...
    '�ķ�����','�ķ��˶�','�������Ķ�����',...
    'һ�ȷ�������','����I�ͷ�������', '����II�ͷ�������','���ȷ�������','�߶ȷ�������',...
    '����֧����','����֧����','��������','��ǰ��֧����',...
    '������ƫ','������ƫ','���᲻ȷ��',...
    'P������','P������','P���߼�',...
    '�����Ҹߵ�ѹ','�����Ҹߵ�ѹ','֫�嵼���͵�ѹ','��ǰ�����͵�ѹ',...
    'QTc�����ӳ�','QTc��������',...
    '�����粫','�������Ķ�����','�ɶԷ���','�����ݲ�����',...
    'ST�ι�����̧��','r����������',...
    '�ķ���','������',...
    '�쳣Q��','�ĵ�ͼ������ST-T','�ĵ�ͼ������ST','�ĵ�ͼ������T' };

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
    if strfind(dbindex{ii,2},'һ�ȷ�������')
        type = 1;
    end
     if strfind(dbindex{ii,2},'�����ĵ�ͼ')
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