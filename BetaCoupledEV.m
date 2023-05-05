%% Beta Distributed Coupling vs expected value of distribution
close all;
clc;
clear all;
% define variables
numPoints = 100;
mx = 10;
A = linspace(1,mx,numPoints);
B = A;
% A = logspace(0,log10(50),numPoints);
% B = logspace(0,log10(50),numPoints);
% A = linspace(0.1,10,numPoints);
% B = linspace(0.1,10,numPoints);
pXis0 = 0.5;

IXYA = zeros(numPoints);
EVx0 = zeros(numPoints);
EVx1 = zeros(numPoints);
logsum = zeros(numPoints);
% for each set of a and b
for a = 1:numPoints
    for b = 1:numPoints

    % calculate mutual information
    [IXYA(a,b),EVx0(a,b),EVx1(a,b)] = calculateMutualInformation(A(a),B(b),pXis0);
    logsum(a,b) = max(EVx1(a,b),EVx0(a,b));
    end
end

% plot results
figure(1)
surf(A,B,IXYA,'EdgeColor','none')
title('I(X;Y,A) for different shape parameters')
xlabel('shape parameter a')
ylabel('shape parameter b')
zlabel('I(X;Y,A)')
axis([0;mx;0;mx;0;1])

figure(2)
surf(A,B,EVx0,'EdgeColor','none')
title('Expected Value of A when X = 0')
xlabel('shape parameter a')
ylabel('shape parameter b')
zlabel('E[p(A|X=0)]')
axis([0;mx;0;mx;0;1])

figure(3)
surf(A,B,EVx1,'EdgeColor','none')
title('Expected Value of A when X = 1')
xlabel('shape parameter a')
ylabel('shape parameter b')
zlabel('E[p(A|X=1)]')
axis([0;mx;0;mx;0;1])

% logsum = -EVx0.*log2(EVx0)- EVx1.*log2(EVx1);
figure(4)
surf(A,B,logsum,'EdgeColor','none')
title('Maximum Expected Value of A Over the Two Distributions')
xlabel('shape parameter a')
ylabel('shape parameter b')
zlabel('max( E[p(A|X=0)] , E[p(A|X=1)] )')
axis([0;mx;0;mx;0;1])




function [mutualInfo,EVx0, EVx1] = calculateMutualInformation(a,b,p0)

p1 = 1-p0;
Bab = 1./beta(a,b);

iXYA = @(x) Bab.*(p0.*(x.^(a-1).*(1-x).^(b-1).*(log2mine(Bab.*x.^(a-1).*(1-x).^(b-1)) +...
                        (1-x).*log2mine(1-x) + x.*log2mine(x))) +...
                     p1.*(x.^(b-1).*(1-x).^(a-1).*(log2mine(Bab.*x.^(b-1).*(1-x).^(a-1)) +...
                        x.*log2mine(x) + (1-x).*log2mine(1-x))) -...
                    ((p0.*x.^(a-1).*(1-x).^(b-1) + p1.*x.^(b-1).*(1-x).^(a-1)).*...
                    (log2mine(Bab.*(p0.*x.^(a-1).*(1-x).^(b-1) + p1.*x.^(b-1).*(1-x).^(a-1))) + ...
                    ((p0.*x.^(a-1).*(1-x).^(b) + p1.*x.^(b).*(1-x).^(a-1)).*...
                    log2mine((p0.*x.^(a-1).*(1-x).^(b) + p1.*x.^(b).*(1-x).^(a-1))./...
                    (p0.*x.^(a-1).*(1-x).^(b-1) + p1.*x.^(b-1).*(1-x).^(a-1))) +...
                    (p0.*x.^(a).*(1-x).^(b-1) + p1.*x.^(b-1).*(1-x).^(a)).*...
                    log2mine((p0.*x.^(a).*(1-x).^(b-1) + p1.*x.^(b-1).*(1-x).^(a))./...
                    (p0.*x.^(a-1).*(1-x).^(b-1) + p1.*x.^(b-1).*(1-x).^(a-1))))./...
                    (p0.*x.^(a-1).*(1-x).^(b-1) + p1.*x.^(b-1).*(1-x).^(a-1)))));

EVx0 = 1./(1+(b./a));
EVx1 = 1./(1+(a./b));

mutualInfo = integral(iXYA,0,1);
end

function output = log2mine(x)
    if x == 0
        output = 0;
    else
        output = log2(x);
    end
end