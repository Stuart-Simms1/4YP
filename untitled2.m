dist.num = 1;
dist.d = 0.1;
[Info,dist] = readSurface(dist);
coupledline = diag(fliplr(Info));
plot(0.01:0.01:1,coupledline,0.01:0.01:1,uncoupInfo*ones(100,1))