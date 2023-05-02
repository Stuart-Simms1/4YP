%% BetaVisualiser
clear all
close all
clc

B = @(x,a,b) (1/beta(a,b)).*x.^(a-1).*(1-x).^(b-1);

x = linspace(0,1,1000);

% a = [0.5;1.0;2.0;3.0;0.5;2.0];
% b = [0.5;1.0;3.0;2.0;2.0;0.5];
a = [1;1;1;1];
b = [1;0.9;0.5;0.1];

len = length(a);

figure()
for i = 1:len
    plot(x,B(x,a(i),b(i)))
    lbl = sprintf('a = %0.1f , b = %0.1f',a(i),b(i));
    lbls(i) = string(lbl);
    hold on
end
title('Beta Distribution with Various Shape Parameters')
axis([0;1;0;5])
xlabel('X')
xticks([0;0.2;0.4;0.6;0.8;1])
ylabel('pdf(x)')
legend(lbls,"Location","north")

