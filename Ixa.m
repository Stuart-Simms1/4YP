function output = Ixa(dist)
%This function implements the general expression for I(X;Y,A) I found.
    sA = length(dist.pA);
    sX = length(dist.pX);
    information = 0;
    for a = 1:sA
        information = information - xlogx(dist.pA(a));
        for x = 1:sX
            information = information + dist.pX(x)*xlogx(dist.pAX(a,x)); %- dist.pA(a)*xlogx(dist.pXA(a,x));
        end
    end
    output = information;
end