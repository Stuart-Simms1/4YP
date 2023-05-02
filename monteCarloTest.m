%% Simulate the channel
clear all
close all
dist.num = 1;
dist.d = 0.1;
dist.pXis0 = 0.5;
dist.pXis1 = 1-dist.pXis0;

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
        XAY(i,:) = simulateChannel(dist,e0(point),e1(point));
    end
    xOnes = find(XAY(:,1)==1);
    xZeros = find(XAY(:,1)==0);
    aDones = find(XAY(:,2)==d1);
    aDtwos = find(XAY(:,2)==d2);
    yOnes = find(XAY(:,3)==1);
    yZeros = find(XAY(:,3)==0);
    
    pXis1 = length(xOnes)/numIts;
    pXis0 = length(xZeros)/numIts;
    pYis1 = length(yOnes)/numIts;
    pYis0 = length(yZeros)/numIts;
    pAisd1 = length(aDones)/numIts;
    pAisd2 = length(aDtwos)/numIts;

    xZeroGaDones = find(XAY(aDones,1) == 0);
    xOneGaDones = find(XAY(aDones,1) == 1);
    xZeroGaDtwos = find(XAY(aDtwos,1) == 0);
    xOneGaDtwos = find(XAY(aDtwos,1) == 1);

    pXis0gAisd1 = length(xZeroGaDones)/length(aDones);
    pXis1gAisd1 = length(xOneGaDones)/length(aDones);
    pXis0gAisd2 = length(xZeroGaDtwos)/length(aDtwos);
    pXis1gAisd2 = length(xOneGaDtwos)/length(aDtwos);

    aDoneGxZero = find(XAY(xZeros,2) == d1);
    aDtwoGxZero = find(XAY(xZeros,2) == d2);
    aDoneGxOne = find(XAY(xOnes,2) == d1);
    aDtwoGxOne = find(XAY(xOnes,2) == d2);

    pAisd1gXis0 = length(aDoneGxZero)/length(xZeros);
    pAisd2gXis0 = length(aDtwoGxZero)/length(xZeros);
    pAisd1gXis1 = length(aDoneGxOne)/length(xOnes);
    pAisd2gXis1 = length(aDtwoGxOne)/length(xOnes);

    yZeroaDones = find(XAY(aDones,3)==0);
    yZeroaDtwos = find(XAY(aDtwos,3)==0);
    yOneaDones = find(XAY(aDones,3)==1);
    yOneaDtwos = find(XAY(aDtwos,3)==1);

    xZeroGaDoneyZero = find(XAY(aDones(yZeroaDones),1)==0);
    xZeroGaDoneyOne = find(XAY(aDones(yOneaDones),1)==0);
    xZeroGaDtwoyZero = find(XAY(aDtwos(yZeroaDtwos),1)==0);
    xZeroGaDtwoyOne = find(XAY(aDtwos(yOneaDtwos),1)==0);
    xOneGaDoneyZero = find(XAY(aDones(yZeroaDones),1)==1);
    xOneGaDoneyOne = find(XAY(aDones(yOneaDones),1)==1);
    xOneGaDtwoyZero = find(XAY(aDtwos(yZeroaDtwos),1)==1);
    xOneGaDtwoyOne = find(XAY(aDtwos(yOneaDtwos),1)==1);

    pXis0gAisd1andYis0 = length(xZeroGaDoneyZero)/length(yZeroaDones);
    pXis0gAisd1andYis1 = length(xZeroGaDoneyOne)/length(yOneaDones);
    pXis0gAisd2andYis0 = length(xZeroGaDtwoyZero)/length(yZeroaDtwos);
    pXis0gAisd2andYis1 = length(xZeroGaDtwoyOne)/length(yOneaDtwos);
    pXis1gAisd1andYis0 = length(xOneGaDoneyZero)/length(yZeroaDones);
    pXis1gAisd1andYis1 = length(xOneGaDoneyOne)/length(yOneaDones);
    pXis1gAisd2andYis0 = length(xOneGaDtwoyZero)/length(yZeroaDtwos);
    pXis1gAisd2andYis1 = length(xOneGaDtwoyOne)/length(yOneaDtwos);

    %  P(A=d1)*(-xlogx(P(X=0|A=d1))-xlogx(P(X=1|A=d1))
    %           +P(Y=0)*(xlogx(P(X=0|Y=0,A=d1))+xlogx(P(X=1|Y=0,A=d1))
    %           +P(Y=1)*(xlogx(P(X=0|Y=1,A=d1))+xlogx(P(X=1|Y=1,A=d1)))
    % +P(A=d2)*(-xlogx(P(X=0|A=d2))-xlogx(P(X=1|A=d2))
    %           +P(Y=0)*(xlogx(P(X=0|Y=0,A=d2))+xlogx(P(X=1|Y=0,A=d2))
    %           +P(Y=1)*(xlogx(P(X=0|Y=1,A=d2))+xlogx(P(X=1|Y=1,A=d2)))
    % -xlogx(P(A=d1))-xlogx(P(A=d2))
    % +P(X=0)*(xlogx(P(A=d1|X=0))+xlogx(P(A=d2|X=0)))
    % +P(X=1)*(xlogx(P(A=d1|X=1))+xlogx(P(A=d2|X=1)))

    mutualInfo(point) = pAisd1*(-xlogx(pXis0gAisd1)-xlogx(pXis1gAisd1)...
                                +pYis0*(xlogx(pXis0gAisd1andYis0)+xlogx(pXis1gAisd1andYis0))...
                                +pYis1*(xlogx(pXis0gAisd1andYis1)+xlogx(pXis1gAisd1andYis1)))...
                       +pAisd2*(-xlogx(pXis0gAisd2)-xlogx(pXis1gAisd2)...
                                +pYis0*(xlogx(pXis0gAisd2andYis0)+xlogx(pXis1gAisd2andYis0))...
                                +pYis1*(xlogx(pXis0gAisd2andYis1)+xlogx(pXis1gAisd2andYis1)))...
                       -xlogx(pAisd1)-xlogx(pAisd2)...
                       +pXis0*(xlogx(pAisd1gXis0)+xlogx(pAisd2gXis0))...
                       +pXis1*(xlogx(pAisd1gXis1)+xlogx(pAisd2gXis1));
    toc
end
plot(e0,mutualInfo)