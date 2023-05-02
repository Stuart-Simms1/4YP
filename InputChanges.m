%% Visualising the reduction in I(X;Y|A) when changing the input distribution
clear all
close all
clc

numPoints = 100;
p0 = linspace(0,1,numPoints);
p1 = 1-p0;
A = [0.1;1;10;100];
B = 100;
EntropyCoefficient = @(a,b) 1/beta(a,b);

for a = 1:length(A)
        HYgA = zeros(numPoints,1);
        HYgXandA = zeros(numPoints,1);
        for i = 1:numPoints
                funcHYgA = @(x) x.^(A(a)-1).*(1-x).^(B).*...
                    (((1-x).*p0(i) + x.*p1(i)).*log2((1-x).*p0(i) + x.*p1(i))...
                    + (x.*p0(i) + (1-x).*p1(i)).*log2(x.*p0(i) + (1-x).*p1(i)));
        
                funcHYgXandA = @(x) x.^(A(a)-1).*(1-x).^(B).*...
                    (x.*log2(x)+(1-x).*log2(1-x));
        
                HYgA(i) = -EntropyCoefficient(A(a),B).*integral(funcHYgA,0,1);
        
                HYgXandA(i) = -EntropyCoefficient(A(a),B).*integral(funcHYgXandA,0,1);
        end
        mutualInformation(a,:) = HYgA - HYgXandA;
        a
end

figure(1)
for i = 1:length(A)
    plot(p0,mutualInformation(i,:))
    labels(i) = string(sprintf('a = %3.2f , b = 100',A(i)));
    hold on
end
plot(0.5.*ones(10,1),linspace(0,1,10),'r-.')
title('I(X;Y|A) for changing p(X=0) at fixed a and b')
xlabel('p(X=0)')
ylabel('I(X;Y|A)')
legend(labels)
axis([0;1;0;1])
