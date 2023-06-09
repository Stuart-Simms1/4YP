%% Mutual information for the Z transform part
function Info = z_information(dist)
P = dist.Probabilities;
% Columns are P(X) P(A) P(Y) P(X|A) P(A|X) P(X|Y,A)
% P(relevant row,Column number)
%  P(A=0)*(-xlogx(P(X=0|A=0))-xlogx(P(X=1|A=0))
%           +P(Y=0)*(xlogx(P(X=0|Y=0,A=0))+xlogx(P(X=1|Y=0,A=0))
%           +P(Y=1)*(xlogx(P(X=0|Y=1,A=0))+xlogx(P(X=1|Y=1,A=0)))
% +P(A=d1)*(-xlogx(P(X=0|A=d1))-xlogx(P(X=1|A=d1))
%           +P(Y=0)*(xlogx(P(X=0|Y=0,A=d1))+xlogx(P(X=1|Y=0,A=d1))
%           +P(Y=1)*(xlogx(P(X=0|Y=1,A=d1))+xlogx(P(X=1|Y=1,A=d1)))
% +P(A=d2)*(-xlogx(P(X=0|A=d2))-xlogx(P(X=1|A=d2))
%           +P(Y=0)*(xlogx(P(X=0|Y=0,A=d2))+xlogx(P(X=1|Y=0,A=d2))
%           +P(Y=1)*(xlogx(P(X=0|Y=1,A=d2))+xlogx(P(X=1|Y=1,A=d2)))
% -xlogx(P(A=0))-xlogx(P(A=d1))-xlogx(P(A=d2))
% +P(X=0)*(xlogx(P(A=0|X=0))+xlogx(P(A=d1|X=0))+xlogx(P(A=d2|X=0)))
% +P(X=1)*(xlogx(P(A=0|X=1))+xlogx(P(A=d1|X=1))+xlogx(P(A=d2|X=1)))

Info = P(1,2)*(-xlogx(P(1,4))-xlogx(P(7,4)) ...
               +P(1,3)*(xlogx(P(1,6))+xlogx(P(7,6))) ...
               +P(2,3)*(xlogx(P(2,6))+xlogx(P(8,6))))...
      +P(3,2)*(-xlogx(P(3,4))-xlogx(P(9,4)) ...
               +P(3,3)*(xlogx(P(3,6))+xlogx(P(9,6))) ...
               +P(4,3)*(xlogx(P(4,6))+xlogx(P(10,6))))...
      +P(5,2)*(-xlogx(P(5,4))-xlogx(P(11,4)) ...
               +P(5,3)*(xlogx(P(5,6))+xlogx(P(11,6))) ...
               +P(6,3)*(xlogx(P(6,6))+xlogx(P(12,6))))...
      -xlogx(P(1,2))-xlogx(P(3,2))-xlogx(P(5,2))...
      +P(1,1)*(xlogx(P(1,5))+xlogx(P(3,5))+xlogx(P(5,5)))...
      +P(7,1)*(xlogx(P(7,5))+xlogx(P(9,5))+xlogx(P(11,5)));
end