%% I am now simulating the uncoupled case random alpha from the p(A) calculated from the original distribution
close all
clear all
clc

p0 = 0.5;
p1 = 1-p0;
A = linspace(0.1,10,100);
B = A;

expectedValue = zeros(length(A),length(B));

for a = 1:length(A)
    for b = 1:length(B)
        numIterations = 100000;

        order = floor(log10(numIterations)/2);
        numits = 10^order;
        iterations = 10^order;

        % Form the sampling distribution for the given shape parameters and input
        % probability
        X = linspace(0,1,100);
        func = @(X) (p0.*X.^(a-1).*(1-X).^(b-1) + p1.*X.^(b-1).*(1-X).^(a-1))./beta(a,b);
        % find the cdf
        cdf = zeros(length(X),1);
        for i = 1:length(X)
            cdf(i) = integral(func,0,X(i));
            if 1-cdf(i) < 0.000000000001
                cdf(i) = 1 - 0.00000000000001.*(length(X)-i+1);
            end
        end
        cdf = sort(cdf);
        cdf(end) = 1;
        mydist = makedist("PiecewiseLinear",X,cdf');


        HX = -xlogx(p0) - xlogx(p1);
        AVE = zeros(iterations,1);
        for its = 1:iterations
            iXYa = zeros(numits,1);
            ave = zeros(numits,1);
            for i = 1:numits
                samplea = random(mydist);
                iXYa(i) = HX - (-xlogx(samplea) - xlogx(1-samplea));
                ave(i) = sum(iXYa)/i;
            end
            AVE(its) = ave(end);
        end

        expectedValue(a,b) = sum(AVE)/iterations;
    end
    fprintf('%d out of %d points finished\n',a*length(B)+b,length(A)*length(B))
end
txt = sprintf('UncoupledCaseSim100x100,0to10.txt');
writematrix(expectedValue,txt);
figure()
surf(A,B,expectedValue)
title(sprintf('Uncoupled Case I(X;Y,A) vs a and b'))
xlabel('shape parameter a')
ylabel('shape parameter b')
zlabel('Uncoupled I(X;Y,A)')



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