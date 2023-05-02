%% Original Coupled Binary Symmetric Channel with uniform input distribution
% input is uniformly distributed and the transittion probability is subject
% to the distribution in question.
clear all
close all
clc
dist.num = 2;
dist.d = 0.1;    %transition probability delta
dist.d1 = 0.1;
dist.d2 = 0.5;
resolution = 100;
ep0 = linspace(0,1,resolution); %test for a range of ep0 from 0 to 1
ep1 = linspace(0,1,resolution); %test for a range of ep1 from 0 to 1
% ep0 = ones(1,resolution);
% ep1 = ones(1,resolution);
Info = zeros(resolution);

% if dist.num == 1
%     hY = 1;
%     hYX = -xlogx(dist.d)-xlogx(1-dist.d);
%     uncoupledInfo = hY-hYX;
% end
% comparison = uncoupledInfo*ones(resolution);


for i = 1:resolution
    e0 = ep0(i);
    for j = 1:resolution
        e1 = ep1(j);
        %Defining the distribution probabilities
        dist = declareDist(dist,e0,e1);

        Info(i,j) = Ixya(dist);  %compute the mutual information for these e0,e1.
    end
end

%% plotting results
if dist.num == 1
    text = sprintf(' Using Dist 1 with d = %g',dist.d);
end
if dist.num == 2
    text = sprintf(' Using Dist 2 with d\x2081 = %g, d\x2082 = %g',dist.d1,dist.d2);
end
figure('Name',text)
surf(ep0,ep1,Info,EdgeColor="none")
title(strcat('I(X:Y,A) ',text))
xlabel(sprintf('\x03F5\x2080'))
ylabel(sprintf('\x03F5\x2081'))
zlabel(sprintf('I(X;Y,A)'))
% hold on 
% surf(ep1,ep0,comparison)

figure('Name',text)
plot(ep0,Info(:,1),ep0,Info(:,25),ep0,Info(:,50),ep0,Info(:,75),ep0,Info(:,100))
title(strcat(sprintf('I(X:Y,A) vs \x03F5\x2080 at Fixed \x03F5\x2081,'),text))
xlabel(sprintf('\x03F5\x2080'))
ylabel(sprintf('I(X;Y,A)'))
legend(sprintf('\x03F5\x2081 = 0'),sprintf('\x03F5\x2081 = 0.25'),sprintf('\x03F5\x2081 = 0.5'),sprintf('\x03F5\x2081 = 0.75'),sprintf('\x03F5\x2081 = 1'),'Location','south')

figure('Name',text)
plot(ep1,Info(1,:),ep1,Info(25,:),ep1,Info(50,:),ep1,Info(75,:),ep1,Info(100,:))
title(strcat(sprintf('I(X:Y,A) vs \x03F5\x2081 at Fixed \x03F5\x2080,'),text))
xlabel(sprintf('\x03F5\x2081'))
ylabel(sprintf('I(X;Y,A)'))
legend(sprintf('\x03F5\x2080 = 0'),sprintf('\x03F5\x2080 = 0.25'),sprintf('\x03F5\x2080 = 0.5'),sprintf('\x03F5\x2080 = 0.75'),sprintf('\x03F5\x2080 = 1'),'Location','south')

% writematrix(Info,text)