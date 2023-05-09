clear all
close all
clc

dist.pXis0 = 0.5;
dist.pXis1 = 1-dist.pXis0;
% dist.num = 1;
% dist.d = 0.22;
dist.num = 2;
dist.d1 = 0.1;
dist.d2 = 0.4;
numPoints = 100;

%% Find the theoretical coupled line
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

%% Find the Uncoupled case line
numIterations = 1000000;
option = 1;
uncoupledLine = ones(numPoints,1)*uncoupledInfo(numIterations,dist,option);

%% Find the simulation points
simulatedLine = monteCarlo(dist,numPoints);

% %% Find the Z channel Line
% ZInfo = zeros(numPoints,1);
% for e1 = 1:numPoints
%     dist = assign_Z(dist,1-epsilon0(e1));
%     ZInfo(e1) = z_information(dist);
% end
if dist.num == 1
    label1 = sprintf('Dist 1, d = %g',dist.d);
else
    label1 = sprintf('Dist 2, d1 = %g, d2 = %g',dist.d1,dist.d2);
end
%% Plot results
plot(epsilon0,coupledTheoryLine,epsilon0,uncoupledLine,epsilon0,simulatedLine,'r--o')%)%,epsilon0,ZInfo)%,epsilon0,simulatedLine,'r--o')
txt = sprintf('I(X;Y,A) vs \x03F5\x2080 Showing Uncoupled Line and Monte Carlo Simulation');
title(txt)
xlabel(sprintf('\x03F5\x2080 = 1 - \x03F5\x2081'))
ylabel('I(X;Y,A)')
legend(label1,'Uncoupled Case','Simulation',Location='best')%,'Z Case')%,'Simulation')
axis([0;1;0;1])


