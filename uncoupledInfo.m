function expectedValue = uncoupledInfo(numIterations,dist,option)

% numIterations: number of iterations for the simulation
% dist: the distribution parameters
% option: 1 if using a binary choice of alphas
%         2 if using a continuous distribution of alpha between 0 and delta
order = floor(log10(numIterations)/2);
numits = 10^order;
iterations = 10^order;
if option == 1
    for its = 1:iterations
        iXYa = zeros(numits,1);
        ave = zeros(numits,1);
        for i = 1:numits
            sample = rand;
            if sample <= 0.5
                if dist.num == 1
                    a = 0;
                end
                if dist.num == 2
                    a = dist.d1;
                end
            else
                if dist.num == 1
                    a = dist.d;
                end
                if dist.num == 2
                    a = dist.d2;
                end
            end
            iXYa(i) = 1 - (-xlogx(a)-xlogx(1-a));
            ave(i) = sum(iXYa)/i;
        end
        AVE(its) = ave(end);
    end
    expectedValue = sum(AVE)/iterations;
end

if option == 2
    for its = 1:iterations
        iXYa = zeros(numits,1);
        ave = zeros(numits,1);
        for i = 1:numits
            if dist.num ==1
                a = dist.d*rand;
            else
                a = dist.d1 + (dist.d2-dist.d1)*rand;
            end
            iXYa(i) = 1 - (-xlogx(a)-xlogx(1-a));
            ave(i) = sum(iXYa)/i;
        end
        AVE(its) = ave(end);
    end
    expectedValue = sum(AVE)/iterations;
end

end