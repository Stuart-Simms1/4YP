%% Beta Distributed Coupling
close all;
clc;
clear all;
% define variables
numPoints = 100;
mx = 10;
A = linspace(0.1,50,numPoints);
B = A;
% A = logspace(0,log10(50),numPoints);
% B = logspace(0,log10(50),numPoints);
% A = linspace(0.1,10,numPoints);
% B = linspace(0.1,10,numPoints);
pXis0 = 0.5;

% IXYA = zeros(numPoints);

% for each input distribution
for i = 1:length(pXis0)
    IXYA = zeros(numPoints);
    % for each set of a and b
    for a = 1:numPoints
        for b = 1:numPoints
    
        % calculate mutual information
        IXYA(a,b) = calculateMutualInformation(A(a),B(b),pXis0(i));
    
        end
    end
    
    % plot results
    figure(i)
    surf(A,B,IXYA,'EdgeColor','none')
    title(sprintf('I(X;Y,A) coupled vs uncoupled for different shape parameters'));
    xlabel('shape parameter a')
    ylabel('shape parameter b')
    zlabel('I(X;Y,A)')
    axis([0;50;0;50;0;1])

    % Compare to Uncoupled Case
    uncoupled = readmatrix('UncoupledCaseTheory100x100,0to50.txt');
    hold on
    surf(A,B,uncoupled,'EdgeColor','none','FaceColor',[1 0 0], 'FaceAlpha',1,'EdgeAlpha', 0)

    figure(i+1)
    surf(A,B,uncoupled,'EdgeColor','none')
    title(sprintf('Uncoupled I(X;Y,A) for different shape parameters'))
    xlabel('shape parameter a')
    ylabel('shape parameter b')
    zlabel('Uncoupled I(X;Y,A)')
    axis([0;50;0;50;0;1])

    figure(i+2)
    surf(A,B,IXYA-uncoupled,'EdgeColor','none')
    title(sprintf('Difference between Coupled and Uncoupled I(X;Y,A)'))
    xlabel('shape parameter a')
    ylabel('shape parameter b')
    zlabel('Difference in I(X;Y,A)')
    axis([0;50;0;50;0;1])

end

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