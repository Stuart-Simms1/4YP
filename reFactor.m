%% I looked at the original code for the mathematical expression to look for errors/other ways of doing it
function dist = reFactor(dist,epsilon0,epsilon1)
if dist.num == 1
    d1 = 0;
    d2 = dist.d;
else
    d1 = dist.d1;
    d2 = dist.d2;
end
% dist.names = ["X","A","Y","P(X)","P(A)","P(Y)","P(A|X)","P(X|A)","p(X|Y,A)"];
% 
%             % X  A   Y  PX   PA           PY                    PA|X   PX|A                 pX|Y,A
% dist.Matrix =[0, d1, 0, 0.5, (e0+e1)/2,   (1+(d2-d1)*(e0-e1))/2, e0,   e0/(e0+e1),          (1-d1)*e0/(e0-d1*(e0-e1));...
%               0, d1, 1, 0.5, (e0+e1)/2,   (1-(d2-d1)*(e0-e1))/2, e0,   e0/(e0+e1),          d1*e0/(e1+d1*(e0-e1));...
%               0, d2, 0, 0.5, 1-(e0+e1)/2, (1+(d2-d1)*(e0-e1))/2, 1-e0, (1-e0)/(2-e0-e1),    d1*e1/(e0-d1*(e0-e1));...
%               0, d2, 1, 0.5, 1-(e0+e1)/2, (1-(d2-d1)*(e0-e1))/2, 1-e0, (1-e0)/(2-e0-e1),    (1-d1)*e1/(e1+d1*(e0-e1));...
%               1, d1, 0, 0.5, (e0+e1)/2,   (1+(d2-d1)*(e0-e1))/2, e1,   e1/(e0+e1),          (1-d2)*(1-e0)/(1-e0+d2*(e0-e1));...
%               1, d1, 1, 0.5, (e0+e1)/2,   (1-(d2-d1)*(e0-e1))/2, e1,   e1/(e0+e1),          d2*(1-e0)/(1-e1-d2*(e0-e1));...
%               1, d2, 0, 0.5, 1-(e0+e1)/2, (1+(d2-d1)*(e0-e1))/2, 1-e1, (1-e1)/(2-e0-e1),    d2*(1-e1)/(1-e0+d2*(e0-e1));...
%               1, d2, 1, 0.5, 1-(e0+e1)/2, (1-(d2-d1)*(e0-e1))/2, 1-e1, (1-e1)/(2-e0-e1),    (1-d2)*(1-e1)/(1-e1-d2*(e0-e1))];
% dist.pX = [0.5; 0.5];
% dist.pA = [(e0+e1)/2; 1-(e0+e1)/2];
% dist.pY = [(1+(d2-d1)*(e0-e1))/2; (1-(d2-d1)*(e0-e1))/2];
% dist.pAX = [e0, 1-e0; e1, 1-e1];
% dist.pXA = [e0/(e0+e1), (1-e0)/(2-e0-e1); e1/(e0+e1), (1-e1)/(2-e0-e1)];
% dist.pXAY(1,:,:) = [(1-d1)*e0/(e0-d1*(e0-e1)), d1*e0/(e1+d1*(e0-e1)); d1*e1/(e0-d1*(e0-e1)), (1-d1)*e1/(e1+d1*(e0-e1))];
% dist.pXAY(2,:,:) = [(1-d2)*(1-e0)/(1-e0+d2*(e0-e1)), d2*(1-e0)/(1-e1-d2*(e0-e1)); d2*(1-e1)/(1-e0+d2*(e0-e1)), (1-d2)*(1-e1)/(1-e1-d2*(e0-e1))];
% 

dist.pXis0 = 0.5;
dist.pXis1 = 0.5;

dist.pAisd1 = (epsilon0+epsilon1)/2;
dist.pAisd2 = 1-(epsilon0+epsilon1)/2;

dist.pYis0 = (1+(d2-d1)*(epsilon0-epsilon1))/2;
dist.pYis1 = (1-(d2-d1)*(epsilon0-epsilon1))/2;

dist.pAisd1GXis0 = epsilon0;
dist.pAisd1GXis1 = epsilon1;
dist.pAisd2GXis0 = 1-epsilon0;
dist.pAisd2GXis1 = 1-epsilon1;

dist.pXis0GAisd1 = epsilon0/(epsilon0+epsilon1);
dist.pXis0GAisd2 = (1-epsilon0)/(2-epsilon0-epsilon1);
dist.pXis1GAisd1 = epsilon1/(epsilon0+epsilon1);
dist.pXis1GAisd2 = (1-epsilon1)/(2-epsilon0-epsilon1);

dist.pXis0GYis0andAisd1 = (1-d1)*epsilon0/(epsilon0-d1*(epsilon0-epsilon1));
dist.pXis0GYis1andAisd1 = d1*epsilon0/(epsilon1+d1*(epsilon0-epsilon1));
dist.pXis0GYis0andAisd2 = d1*epsilon1/(epsilon0-d1*(epsilon0-epsilon1));
dist.pXis0GYis1andAisd2 = (1-d1)*epsilon1/(epsilon1+d1*(epsilon0-epsilon1));
dist.pXis1GYis0andAisd1 = (1-d2)*(1-epsilon0)/(1-epsilon0+d2*(epsilon0-epsilon1));
dist.pXis1GYis1andAisd1 = d2*(1-epsilon0)/(1-epsilon1-d2*(epsilon0-epsilon1));
dist.pXis1GYis0andAisd2 = d2*(1-epsilon1)/(1-epsilon0+d2*(epsilon0-epsilon1));
dist.pXis1GYis1andAisd2 = (1-d2)*(1-epsilon1)/(1-epsilon1-d2*(epsilon0-epsilon1));
end

