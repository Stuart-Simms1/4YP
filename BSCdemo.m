%% BSC Easy
p = linspace(0,1,1000);
MI = @(p) -p.*log2(p) - (1-p).*log2(1-p);

plot(p,MI(p))
title('Entropy of a binary variable')
axis ([0;1;0;1.1])
xlabel('p')
ylabel('H(p)')
hold on 
plot(0.5,MI(0.5),'rx')
text(0.5+0.02,MI(0.5)+0.03,'p = 0.5')
