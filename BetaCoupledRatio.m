%% Beta Distributed Coupling vs ratio a/b of distribution
close all;
clc;
clear all;
% define variables
numPoints = 100;
mx = 10;
pXis0 = 0.5;


A = linspace(1,mx,numPoints);
B = A;
% A = linspace(1,mx/2,numPoints);
% B = linspace(mx,mx/2,numPoints);

IXYA = zeros(numPoints);
ratioAB = zeros(numPoints);
ratioBA = zeros(numPoints);
rmax = zeros(numPoints);
for a = 1:numPoints
    for b = 1:numPoints
        IXYA(a,b) = calculateMutualInformation(A(a),B(b),pXis0);
        ratioAB(a,b) = A(a)./B(b);
        ratioBA(a,b) = B(b)./A(a);
        rmax(a,b) = max([ratioAB(a,b);ratioBA(a,b)]);
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
surf(A,B,ratioAB,'EdgeColor','none')
title('a/b ratio for different shape parameters')
xlabel('shape parameter a')
ylabel('shape parameter b')
zlabel('a/b')
% axis([0;mx;0;mx;0;1])

figure(3)
surf(A,B,ratioBA,'EdgeColor','none')
title('b/a for different shape parameters')
xlabel('shape parameter a')
ylabel('shape parameter b')
zlabel('b/a')
% axis([0;mx;0;mx;0;1])

figure(4)
surf(A,B,rmax,'EdgeColor','none')
title('max(a/b,b/a) for different shape parameters')
xlabel('shape parameter a')
ylabel('shape parameter b')
zlabel('max(a/b,b/a)')

function mutualInfo = calculateMutualInformation(a,b,p0)

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

mutualInfo = integral(iXYA,0,1);
end

function output = log2mine(x)
    if x == 0
        output = 0;
    else
        output = log2(x);
    end
end