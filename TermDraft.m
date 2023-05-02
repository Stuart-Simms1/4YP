% Define things
clear all
close all
clc

numPoints = 100;
A = logspace(0,log10(50),numPoints);
B = A;

p0 = 0.5;
p1 = 1-p0;

% I1 = zeros(numPoints);
IXYA = zeros(numPoints);

for i = 1:numPoints
    tic
    for j = 1:numPoints
        a = A(i);
        b = B(j);
        Bab(i,j) = 1./beta(a,b);
% 
%         timesp0andBab = @(x) x.^(a-1).*(1-x).^(b-1).*(log2mine(Bab.*x.^(a-1).*(1-x).^(b-1)) +...
%                                 (1-x).*log2mine(1-x) + x.*log2mine(x));
%         
%         timesp1andBab = @(x) x.^(b-1).*(1-x).^(a-1).*(log2mine(Bab.*x.^(b-1).*(1-x).^(a-1)) +...
%                                 x.*log2mine(x) + (1-x).*log2mine(1-x));
%         
%         minustimesBab = @(x) (p0.*x.^(a-1).*(1-x).^(b-1) + p1.*x.^(b-1).*(1-x).^(a-1)).*...
%                         (log2mine(Bab.*(p0.*x.^(a-1).*(1-x).^(b-1) + p1.*x.^(b-1).*(1-x).^(a-1))) + ...
%                         ((p0.*x.^(a-1).*(1-x).^(b) + p1.*x.^(b).*(1-x).^(a-1)).*...
%                         log2mine((p0.*x.^(a-1).*(1-x).^(b) + p1.*x.^(b).*(1-x).^(a-1))./...
%                         (p0.*x.^(a-1).*(1-x).^(b-1) + p1.*x.^(b-1).*(1-x).^(a-1))) +...
%                         (p0.*x.^(a).*(1-x).^(b-1) + p1.*x.^(b-1).*(1-x).^(a)).*...
%                         log2mine((p0.*x.^(a).*(1-x).^(b-1) + p1.*x.^(b-1).*(1-x).^(a))./...
%                         (p0.*x.^(a-1).*(1-x).^(b-1) + p1.*x.^(b-1).*(1-x).^(a-1))))./...
%                         (p0.*x.^(a-1).*(1-x).^(b-1) + p1.*x.^(b-1).*(1-x).^(a-1)));

        iXYA = @(x) Bab(i,j).*(p0.*(x.^(a-1).*(1-x).^(b-1).*(log2mine(Bab(i,j).*x.^(a-1).*(1-x).^(b-1)) +...
                                (1-x).*log2mine(1-x) + x.*log2mine(x))) +...
                             p1.*(x.^(b-1).*(1-x).^(a-1).*(log2mine(Bab(i,j).*x.^(b-1).*(1-x).^(a-1)) +...
                                x.*log2mine(x) + (1-x).*log2mine(1-x))) -...
                            ((p0.*x.^(a-1).*(1-x).^(b-1) + p1.*x.^(b-1).*(1-x).^(a-1)).*...
                            (log2mine(Bab(i,j).*(p0.*x.^(a-1).*(1-x).^(b-1) + p1.*x.^(b-1).*(1-x).^(a-1))) + ...
                            ((p0.*x.^(a-1).*(1-x).^(b) + p1.*x.^(b).*(1-x).^(a-1)).*...
                            log2mine((p0.*x.^(a-1).*(1-x).^(b) + p1.*x.^(b).*(1-x).^(a-1))./...
                            (p0.*x.^(a-1).*(1-x).^(b-1) + p1.*x.^(b-1).*(1-x).^(a-1))) +...
                            (p0.*x.^(a).*(1-x).^(b-1) + p1.*x.^(b-1).*(1-x).^(a)).*...
                            log2mine((p0.*x.^(a).*(1-x).^(b-1) + p1.*x.^(b-1).*(1-x).^(a))./...
                            (p0.*x.^(a-1).*(1-x).^(b-1) + p1.*x.^(b-1).*(1-x).^(a-1))))./...
                            (p0.*x.^(a-1).*(1-x).^(b-1) + p1.*x.^(b-1).*(1-x).^(a-1)))));

%         I1(i,j) = Bab.*(p0.*integral(timesp0andBab,0,1) + p1.*integral(timesp1andBab,0,1) - integral(minustimesBab,0,1));
        IXYA(i,j) = integral(iXYA,0,1);

    end
    toc
end
figure(1)
surf(A,B,IXYA)
title('I(X;Y,A) for different shape parameters')
xlabel('shape parameter a')
ylabel('shape parameter b')
zlabel('I(X;Y,A)')
figure(2)
surf(A,B,Bab)
xlabel('shape parameter a')
ylabel('shape parameter b')
zlabel('1/B(a,b)')

function output = log2mine(x)
    if x == 0
        output = 0;
    else
        output = log2(x);
    end
end




%% I think this shit is finally right!