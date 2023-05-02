%% Z channel probabilities
function dist = assign_Z(dist,e1)
if dist.num == 1
    d1 = 0;
    d2 = dist.d;
else
    d1 = dist.d1;
    d2 = dist.d2;
end
p0 = dist.pXis0;
p1 = dist.pXis1;

pYis0 = p0 + p1*e1*d1 + p1*(1-e1)*d2;
pYis1 = p1*e1*(1-d1) + p1*(1-e1)*(1-d2);

%                     P(X) P(A)         P(Y)    P(X|A) P(A|X) P(X|Y,A) X A  Y
dist.Probabilities = [p0   p0           pYis0   1      1      1       %0 0  0
                      p0   p0           pYis1   1      1      0       %0 0  1
                      p0   p1*e1        pYis0   0      0      0       %0 d1 0
                      p0   p1*e1        pYis1   0      0      0       %0 d1 1
                      p0   p1*(1-e1)    pYis0   0      0      0       %0 d2 0
                      p0   p1*(1-e1)    pYis1   0      0      0       %0 d2 1
                      p1   p0           pYis0   0      0      0       %1 0  0
                      p1   p0           pYis1   0      0      1       %1 0  1
                      p1   p1*e1        pYis0   1      e1     1       %1 d1 0
                      p1   p1*e1        pYis1   1      e1     1       %1 d1 1
                      p1   p1*(1-e1)    pYis0   1      1-e1   1       %1 d2 0
                      p1   p1*(1-e1)    pYis1   1      1-e1   1];     %1 d2 1]

end