
clc
clear
path = 'D:\DataBase\MUSE';
outpth = 'D:\DataBase\MUSE_Classify';


type = {'������ƫ', '������ƫ','�±ڹ���','ǰ�ڹ���'};
key = {'����','��ƫ'; '����','��ƫ';'�±�','����'; 'ǰ��','����'};

findxmltype(path,outpth,type,key);
