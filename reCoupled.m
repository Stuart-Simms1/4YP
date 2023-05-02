%% trying again with the new functions
%% I have only included the test file for distribution 1 with alpha either being 0 or 0.1
clear all
close all
dist.num = 1;
dist.d = 0.1;
PC = 1; % If running on my PC this is 1, if from file this should be 0 to load the file correctly
mutualInfo = zeros(100);
epsilon0 = zeros(100,1);
epsilon1 = zeros(100,1);
for ep0 = 1:100
    for ep1 = 1:100
        epsilon0(ep0) = ep0/100;
        epsilon1(ep1) = ep1/100;
        dist = reFactor(dist,epsilon0(ep0),epsilon1(ep1));
        mutualInfo(ep0,ep1) = reInfo(dist);
    end
end
[Info,~] = readSurface(dist,PC);
figure(1)
surf(epsilon0,epsilon1,mutualInfo)
figure(2)
surf(epsilon0,epsilon1,Info)
figure(3)
coupledline1 = diag(fliplr(mutualInfo));
coupledline2 = diag(fliplr(Info));
plot(0.01:0.01:1,coupledline1,0.01:0.01:1,coupledline2)

