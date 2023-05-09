%% Uncoupled information

clear all
close all
clc

dist.num = 2;
dist.pXis0 = 0.5;
dist.pXis1 = 0.5;
d1 = linspace(0,1,100);
d2 = d1;
e0 = 0.5;
e1 = 1-e0;
MItheory = zeros(length(d1));
MISim = zeros(length(d1));
for i = 1:length(d1)
    for j = 1:length(d2)
        dist.d1 = d1(i);
        dist.d2 = d2(j);
        dist = assign_probabilities(dist,e0,e1);
        MItheory(i,j) = mutual_information(dist); 
        MISim(i,j) = uncoupledInfo(100000,dist,1);
    end
end
figure(1)
surf(d1,d2,MItheory,'EdgeColor','none')
title(sprintf('Uncoupled Case I(X;Y,A) with uniform input distribution'))
xlabel('Delta 1')
ylabel('Delta 2')
zlabel('I(X;Y,A)')
figure(2)
surf(d1,d2,MISim,'EdgeColor','none')
title(sprintf('Uncoupled Case I(X;Y,A) with uniform input distribution'))
xlabel('Delta 1')
ylabel('Delta 2')
zlabel('I(X;Y,A)')