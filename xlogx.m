function output = xlogx(x)
%This function returns x*log2(x) which is used a lot in the mutual
%information calculation
    raw = x*log2(x);
    
    %If 0*log2(0) is the raw result assign it 0
    if isnan(raw)
        output = 0;
    else
        output = raw;
    end
end