%% Possibility of having everything wrong

%% H(Y|A)
clear all
close all
clc

numPoints = 100;
A = logspace(-2,0,numPoints);
B = A;
% % Check the value at a,b = 1
% numPoints = 1;
% A = 1;
% B = 100;
% % check the really extreme cases
% numPoints = 10;
% A = logspace(-2,0,numPoints);
% B = logspace(0,2,numPoints);

RawInfo = zeros(numPoints);

p0 = 0.2;
p1 = 1-p0;

EntropyCoefficient = @(a,b) 1/beta(a,b);
figure(1)
for a = 1:numPoints
    tic
    for b = 1:numPoints
        funcIYgXandA = @(x) x.^(A(a)-1).*(1-x).^(B(b)-1).*...
            (((1-x).*p0 + x.*p1).*log2((1-x).*p0 + x.*p1) +...
            (x.*p0 + (1-x).*p1).*log2(x.*p0 + (1-x).*p1)-...
            (x.*log2(x) + (1-x).*log2(1-x)));

        RawInfo(a,b) = -EntropyCoefficient(A(a),B(b)).*integral(funcIYgXandA,0,1);
    end
    toc
    figure(1);
    plot(0,0);
    text(0,0,sprintf('completed %2.2f percent',100*a/numPoints));
    drawnow
end
% MutualInformation = HYgA - HYgXandA;

% figure(1)
% surf(A,B,HYgA)
% title('H(Y|A)')
% xlabel('shape parameter a')
% ylabel('shape parameter b')
% zlabel('H(Y|A)')
% 
% figure(2)
% surf(A,B,HYgXandA)
% title('H(Y|X,A)')
% xlabel('shape parameter a')
% ylabel('shape parameter b')
% zlabel('H(Y|X,A)')

figure(3)
surf(A,B,RawInfo)
title('I(X;Y|A)')
xlabel('shape parameter a')
ylabel('shape parameter b')
zlabel('I(X;Y|A)')