function  [ratio1 ,ratio2] = fwaveDetect(pout,rpos)

     x = pout(:,2); 
     Fx = abs(fft(x)).^2/(length(x)*length(x));
     mpf = max(Fx(31:71));
     bf = 10*(250/mean(diff(rpos)));
     bf = floor([1 2 3 4  5 6 7 8 9 10] *bf+1+0.5);
     for kk = 1:length(bf)
         pf(kk) = max(Fx(bf(kk)-2 : bf(kk)+2));
     end
     [v ,frq] = max(Fx(31:71));
     frq = frq+30;     
    [v1 ] = max(Fx(frq-2:frq+2));     
     r1 = (v)/ sum(pf); 
     r2 = (v)/ sum(Fx); 
     
     x = pout(:,3); 
    Fx = abs(fft(x)).^2/(length(x)*length(x));
     mpf = max(Fx(31:61));
     bf = 10*(250/mean(diff(rpos)));
     bf = floor([1 2 3 4  5 6 7 8 9 10] *bf+1+0.5);
     for kk = 1:length(bf)
         pf(kk) = max(Fx(bf(kk)-2 : bf(kk)+2));
     end
     [v ,frq] = max(Fx(31:71));
     frq = frq+30;     
    [v1 ] = max(Fx(frq-2:frq+2));     
     rr1 = (v)/ sum(pf); 
     rr2 = (v)/ sum(Fx); 
     
     ratio1 = max(rr1,r1);
     ratio2 = max(rr2,r2);