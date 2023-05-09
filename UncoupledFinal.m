%% Uncoupled beta re revisited
clear all
close all
clc

p0 = 0.5;
p1 = 1-p0;
A = linspace(0.1,50,100);
B = A;

% HX = -(xlogx(p0)+xlogx(p1));
% expectedValue = zeros(length(A),length(B));
% Simulation  = readmatrix("UncoupledCase100x100,0to10.txt");
% for a = 1:length(A)
%     for b = 1:length(B)
%         expectedValue(a,b) = HX + xlogx((p0.*(a+1)+p1.*(b+1))./(a+b+1)) + xlogx(1-((p0.*(a+1)+p1.*(b+1))./(a+b+1)));
%     end
% end
% 
% figure(1)
% surf(A,B,expectedValue)
% title(sprintf('Uncoupled Case theoretical I(X;Y,A) vs a and b'))
% xlabel('shape parameter a')
% ylabel('shape parameter b')
% zlabel('Uncoupled I(X;Y,A)')
% 
% figure(2)
% surf(A,B,Simulation)
% title(sprintf('Uncoupled Case simulatedI(X;Y,A) vs a and b'))
% xlabel('shape parameter a')
% ylabel('shape parameter b')
% zlabel('Uncoupled I(X;Y,A)')


UncoupledInfo = zeros(length(A),length(B));
for a = 1:length(A)
    for b = 1:length(B)

        func = @(x) -(p0.*x.^(A(a)-1).*(1-x).^(B(b)-1) + p1.*x.^(B(b)-1).*(1-x).^(A(a)-1)).*...
            (xlogx(p0.*(1-x) + p1.*x) + xlogx(p0.*x + p1.*(1-x)) - (p0+p1).*(xlogx(x) + xlogx(1-x)));
        UncoupledInfo(a,b) = integral(func,0,1)./beta(A(a),B(b));
    end
end
txt = sprintf('UncoupledCaseTheory100x100,0to50.txt');
writematrix(UncoupledInfo,txt);

figure(1)
surf(A,B,UncoupledInfo,'EdgeColor','none')
title(sprintf('Uncoupled Case I(X;Y,A) vs a and b'))
xlabel('shape parameter a')
ylabel('shape parameter b')
zlabel('Uncoupled I(X;Y,A)')
axis([0;50;0;50;0;1])

function output =  xlogx(x)
    raw = x.*log2(x);
    %If 0*log2(0) is the raw result assign it 0
    if isnan(raw)
        output = 0;
    else
        output = raw;
    end
end