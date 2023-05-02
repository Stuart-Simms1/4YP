%% This is the final version of the function that defines the probabilities for the distributions

function dist = assign_probabilities(dist,e0,e1)
%% table
if dist.num == 1
    d1 = 0;
    d2 = dist.d;
else
    d1 = dist.d1;
    d2 = dist.d2;
end
p0 = dist.pXis0;
p1 = dist.pXis1;

pAisd1 = p0*e0+p1*e1;
pAisd2 = 1-(p0*e0+p1*e1);

pYis0 = p0*(1-(e0*(d1-d2)+d2))+p1*(e1*(d1-d2)+d2);
pYis1 = p0*(e0*(d1-d2)+d2)+p1*(1-(e1*(d1-d2)+d2));

pXis0gAisd1 = p0*e0/pAisd1;
pXis0gAisd2 = p0*(1-e0)/pAisd2;
pXis1gAisd1 = p1*e1/pAisd1;
pXis1gAisd2 = p1*(1-e1)/pAisd2;


% %                     P(X) P(A)        P(Y)                   P(X|A)             P(A|X)  P(X|Y,A)                           X A  Y 
% dist.Probabilities = [0.5 (e0+e1)/2    (1+(d2-d1)*(e0-e1))/2  e0/(e0+e1)         e0      (1-d1)*e0/(e0-d1*(e0-e1))        % 0 d1 0 
%                       0.5 (e0+e1)/2    (1-(d2-d1)*(e0-e1))/2  e0/(e0+e1)         e0      d1*e0/(e1+d1*(e0-e1))            % 0 d1 1 
%                       0.5 1-(e0+e1)/2  (1+(d2-d1)*(e0-e1))/2  (1-e0)/(2-e0-e1)   1-e0    (1-d2)*(1-e0)/(1-e0+d2*(e0-e1))  % 0 d2 0 
%                       0.5 1-(e0+e1)/2  (1-(d2-d1)*(e0-e1))/2  (1-e0)/(2-e0-e1)   1-e0    d2*(1-e0)/(1-e1-d2*(e0-e1))      % 0 d2 1 
%                       0.5 (e0+e1)/2    (1+(d2-d1)*(e0-e1))/2  e1/(e0+e1)         e1      d1*e1/(e0-d1*(e0-e1))            % 1 d1 0 
%                       0.5 (e0+e1)/2    (1-(d2-d1)*(e0-e1))/2  e1/(e0+e1)         e1      (1-d1)*e1/(e1+d1*(e0-e1))        % 1 d1 1 
%                       0.5 1-(e0+e1)/2  (1+(d2-d1)*(e0-e1))/2  (1-e1)/(2-e0-e1)   1-e1    d2*(1-e1)/(1-e0+d2*(e0-e1))      % 1 d2 0
%                       0.5 1-(e0+e1)/2  (1-(d2-d1)*(e0-e1))/2  (1-e1)/(2-e0-e1)   1-e1    (1-d2)*(1-e1)/(1-e1-d2*(e0-e1))];% 1 d2 1 



%                     P(X) P(A)   P(Y)   P(X|A)        P(A|X)  P(X|Y,A)                                            X A  Y 
dist.Probabilities = [p0 pAisd1   pYis0  pXis0gAisd1   e0      p0*e0*(1-d1)/(p0*e0*(1-d1)+p1*e1*d1)              % 0 d1 0 
                      p0 pAisd1   pYis1  pXis0gAisd1   e0      p0*e0*d1/(p0*e0*d1+p1*e1*(1-d1))                  % 0 d1 1 
                      p0 pAisd2   pYis0  pXis0gAisd2   1-e0    p0*(1-e0)*(1-d2)/(p0*(1-e0)*(1-d2)+p1*(1-e1)*d2)  % 0 d2 0 
                      p0 pAisd2   pYis1  pXis0gAisd2   1-e0    p0*(1-e0)*d2/(p0*(1-e0)*d2+p1*(1-e1)*(1-d2))      % 0 d2 1 
                      p1 pAisd1   pYis0  pXis1gAisd1   e1      p1*e1*d1/(p0*e0*(1-d1)+p1*e1*d1)                  % 1 d1 0 
                      p1 pAisd1   pYis1  pXis1gAisd1   e1      p1*e1*(1-d1)/(p0*e0*d1+p1*e1*(1-d1))              % 1 d1 1 
                      p1 pAisd2   pYis0  pXis1gAisd2   1-e1    p1*(1-e1)*d2/(p0*(1-e0)*(1-d2)+p1*(1-e1)*d2)      % 1 d2 0
                      p1 pAisd2   pYis1  pXis1gAisd2   1-e1    p1*(1-e1)*(1-d2)/(p0*(1-e0)*d2+p1*(1-e1)*(1-d2))];% 1 d2 1 

