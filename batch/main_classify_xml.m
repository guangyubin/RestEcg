
clc
clear
path = 'D:\DataBase\MUSE';
outpth = 'D:\DataBase\MUSE_Classify';


type = {'电轴右偏', '电轴左偏','下壁梗死','前壁梗死'};
key = {'电轴','右偏'; '电轴','左偏';'下壁','梗死'; '前壁','梗死'};

findxmltype(path,outpth,type,key);
