%% Simulating Uncoupled mutual Information
% E(a)[I(X;Y|A=a)]
% assuming alpha is a uniformly distributed variable between 0 and 1/2
numits = 10000;
iterations = 100;
for its = 1:iterations
iXYa = zeros(numits,1);
ave = zeros(numits,1);
for i = 1:numits
    a = 0.5*rand;
    %pX = 0.5;
    iXYa(i) = 1 - (-xlogx(a)-xlogx(1-a));
    ave(i) = sum(iXYa)/i;
end
AVE(its) = ave(end);
end

% subplot(1,2,1)
% plot(iXYa)
% hold on
% subplot(1,2,2)
% plot(ave)

expectedValue = sum(AVE)/iterations; %% This is usually 0.2785
totalIterations = numits*iterations %% currently 10 million