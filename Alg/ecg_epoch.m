% 提取R波后，利用R波位置进行分段
% 需要利用相关系数进行对齐
% output: (nchan, 600, m) 每导联对其后的m个心拍
% Author: guangyubin@bjut.edu.cn
%         2017/11/14

function segdata = ecg_epoch(ecg,rpos,tleft,tright)%segdata

m = 1;
segdata= [];
for ii = 1:length(rpos)    
    if  rpos(ii)+tright < length(ecg) && rpos(ii)-tright> 0
        x = ecg(rpos(ii) - tleft: rpos(ii)+tright);;
        x = x - mean(x);
        segdata(m,:) = x;
        amp(m) = max(x)-min(x);
        m = m +1;
    end
end

ma = median(amp);
index = find( abs(amp -ma) < ma);
segdata = segdata(index,:);


