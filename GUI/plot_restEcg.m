
function plot_restEcg(ecg,fs,rpos,type, txtpos ,clr ,pqtpos , bline )

if nargin < 6
    pqtpos = [];
    clr = 'k'
    bline = 0 ;
end;
% ecg = DATA(1).wave;
% rpos = DATA(1).rpos;
% type = DATA(1).QRStype;
% fs = DATA(1).fs;
% txtpos = -1;
rpos  = double(rpos);

labelname = {'I','II', 'III', 'avR', 'avL', 'avF', 'V1', 'V2','V3','V4','V5','V6'};
ecg12 =  zeros(size(ecg, 1), 12);
ecg12(:, 1) = ecg(:, 1);
ecg12(:, 2) = ecg(:, 2);
ecg12(:,3) = ecg(:, 2)  - ecg(:, 1);
ecg12(:,4) = -(ecg(:, 1) + ecg(:, 2))/2;
ecg12(:, 5) = ecg(:, 1)  - ecg(:, 2)/2;
ecg12(:, 6) = ecg(:, 2)  - ecg(:, 1)/2;
ecg12(:,7:12) = ecg( :,3:8);
ecg =ecg12;

t = ( 1:size(ecg,1))/fs;
for ii = 1 : size(ecg,2)
    x = ecg(:,ii);
    x = x - mean(x);
    plot(t,x-4*ii,clr);hold on;
    
    text(-0.3,-4*ii,labelname(ii),'Color','b');
end

for ii =1:length(rpos)
    if type(ii)==0
     text(rpos(ii)/fs,txtpos,num2str(type(ii)),'Color','b');
    else
        text(rpos(ii)/fs,txtpos,num2str(type(ii)),'Color','r');
    end
    if bline == 1
    if rpos(ii) > 0 
    plot([t(rpos(ii)) t(rpos(ii))], [-32 0],'k');
    end
    end
    
end;
grid on;


set(gca,'ytick',-40:1:0)
set(gca,'GridColor',[1 0 0 ],'MinorGridColor',[0.8 0 0],'GridAlpha',0.25,'MinorGridAlpha',0.6);
set(gca,'XTick',0:0.2:t(end));
set(gca,'YTickLabel','');
set(gca,'XTickLabel','');
hold off;