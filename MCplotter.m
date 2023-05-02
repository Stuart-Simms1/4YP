clear all
close all

dist.num = 1;
dist.d = 0.1;
PC = 1;
[Info,dist] = readSurface(dist,PC);
coupledline = diag(fliplr(Info));

numIterations = 1000000;
option = 2;
uncoupInfo = uncoupledInfo(numIterations,dist,option);

numpoints = 100;
InfoPoints = monteCarlo(dist,numpoints);

figure(1)
plot(0.01:0.01:1,coupledline,'b',0.01:0.01:1,uncoupInfo*ones(100,1),'y',InfoPoints(:,2),InfoPoints(:,1),'r--o')
title('Comparison of Coupled Expression, Coupled Simulation and Uncoupled case')
xlabel("epsilon0 = 1-epsilon1")
ylabel("Mutual Information")
legend('Coupled Exression','Uncoupled Case','Coupled Simulation')