% ��ȡR��������R��λ�ý��зֶ�
% ��Ҫ�������ϵ�����ж���
% output: (nchan, 600, m) ÿ����������m������
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
