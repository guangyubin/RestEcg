function  r = index_vta(data,rpos)

   for ii = 1:size(data,2)
     x = data(:,ii); 
     x = x - mean(x);
     Fx = abs(fft(x)).^2/(length(x)*length(x));
     bf = 10*(250/mean(diff(rpos)));     
     bf = floor([1 2 3 4  5 6 7 8 9 10] *bf+1+0.5);
     for kk = 1:length(bf)
         pf(kk) = max(Fx(bf(kk)-8 : bf(kk)+8));
     end   
 
     r(ii) = pf(1)/ sum(Fx(10:70)); 
   end

     