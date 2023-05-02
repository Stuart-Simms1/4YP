%% Simulate the channel
clear all
dist.num = 1;
dist.d = 0.1;
if dist.num == 1
    d1 = 0;
    d2 = dist.d;
else
    d1 = dist.d1;
    d2 = dist.d2;
end
numIts = 100000;
numPoints = 100;
e0 = linspace(0,1,numPoints);
e1 = 1-e0;
mutualInfo = zeros(numPoints,1);

for point = 1:numPoints
    tic
    XAY = zeros(numIts,3);
    for i = 1:numIts
        XAY(i,:) = simulateChannel(d1,d2,e0(point),e1(point));
    end

    pXis1 = sum(XAY(:,1))/numIts;
    pYis1 = sum(XAY(:,3))/numIts;
    pAisd2 = sum(XAY(:,2))/(numIts*d2);

    xOnes = find(XAY(:,1));
    xZeros = find(XAY(:,1)==0);
    aDones = find(XAY(:,2)==d1);
    aDtwos = find(XAY(:,2)==d2);
    yOnes = find(XAY(:,3));
    yZeros = find(XAY(:,3)==0);

    pXis1gAisd1 = sum(XAY(aDones,1))/length(aDones);   
    pXis0gAisd1 = 1- pXis1gAisd1;                   

    pXis1gAisd2 = sum(XAY(aDtwos,1))/length(aDtwos);
    pXis0gAisd2 = 1-pXis1gAisd2;

    pAisd2gXis1 = sum(XAY(xOnes,2) - d1)/(length(xOnes)*d2);
    pAisd1gXis1 = 1 - pAisd2gXis1;                      %should be e1
    pAisd2gXis0 = sum(XAY(xZeros,2) - d1)/(length(xZeros)*d2);
    pAisd1gXis0 = 1- pAisd2gXis0;                       %should be e0

    IofXandA = -xlogx(pAisd2)-xlogx(1-pAisd2) + (1-pXis1)*(xlogx(pAisd1gXis0)+xlogx(pAisd2gXis0)) ...
        + pXis1*(xlogx(pAisd1gXis1) + xlogx(pAisd2gXis1));
    
    yZeroandAdones = [];
    yZeroandAdtwos = [];
    yOneandAdones = [];
    yOneandAdtwos = [];
    for index0 = 1:length(yZeros)
        if XAY(yZeros(index0),2) == d1
            yZeroandAdones = [yZeroandAdones;yZeros(index0)];
        else
            yZeroandAdtwos = [yZeroandAdtwos;yZeros(index0)];
        end
    end
    for index1 = 1:length(yOnes)
        if XAY(yOnes(index1),2) == d1
            yOneandAdones = [yOneandAdones;yOnes(index1)];
        else
            yOneandAdtwos = [yOneandAdtwos;yOnes(index1)];
        end
    end


    pXis1gYis0andAisd1 = sum(XAY(yZeroandAdones,1))/length(yZeroandAdones);
    pXis0gYis0andAisd1 = 1-pXis1gYis0andAisd1;
    pXis1gYis0andAisd2 = sum(XAY(yZeroandAdtwos,1))/length(yZeroandAdtwos);
    pXis0gYis0andAisd2 = 1-pXis1gYis0andAisd2;
    pXis1gYis1andAisd1 = sum(XAY(yOneandAdones,1))/length(yOneandAdones);
    pXis0gYis1andAisd1 = 1-pXis1gYis1andAisd1;
    pXis1gYis1andAisd2 = sum(XAY(yOneandAdtwos,1))/length(yOneandAdtwos);
    pXis0gYis1andAisd2 = 1-pXis1gYis1andAisd2;

    IofXandYgA = pAisd2*(-xlogx(pXis0gAisd2)-xlogx(pXis1gAisd2) ...
        + pYis1*(xlogx(pXis1gYis1andAisd2))+xlogx(pXis0gYis1andAisd2)...
        + (1-pYis1)*(xlogx(pXis1gYis0andAisd2))+xlogx(pXis0gYis0andAisd2))...
        + (1-pAisd2)*(-xlogx(pXis0gAisd1)-xlogx(pXis1gAisd1) ...
        + pYis1*(xlogx(pXis1gYis1andAisd1))+xlogx(pXis0gYis1andAisd1)...
        + (1-pYis1)*(xlogx(pXis1gYis0andAisd1))+xlogx(pXis0gYis0andAisd1));

    mutualInfo(point) = IofXandA + IofXandYgA;
    toc
end
plot(e0,mutualInfo)