%% Test Function comparing to BSC case
clear all

dist.num = 1;
resolution = 100;
e0 = 0;
e1 = 0; 
dist.d = linspace(0,1,resolution);
for i = 1:resolution
    tempdist.d = dist.d(i);
    tempdist.num = dist.num;
    tempdist = declareDist(tempdist,e0,e1);
    Info(i) = Ixya(tempdist);
    % BSC with transition probability d
    hYX = -xlogx(dist.d(i))-xlogx(1-dist.d(i));
    %hY = -xlogx(dist.pY(1))-xlogx(dist.pY(2));
    hY = 1;
    BSCInfo(i) = hY - hYX;
end

figure("Name","Comparison between BSC functions")
subplot(2,1,1)
plot(dist.d,Info)
title('Information from my function with e0=e1=0 i.e. alpha=d')
xlabel('transition probability d')
ylabel('I(X;Y,A)')

subplot(2,1,2)
plot(dist.d, BSCInfo)
title('Information from BSC function')
xlabel('transition probability d')
ylabel('I(X;Y,A)')
