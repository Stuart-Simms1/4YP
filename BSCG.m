%% BSC Graph
clear all 
close all
clc
% 
% x = linspace(0,1,1000);
% 
% Hx = @(x) -(x.*log2(x)+(1-x).*log2(1-x));
% 
% plot(x,1-Hx(x))
% title('Capacity of BSC')
% xlabel(sprintf('transition probability \x03B1'))
% ylabel('Capacity')

numPoints = 100;
A = logspace(-2,2,numPoints);
B = [1,1];
p0 = 0.5;
p1 = 1-p0;


ExpectedValue = @(a,b) a./(a+b);
EntropyCoefficient = @(a,b) 1/beta(a,b);
rawInfo = zeros(numPoints,1);
expectedAlpha = zeros(numPoints,1);
warningCounter = containers.Map();
for a = 1:numPoints
    for b = 1
        funcIYgXandA = @(x) x.^(A(a)-1).*(1-x).^(B(b)-1).*...
            (((1-x).*p0 + x.*p1).*log2((1-x).*p0 + x.*p1) +...
            (x.*p0 + (1-x).*p1).*log2(x.*p0 + (1-x).*p1)-...
            (x.*log2(x) + (1-x).*log2(1-x)));
        
        rawInfo(a) = -EntropyCoefficient(A(a),B(b)).*integral(funcIYgXandA,0,1);
%         [msgstr, msgid] = lastwarn;
%         lastwarn(''); % Reset lastwarn
%         if ~isempty(msgstr)
%             if isKey(warningCounter, msgstr)
%                 warningCounter(msgstr) = warningCounter(msgstr)+1;
%             else
%                 warningCounter(msgstr) = 1;
%             end
%         end
        expectedAlpha(a) = ExpectedValue(A(a),B(b));
    end
end
% disp([warningCounter.keys; warningCounter.values])
figure()
plot(expectedAlpha,rawInfo)
title(sprintf('I(X;Y|A) vs Expected Value of \x03B1'))
xlabel(sprintf('E[\x03B1]'))
ylabel('I(X;Y|A)')
hold on
plot(ones(10,1)*expectedAlpha(31),linspace(0,1,10),'r--')
fill([0;0;expectedAlpha(31);expectedAlpha(31)],[0;1;1;0],[0.8500 0.3250 0.0980],'FaceAlpha',0.2,'EdgeColor','none')
