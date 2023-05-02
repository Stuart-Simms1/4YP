% % Varying X distribution graphs
clear all
close all

dist.num = 1;
dist.d = 0.1;
numX = 50;
numPoints = 100;
numIterations = 100000;
option = 1;
epsilon0 = linspace(0,1,numPoints);
epsilon1 = linspace(0,1,numPoints);
MI = zeros(numPoints);
Xrange = linspace(0,1,numX);
coupledTheoryLines = zeros(numPoints,10);
uncoupledLines = zeros(numPoints,10);

for xindex = 1:numX
    dist.pXis0 = Xrange(xindex);
    dist.pXis1 = 1-dist.pXis0;


    %% Find the theoretical coupled line
    for e0 = 1:numPoints
        for e1 = 1:numPoints
            dist = assign_probabilities(dist,epsilon0(e0),epsilon1(e1));
            MI(e0,e1) = mutual_information(dist);
        end
    end
    coupledTheoryLines(:,xindex) = diag(fliplr(MI));
    
    %% Find the Uncoupled case line
    uncoupledLines(:,xindex) = ones(numPoints,1)*uncoupledInfo(numIterations,dist,option);
end

%% Plot results
figure(1)
for xindex = 1:numX
    plot(epsilon0,coupledTheoryLines(:,xindex),epsilon0,uncoupledLines(:,xindex),epsilon0,uncoupledLines(:,numX/2))
    axis([0 1 0 1])
    txt = sprintf('Mutual information with P(X=0)= %f',Xrange(xindex));
    title(txt)
    xlabel('Epsilon0 = 1-Epsilon1')
    ylabel('Mutual Information')
    legend('Theory I(X;Y,A)','Uncoupled Case I(X;Y,A)','Uncoupled Capacity')%
    drawnow
    pause(0.5)
end