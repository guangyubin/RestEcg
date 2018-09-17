function bvf = vfdetect_type(type)

m = 0;
maxm = 0 ;
for ii = 1:length(type)
    if type(ii)~=0
        m = m +1;
    else
        if m > maxm
            maxm = m ;
        end
        m = 0 ;
    end
end
if maxm >=3
    bvf = 1;
else
    bvf = 0 ;
end