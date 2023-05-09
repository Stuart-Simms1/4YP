%% testing out the distribution maker

a = 2;
b = 1.1;
x = linspace(0,1,100);
myDist = makedist('PiecewiseLinear',x,(p0.*x.^(a-1).*(1-x).^(b-1) + p1.*x.^(b-1).*(1-x).^(a-1))./beta(a,b));