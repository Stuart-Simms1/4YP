function XAY = simulateChannel(d1,d2,e0,e1)
    samplex = rand;
    samplea = rand;
    sampley = rand;
    if samplex <0.5
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