%%
wave= myData.wave;
if size(wave,1)==5000
    wave = wave(1:2:end,:);
end
rpos = myData.rpos;
wave_median = myData.meanwave;
pqrst = myData.pqrst;



% residual = FECGSYN_ts_extraction(rpos,wave(:,3)','TS-PCA',1, 5,'',250);
% 


%%
x = wave(:,2);
y = wave_median(:,2);
figure;subplot(411);plot(x); hold on;plot(rpos,x(rpos),'.r');

subplot(412);plot(y);
% x1 = matmgc('do_baseline_remove',x,rpos-100+(pqrst(3)+pqrst(4))/2);
% figure;plot(x-x1'); hold on;plot(x);



% x = x-x1';
x2 = zeros(1,length(x));

ttt = [];
for ii = 1:length(rpos)
    
    t = pqrst(6)+5 :pqrst(9)+10 ;   
    if t(end)+rpos(ii)-100+1 <= length(x)
        if myData.QRStype==0
        tmp =   x(t+rpos(ii)-100+1);
        M =  [ y(t) ones(length(t),1)];
        a =  (M'*M)\M'*tmp;
        x2(t+rpos(ii)-100+1) = (M*a)';
        else
           x2(t+rpos(ii)-100+1) = x(t+rpos(ii)-100+1);
        end
        
        t = pqrst(4)-4 :pqrst(6)+5 ;
        x2(t+rpos(ii)-100+1) = x(t+rpos(ii)-100+1);
    end    
end;
x2(1:100) = x (1:100);
x2(end-100:end) = x(end-100:end);
index = x2(x2~=0);
x2(1) = index(1);
x2(end) = index(end);
x2 = interp1(find(x2~=0),x2((x2~=0)),1:length(x));


x3 = smooth(x - x2',5);
rpos = matrestecg('restecg_QRSDetector',x3*5);
subplot(413);;plot(x); hold on;plot(x2);
subplot(414);plot(x3);hold on;plot(rpos,x3(rpos),'.r');
%%

% for ii = 1:length(rpos)
%     
%     t = pqrst(4)-3  :pqrst(6)+4 ;  
%     t = t+rpos(ii)-100+1;
%     dt = (x3(t(end)) - x3(t(1)) )/(length(t)-1);
%     
%     tmp = x3(t(1)) + (t - t(1))*dt;
%     x3(t) =  tmp ;
% end;
% hold on;plot(x3);
% % 
% figure;
% plot(x3);
% 





