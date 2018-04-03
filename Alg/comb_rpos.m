%%
function rpos = comb_rpos(rpos1,chan)
rpos1 = sort(rpos1);

thr = 2;
if chan==2
    thr = 0 ;
end;
if chan ==3
    thr = 1;
end;


m = 1;
nc = 0;
for ii = 1:length(rpos1)-1
    if rpos1(ii+1) - rpos1(ii) > 30
        if nc > thr
            rpos(m) = rpos1(ii);
            count(m) = nc;
            nc = 0 ;
            m = m +1;
        end
    else
        nc = nc+1;
    end
end
if nc > thr
    rpos(m) = rpos1(end);
    count(m) = nc;
end
rpos = rpos - 2;
