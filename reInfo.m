%% finds the mutual information from my maths
function info = reInfo(dist)
%% defining distribution probabilities for clarity
pXis0 = dist.pXis0;
pXis1 = dist.pXis1;

pAisd1 = dist.pAisd1;
pAisd2 = dist.pAisd2;

pYis0 = dist.pYis0;
pYis1 = dist.pYis1;

pXis0GAisd1 = dist.pXis0GAisd1;
pXis1GAisd1 = dist.pXis1GAisd1;
pXis0GAisd2 = dist.pXis0GAisd2;
pXis1GAisd2 = dist.pXis1GAisd2;

pAisd1GXis0 = dist.pAisd1GXis0;
pAisd2GXis0 = dist.pAisd2GXis0;
pAisd1GXis1 = dist.pAisd1GXis1;
pAisd2GXis1 = dist.pAisd2GXis1;

pXis0GYis0andAisd1 = dist.pXis0GYis0andAisd1;
pXis1GYis0andAisd1 = dist.pXis1GYis0andAisd1;
pXis0GYis1andAisd1 = dist.pXis0GYis1andAisd1;
pXis1GYis1andAisd1 = dist.pXis1GYis1andAisd1;
pXis0GYis0andAisd2 = dist.pXis0GYis0andAisd2;
pXis1GYis0andAisd2 = dist.pXis1GYis0andAisd2;
pXis0GYis1andAisd2 = dist.pXis0GYis1andAisd2;
pXis1GYis1andAisd2 = dist.pXis1GYis1andAisd2;

%% implementing the terms from my expression
term1 = pAisd1*(-xlogx(pXis0GAisd1)-xlogx(pXis1GAisd1)) + pAisd2*(-xlogx(pXis0GAisd2)-xlogx(pXis1GAisd2));
term2 = pAisd1*(pYis0*(xlogx(pXis0GYis0andAisd1) + xlogx(pXis1GYis0andAisd1))...
               +pYis1*(xlogx(pXis0GYis1andAisd1) + xlogx(pXis1GYis1andAisd1)))...
       +pAisd2*(pYis0*(xlogx(pXis0GYis0andAisd2) + xlogx(pXis1GYis0andAisd2))...
               +pYis1*(xlogx(pXis0GYis1andAisd2) + xlogx(pXis1GYis1andAisd2)));
term3 = -xlogx(pAisd1) - xlogx(pAisd2);
term4 = pXis0*(xlogx(pAisd1GXis0) + xlogx(pAisd2GXis0)) + pXis1*(xlogx(pAisd1GXis1) + xlogx(pAisd2GXis1));
%% summing them up to get I(X;Y,A)
info = term1 + term2 + term3 + term4;
end