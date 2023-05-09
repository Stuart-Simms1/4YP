%% Surface of simulation uncoupled info
clear all
close all
clc

numIterations = 100000;
option = 1;

dist.pXis0 = 0.5;
dist.pXis1 = 1-dist.pXis0;
dist.num = 2;
d1 = linspace(0,1,100);
d2 = d1;

MI = zeros(length(d1));
for i = 1:length(d1)
    for j = 1:length(d2)
        dist.d1 = d1(i);
        dist.d2 = d2(j);
        MI(i,j) = uncoupledInfo(numIterations,dist,option);
    end
    i
end

surf(d1,d2,MI,'EdgeColor','none')
title(sprintf('Uncoupled Case I(X;Y,A) with uniform input distribution'))
xlabel('Delta 1')
ylabel('Delta 2')
zlabel('I(X;Y,A)')
