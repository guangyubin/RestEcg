% 提取R波后，利用R波位置进行分段
% 需要利用相关系数进行对齐
% output: (nchan, 600, m) 每导联对其后的m个心拍
% Author: guangyubin@bjut.edu.cn
%         2017/11/14

function segdata = beat_segment_c(wave,rpos,QRStype,type,tleft,tright)%segdata


rpos0 = rpos( (QRStype==type ));

wave_segment = [];


m = 1;
for jj = 1:length(rpos0)
    if rpos0(jj) > tleft && rpos0(jj) +tright < size(wave,1)
        tmp = wave(rpos0(jj) - tleft: rpos0(jj) +tright,: );
%         tmp  =detrend(tmp);
        wave_segment(:,:,m) = tmp;
        m = m +1;
    end
end
segdata = median(wave_segment,3);
