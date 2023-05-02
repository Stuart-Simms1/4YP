%% Uncoupled Beta BSC
function expectedValue = uncoupledBeta(p0)

p1 = 1-p0;

numIterations = 10000000;

order = floor(log10(numIterations)/2);
numits = 10^order;
iterations = 10^order;
HX = -xlogx(p0) - xlogx(p1);

AVE = zeros(iterations,1);
for its = 1:iterations
    iXYa = zeros(numits,1);
    ave = zeros(numits,1);
    for i = 1:numits
        a = rand;
        iXYa(i) = HX - (-xlogx(a) - xlogx(1-a));
        ave(i) = sum(iXYa)/i;
    end
    AVE(its) = ave(end);
end
expectedValue = sum(AVE)/iterations;

end




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