
%%
fid = fopen('D:\MGCDB\muse\index1.csv','r');

m = 1;
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


gcount= typelist'; 
for ii = 1:length(typelist)
    gcount{ii,2} = 0;
end;



str = fgetl(fid);
a = [];
m = 1 ; 
while ~feof(fid)
% for loops = 1:10
    str = fgetl(fid);
    in = strfind(str,',');
    in2 = [0 in length(str)+1];
    for ii = 1:length(in2)-1
        a{ii} = str(in2(ii)+1:in2(ii+1)-1);
    end
    fname = a{1};
    diag = a{2};
    diag_org = a{3};
    
    

    
 
   
    diag = strrep(diag, '�����ҵ�ѹ��', '�����Ҹߵ�ѹ');
    diag = strrep(diag, 'QT�����ӳ�', 'QTc�����ӳ�');
     diag = strrep(diag, '�쳣q��', '�쳣Q��');
       str_tmp = diag;
%     disp(diag)
    ss = [] ;
    for ii = 1:length(typelist)
        if contains(diag,typelist{ii},'IgnoreCase',true)
            
            type(ii) = 1;
            %             sprintf(fid2,'1,');
            ss = [ss '1,'];
            str_tmp = strrep(str_tmp,typelist{ii},[num2str(ii) ' ']);
             gcount{ii,2}  = gcount{ii,2} +1;
        else
            ss = [ss '0,'];
              type(ii) = 0;
            
        end
    end
    
    dbindex{m,1} = fname;
    dbindex{m,2} = diag;
    dbindex{m,3} = diag_org;
    dbindex{m,4} = str_tmp;
    dbindex{m,5} = type;
    m = m +1;

    %     disp(fname)
    
end
fclose(fid);





