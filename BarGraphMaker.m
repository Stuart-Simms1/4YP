%This program will make a bar graph comparing the mutual information of the
%coupled case agiasnt the uncoupled case with H(Y) = 1.
clear all
close all
%% declaring variables
dist.num = 1;
dist.d = 0.10;
% dist.num = 2;
% dist.d1 = 0.05;
% dist.d2 = 0.15;
numIterations = 1000000;
option = 2;

% find the information surface for the given distribution
[Info,dist] = readSurface(dist);
% simulate the uncoupled case information value
uncoupInfo = uncoupledInfo(numIterations,dist,option);

% find a pair of e0 and e1 that is above the uncoupled info
meshgreater = Info > uncoupInfo;
foundg = 0;
while foundg == 0
    e0(1) = randi([2,100]);
    e1(1) = randi([2,100]);
    if meshgreater(e0(1),e1(1)) == 1
        foundg = 1
    end
end

% [maxInfo, maxInfoIndex] = max(Info,[],"all");
% e0(1) = ceil(maxInfoIndex);
% e1(1) = mod(maxInfoIndex,100)+1;

% find a pair of e0 and e1 that is below the uncoupled info
foundl = 0;
iterations = 1000;
while foundl == 0 && iterations > 0
    e0(2) = randi([2,max([4,100-mod(iterations,100)])]);
    e1(2) = randi([2,max([4,100-mod(iterations,100)])]);
    if meshgreater(e0(2),e1(2)) == 0
        foundl = 1
    end
    iterations = iterations - 1;
end

% [minInfo,minInfoIndex] = min(Info,[],'all');
% e0(2) = ceil(minInfoIndex);
% e1(2) = mod(minInfoIndex,100)+1;


ep0 = e0/100;
ep1 = e1/100;


for i = 1:2
%     if i==1 || iterations ~=0 
        dist = declareDist(dist,ep0(i),ep1(i));
        IXA = Ixa(dist);
        IXYGivenA = Ixygivena(dist);
        
        subplot(2,1,i)
        Bars = [uncoupInfo, 0; IXYGivenA, IXA; Info(e0(i),e1(i)), 0];
        titles = categorical({'uncoupled I(X;Y)','Simulated I(X;Y,A)','Calculated I(X;Y,A)'});
        titles = reordercats(titles,{'uncoupled I(X;Y)','Simulated I(X;Y,A)','Calculated I(X;Y,A)'});
        bar(titles, Bars, 'stacked')
        ylim([0,1])
        if dist.num == 1
            text = sprintf('e0 = %1.2f , e1 = %1.2f , d = %1.2f ', ep0(i),ep1(i),dist.d);
        else
            text = sprintf('e0 = %1.2f , e1 = %1.2f , d1 = %1.2f , d2 = %1.2f', ep0(i),ep1(i),dist.d1,dist.d2);
        end
        title(text);
        hold on
%     end
end
figure(2)
surface(meshgreater)
xlabel('e0 from 0 to 1')
ylabel('e1 from 0 to 1')
