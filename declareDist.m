function dist = declareDist(dist,e0,e1)
%this function assigns the probability values of the distribution.
if dist.num == 1
%        A = {0,d} with p(0) = 1-p(d). p(0) = ep0 when X = 0 and p(0) = ep1 when X = 1.
%
%         A = [0,dist.d];  These are the values that the variables can take
%         X = [0,1];  
%         Y = [0,1];

        dist.pA = [(e0+e1)/2, 1-(e0+e1)/2];  %p(A)
        dist.pX = [0.5, 0.5];
        dist.pY = [(1+dist.d*(e0-e1))/2, (1-dist.d*(e0-e1))/2];

        dist.pAX = [e0,   e1;
                    1-e0, 1-e1];    %p(A|X) from the distribution

        dist.pXA = [e0/(e0+e1),       e1/(e0+e1);
                    (1-e0)/(2-e0-e1), (1-e1)/(2-e0-e1)]; %p(X|A) from my table

        dist.pXYA(1,:,:) = [1,0; 
                            0,1];    %p(X|Y,A=0) from the table

        dist.pXYA(2,:,:) = [(1-dist.d)*(1-e0)/(1-e0+dist.d*(e0-e1)),    dist.d*(1-e0)/(1-e1-dist.d*(e0-e1));
                            dist.d*(1-e1)/(1-e0+dist.d*(e0-e1)),     (1-dist.d)*(1-e1)/(1-e1-dist.d*(e0-e1))];  %p(X|Y,A=delta) from the table
end
if dist.num == 2
%        A = {d1,d2} with p(d1) = 1-p(d2). p(d1) = ep0 when X = 0 and p(d1) = ep1 when X = 1.
%
%         A = [dist.d1,dist.d2];  These are the values that the variables can take
%         X = [0,1];  
%         Y = [0,1];
    dist.pA = [(e0+e1)/2, 1-(e0+e1)/2];  %p(A)
    dist.pX = [0.5, 0.5];
    dist.pY = [(1+(dist.d2-dist.d1)*(e0-e1))/2, (1-(dist.d2-dist.d1)*(e0-e1))/2];

    dist.pAX = [e0,   e1;
                1-e0, 1-e1];    %p(A|X) from the distribution

    dist.pXA = [e0/(e0+e1),       e1/(e0+e1);
                (1-e0)/(2-e0-e1), (1-e1)/(2-e0-e1)]; %p(X|A) from my table

    dist.pXYA(1,:,:) = [(1-dist.d1)*e0/(e0-dist.d1*(e0-e1)), dist.d1*e0/(e1+dist.d1*(e0-e1));
                        dist.d1*e1/(e0-dist.d1*(e0-e1)),     (1-dist.d1)*e1/(e1+dist.d1*(e0-e1))]; %p(X|Y,A=d1) from the table

    dist.pXYA(2,:,:) = [(1-dist.d2)*(1-e0)/(1-e0+dist.d2*(e0-e1)), dist.d2*(1-e0)/(1-e1-dist.d2*(e0-e1));
                        dist.d2*(1-e1)/(1-e0+dist.d2*(e0-e1)),     (1-dist.d2)*(1-e1)/(1-e1-dist.d2*(e0-e1))]; %p(X|Y,A=d2) from the table

end
end