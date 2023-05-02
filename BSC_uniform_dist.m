%% Mutual Information for a coupled binary symmetric channel where the 
% input is uniformly distributed and the transittion probability is subject
% to the distribution {0,d} with p(0) = 1-p(d). p(0) = ep0 when X = 0 and
% p(0) = ep1 when X = 1.
% 
%% define variables
clear
delta = 0.1;
py0 = 0.5;
py1 = 0.5;
resolution = 100;
ep0 = linspace(0,1,resolution);
ep1 = linspace(0,1,resolution);
Info = zeros(resolution);
constraint = zeros(resolution);
for i = 1:resolution
    for j = 1:resolution
        Info(i,j) = Ixya(delta,ep0(i),ep1(j),py0,py1);
        if ep0(i) == 1-ep1(j)
            constraint(i,j) = 1;
        else
            constraint(i,j) = 0;
        end
    end
end
%% plot results
figure(1)
title('Mutual Information of X:Y,A')
surf(ep0,ep1,Info,EdgeColor="none")
xlabel 'epsilon 0'
ylabel 'epsilon 1'

figure(2)
title('Mutual Information of X:Y,A')
plot(ep0,Info(:,1),ep0,Info(:,25),ep0,Info(:,50),ep0,Info(:,75),ep0,Info(:,99))    %,ep0,Info(:,50),ep0,Info(:,60),ep0,Info(:,70),ep0,Info(:,80),ep0,Info(:,90),ep0,Info(:,100));
xlabel 'epsilon 0  at values of epsilon 1 increasing in 0.25s'
ylabel 'Mutual Information'
legend('e1 = 0.01','e1 = 0.25','e1 = 0.5','e1 = 0.75','e1 = 0.99')                     %,'e1 = 0.5','e1 = 0.6','e1 = 0.7','e1 = 0.8','e1 = 0.9','e1 = 1')

figure(3)
title('Mutual Information of X:Y,A')
plot(ep1,Info(1,:),ep1,Info(25,:),ep1,Info(50,:),ep1,Info(75,:),ep1,Info(99,:))    %ep1,Info(50,:),ep1,Info(60,:),ep1,Info(70,:),ep1,Info(80,:),ep1,Info(90,:),ep1,Info(100,:))
xlabel 'epsilon 1 at values of epsilon 0 increasing in 0.1s'
ylabel 'Mutual Information'
legend('e1 = 0.01','e1 = 0.25','e1 = 0.5','e1 = 0.75','e1 = 0.99')                     %,'e0 = 0.5','e0 = 0.6','e0 = 0.7','e0 = 0.8','e0 = 0.9','e0 = 1')

% hold on
% surf(e0,e1,constraint)
[M,I] = max(Info);
[a,b] = max(M);
a
I(b)
b


function output = Ixya(delta,ep0,ep1,py0,py1)
output = -(ent(ep0/(ep0+ep1)) + ent(ep1/(ep0+ep1))) ...
    -((ep0+ep1)/2)*(ent(ep0/(ep0+ep1)) + ent(ep1/(ep0+ep1)))...
    -(1-(ep0+ep1)/2)*(ent((1-ep0)/(2-ep0-ep1)) + ent((1-ep1)/(2-ep0-ep1))...
    + py0*(ent((1-delta)*(1-ep0)/(1-(ep0+ep1)/2)) + ent(delta*(1-ep1)/(1-(ep0+ep1)/2)))...
    + py1*(ent(delta*(1-ep0)/(1-(ep0+ep1)/2)) + ent((1-delta)*(1-ep1)/(1-(ep0+ep1)/2))));
end

function output = ent(x)
    output = x*log2(x);
end