function output = Ixya(dist)
%This function implements the general expression for I(X;Y,A) I found.
    sA = length(dist.pA);
    sX = length(dist.pX);
    sY = length(dist.pY);
    information = 0;
    
    for a = 1:sA
        information = information - xlogx(dist.pA(a));
        for x = 1:sX
            information = information - dist.pA(a)*xlogx(dist.pXA(a,x)) + dist.pX(x)*xlogx(dist.pAX(a,x));
            for y = 1:sY
                information = information + dist.pA(a)*dist.pY(y)*xlogx(dist.pXYA(a,x,y));
            end
        end
    end
    output = information;
end