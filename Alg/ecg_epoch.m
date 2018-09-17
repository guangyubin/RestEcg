% ��ȡR��������R��λ�ý��зֶ�
% ��Ҫ�������ϵ�����ж���
% output: (nchan, 600, m) ÿ����������m������
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


