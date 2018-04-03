%%
[wave,rpos,QRStype,wave_median,sr,label,Meas,Meas_Orig,diag,diag_orig,Meas_Matrix1,adu,PatientID]= musexmlread('D:\DataBase\MUSE\MUSE_20130414_165613_52000.xml');
 [wave,rpos,QRStype,wave_median,sr,label,Meas,Meas_Orig,diag,diag_orig,Meas_Matrix2,adu,PatientID]= musexmlread('C:\Users\BJUT_BME\Desktop\整理数据\C448566.xml');
  [wave,rpos,QRStype,wave_median,sr,label,Meas,Meas_Orig,diag,diag_orig,Meas_Matrix3,adu,PatientID]= musexmlread('C:\Users\BJUT_BME\Desktop\整理数据\C539104.xml');
  [wave,rpos,QRStype,wave_median,sr,label,Meas,Meas_Orig,diag,diag_orig,Meas_Matrix4,adu,PatientID]= musexmlread('C:\Users\BJUT_BME\Desktop\整理数据\D804483.xml');

  
  a = [Meas_Matrix1 Meas_Matrix2 Meas_Matrix3];
  
  %%
  x= [];
  chanlist = [3, 4,5,6,7,8,1,11,2,12,9,10];
   y = Meas_Matrix1(37:end);
 y = reshape(y,[212 12]);
  pos = [7, 23,39,43,55,59,71,75,87,91,103,119,123,127,159,175];
  for ii = 1:length(pos)
      for jj = 1:12
          x(jj,ii) = typecast(y([pos(ii) pos(ii)+1],chanlist(jj)),'int16');
      end
  end;


 %%

 
  y1 = Meas_Matrix2(37:end);
 y1 = reshape(y1,[212 12]);
 
  y3 = Meas_Matrix3(37:end);
 y3 = reshape(y3,[212 12]);
 
  
  y4 = Meas_Matrix4(37:end);
 y4 = reshape(y4,[212 12]);