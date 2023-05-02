%% Coupled Binary Symmetric Channel with uniform input distribution
% input is uniformly distributed and the transittion probability is subject
% to the distribution in question.
clear
close all
dist.num = 1;
dist.d = 0.1;    %transition probability delta
dist.d1 = 0.1;
dist.d2 = 0.01;
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
    text = sprintf('Using distribution 1 with d = 0,%d',round(resolution*dist.d));
end
if dist.num == 2
    text = sprintf('Using distribution 2 with d1 = 0,%d, d2 = 0,%d',round(resolution*dist.d1),round(resolution*dist.d2));
end
figure('Name',text)
surf(ep0,ep1,Info,EdgeColor="none")
title('Mutual Information of X:Y,A')
xlabel 'epsilon 0'
ylabel 'epsilon 1'
% hold on 
% surf(ep1,ep0,comparison)

figure('Name',text)
plot(ep0,Info(:,1),ep0,Info(:,25),ep0,Info(:,50),ep0,Info(:,75),ep0,Info(:,100))
title('Mutual Information of X:Y,A vs e0 at fixed e1')
xlabel 'epsilon 0'
ylabel 'Mutual Information'
legend('e1 = 0','e1 = 0.25','e1 = 0.5','e1 = 0.75','e1 = 1','Location','northwest')

figure('Name',text)
plot(ep1,Info(1,:),ep1,Info(25,:),ep1,Info(50,:),ep1,Info(75,:),ep1,Info(100,:))
title('Mutual Information of X:Y,A vs e1 at fixed e0')
xlabel 'epsilon 1'
ylabel 'Mutual Information'
legend('e0 = 0','e0 = 0.25','e0 = 0.5','e0 = 0.75','e0 = 1','Location','northwest')

writematrix(Info,text)