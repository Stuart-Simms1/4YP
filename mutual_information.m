%% This is the final version of the function for I(X;Y,A)


function MI = mutual_information(dist)
P = dist.Probabilities;

% Columns are P(X) P(A) P(Y) P(X|A) P(A|X) P(X|Y,A)
% P(relevant row,Column number)

%  P(A=d1)*(-xlogx(P(X=0|A=d1))-xlogx(P(X=1|A=d1))
%           +P(Y=0)*(xlogx(P(X=0|Y=0,A=d1))+xlogx(P(X=1|Y=0,A=d1))
%           +P(Y=1)*(xlogx(P(X=0|Y=1,A=d1))+xlogx(P(X=1|Y=1,A=d1)))
% +P(A=d2)*(-xlogx(P(X=0|A=d2))-xlogx(P(X=1|A=d2))
%           +P(Y=0)*(xlogx(P(X=0|Y=0,A=d2))+xlogx(P(X=1|Y=0,A=d2))
%           +P(Y=1)*(xlogx(P(X=0|Y=1,A=d2))+xlogx(P(X=1|Y=1,A=d2)))
% -xlogx(P(A=d1))-xlogx(P(A=d2))
% +P(X=0)*(xlogx(P(A=d1|X=0))+xlogx(P(A=d2|X=0)))
% +P(X=1)*(xlogx(P(A=d1|X=1))+xlogx(P(A=d2|X=1)))

MI = P(1,2)*(-xlogx(P(1,4))-xlogx(P(5,4))...
             +P(1,3)*(xlogx(P(1,6))+xlogx(P(5,6)))...
             +P(2,3)*(xlogx(P(2,6))+xlogx(P(6,6))))...
    +P(3,2)*(-xlogx(P(3,4))-xlogx(P(7,4))...
             +P(3,3)*(xlogx(P(3,6))+xlogx(P(7,6)))...
             +P(4,3)*(xlogx(P(4,6))+xlogx(P(8,6))))...
    -xlogx(P(1,2))-xlogx(P(3,2))...
    +P(1,1)*(xlogx(P(1,5))+xlogx(P(3,5)))...
    +P(5,1)*(xlogx(P(5,5))+xlogx(P(7,5)));