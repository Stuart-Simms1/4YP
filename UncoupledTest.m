%% Comparing the coupled simulation to the theory

clear all
close all
clc

numPoints = 100;

dist.pXis0 = 0.5;
dist.pXis1 = 1-dist.pXis0;
dist.num = 1;
dist.d = 0.22;
% dist.num = 2;
% dist.d1 = 0.2;
% dist.d2 = 0.4;
p_0 = linspace(0,1,numPoints);

% p0 = dist.pXis0;
% p1 = dist.pXis1;
d1 = 0;
d2 = dist.d;
% d1 = dist.d1;
% d2 = dist.d2;
e0 = 0.25;
e1 = 1-e0;
uncoupledTheory = zeros(numPoints,1);
numIterations = 1000000;
option = 1;
uncoupledLine = zeros(numPoints,1);
for i = 1:length(p_0)
    dist.pXis0 = p_0(i);
    dist.pXis1 = 1-dist.pXis0;
    p0 = dist.pXis0;
    p1 = dist.pXis1;
    uncoupledTheory(i) = -(xlogx(p0)+xlogx(p1))...
                        + xlogx((p0.*e0+p1.*e1).*d1 + (1-(p0.*e0 +p1.*e1)).*d2)...
                        + xlogx(1-((p0.*e0+p1.*e1).*d1 + (1-(p0.*e0 +p1.*e1)).*d2));
    uncoupledLine(i) =uncoupledInfo(numIterations,dist,option);
end
plot(p_0,uncoupledTheory,'b',p_0,uncoupledLine,'r')

