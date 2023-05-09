%% Trying to plot pictures for distribution 2
clear all
close all
clc

dist.num = 2;
dist.pXis0 = 0.5;
dist.pXis1 = 1-dist.pXis0;
numDeltas = 11;
numPoints = 100;
numIterations = 1000000;
option = 1;
d1 = 0.1;
d2 = 0.9;

for i = 1:length(d1)
    dist.d1 = d1(i);
    for j = 1:length(d2)
        dist.d2 = d2(j);
        % Find the theoretical coupled line
        epsilon0 = linspace(0,1,numPoints);
        epsilon1 = linspace(0,1,numPoints);
        MI = zeros(numPoints);
        for e0 = 1:numPoints
            for e1 = 1:numPoints
                dist = assign_probabilities(dist,epsilon0(e0),epsilon1(e1));
                MI(e0,e1) = mutual_information(dist);
            end
        end
        coupledTheoryLine = diag(fliplr(MI));

        % Find the Uncoupled case line
        uncoupledLine = ones(numPoints,1)*uncoupledInfo(numIterations,dist,option);

        %plot results
        figure(j)
        plot(epsilon0,coupledTheoryLine,epsilon0,uncoupledLine)%
        txt = sprintf('I(X;Y,A) vs \x03F5\x2080 Showing Uncoupled Line');
        title(txt)
        xlabel(sprintf('\x03F5\x2080 = 1 - \x03F5\x2081'))
        ylabel('I(X;Y,A)')
        label1 = sprintf('Dist 2, d1 = %g, d2 = %g',dist.d1,dist.d2);
        legend(label1,'Uncoupled Case',Location='best')
        axis([0;1;0;1])
    end
end