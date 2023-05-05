%% Visualising the regions of constant f(A,a,b)
clear all
close all
clc

f = @(x,a,b) x.^(a-1).*(1-x).^(b-1) + x.^(b-1).*(1-x).^(a-1) - 2.*beta(a,b);

dfdx = @(x,a,b) (a-1).*x.^(a-2).*(1-x).^(b-1) - (b-1).*x.^(a-1).*(1-x).^(b-2)...
                +(b-1).*x.^(b-2).*(1-x).^(a-1) - (a-1).*x.^(b-1).*(1-x).^(a-2);

dfda = @(x,a,b) log(x).*x.^(a-1).*(1-x).^(b-1) + log(1-x).*x.^(b-1).*(1-x).^(a-1) + 2.*beta(a,b).*(psi(a+b)-psi(a));

dfdb = @(x,a,b) log(1-x).*x.^(a-1).*(1-x).^(b-1) + log(x).*x.^(b-1).*(1-x).^(a-1) + 2.*beta(a,b).*(psi(a+b)-psi(b));

X = linspace(0,1,100);
A = logspace(-1,1,100);
B = [0.5;5;10];

F = zeros(length(A),length(B),length(X));
dFdX = zeros(length(A),length(B),length(X));
dFdA = zeros(length(A),length(B),length(X));
dFdB = zeros(length(A),length(B),length(X));
for a = 1:length(A)
    for b = 1:length(B)
        F(a,b,:) = f(X,A(a),B(b));
        dFdX(a,b,:) = dfdx(X,A(a),B(b));
        dFdA(a,b,:) = dfda(X,A(a),B(b));
        dFdB(a,b,:) = dfdb(X,A(a),B(b));
    end
end

% % Viewing the plots
% for i = 1:length(A)
%     for j = 1:length(B)
%         figure((i-1).*length(A)+j)
%         
% 
%         subplot(4,1,1)
%         plot(X,squeeze(F(i,j,:)),'LineWidth',2.0)
%         title(sprintf('plot of f(\x03B1,a,b) and derivatives at a = %g, b = %g',A(i),B(j)))
%         ylabel(sprintf('f(\x03B1,a,b)'))
% 
%         subplot(4,1,2)
%         plot(X,squeeze(dFdX(i,j,:)),'LineWidth',2.0)
%         ylabel(sprintf('df/d\x03B1'))
% 
%         subplot(4,1,3)
%         plot(X,squeeze(dFdA(i,j,:)),'LineWidth',2.0)
%         ylabel('df/da')
% 
%         subplot(4,1,4)
%         plot(X,squeeze(dFdB(i,j,:)),'LineWidth',2.0)
%         ylabel('df/db')
%         xlabel(sprintf('\x03B1'))
% 
%     end
% end
% Animation through As
for i = 1:length(A)
    for j = 1:length(B)
        figure(j)
    subplot(4,1,1)
    plot(X,squeeze(F(i,j,:)),'LineWidth',2.0)
    title(sprintf('plot of f(\x03B1,a,b) and derivatives at a = %g, b = %g',A(i),B(j)))
    ylabel(sprintf('f(\x03B1,a,b)'))

    subplot(4,1,2)
    plot(X,squeeze(dFdX(i,j,:)),'LineWidth',2.0)
    ylabel(sprintf('df/d\x03B1'))

    subplot(4,1,3)
    plot(X,squeeze(dFdA(i,j,:)),'LineWidth',2.0)
    ylabel('df/da')

    subplot(4,1,4)
    plot(X,squeeze(dFdB(i,j,:)),'LineWidth',2.0)
    ylabel('df/db')
    xlabel(sprintf('\x03B1'))
    end
    drawnow
    pause(0.01)
end