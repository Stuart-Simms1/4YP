function XAY = simulateChannel(dist,e0,e1)
    if dist.num == 1
        d1 = 0;
        d2 = dist.d;
    else
        d1 = dist.d1;
        d2 = dist.d2;
    end
    samplex = rand;
    samplea = rand;
    sampley = rand;
    if samplex <dist.pXis1
        X=1;
        if samplea < e1
            A = d1;
        else
            A = d2;
        end
    else
        X=0;
        if samplea < e0
            A = d1;
        else
            A = d2;
        end
    end
    if sampley < A
        Y = 1-X;
    else
        Y = X;
    end
    XAY = [X;A;Y];
end