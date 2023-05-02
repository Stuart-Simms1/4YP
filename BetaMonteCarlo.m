%% MonteCarlo method for Beta distributed Channel
clear all
close all
clc

% Declare variables
numPoints = 100;
numIts = 100000;
% A = [1;1];
% B = [2.2;2.2];
A = linspace(0.1,10,numPoints);
B = A;
p0 = 0.5;
%% This will take 8hrs 20mins to run
% for each set of parameters
mutualInfo = zeros(numPoints);
for a = 1:numPoints
    tic
    for b = 1:numPoints
        mutualInfo(a,b) = monteCarloComplicated(A(a),B(b),p0,numIts);
    end
    toc
    disp(a);
    txt1 = sprintf('sim100klinspace(01,10,100)upto%g.txt',A(a));
    writematrix(mutualInfo,txt1)
end
txt = sprintf('sim100klinspace(01,10,100)final.txt');
writematrix(mutualInfo,txt);
surf(A,B,mutualInfo);
xlabel('a')
ylabel('b')
zlabel('I(X;Y,A)')
axis([0;10;0;10;0;1])

function mutualInfo = monteCarloSimple(a,b,p0,numIts)
XAY = zeros(numIts,3);%,"gpuArray");

for i = 1:numIts
    XAY(i,:) = simulateChannel(a,b,p0);
end             % This loop takes 0.8s with 100k iterations
% rawXAY = XAY;
% Calculate X probabilities
Xzeros = XAY(:,1) == 0;
Xones = XAY(:,1) == 1;

pXis1 = sum(XAY(Xones,1))./numIts;
pXis0 = 1 - pXis1;

% Calculate the probabilies including A|X
% int [p(A|X)*log(p(A|X))]
YgXis0 = XAY(Xzeros,3);
lenAgXzero = length(YgXis0);
invlenAgXzero = 1./lenAgXzero;
intpAgXlpAgX0 = log2mine(invlenAgXzero); 
% int [p(A|X)*(p(Y=0|X,A)*log(p(Y=0|X,A)) + p(Y=1|X,A)*log(p(Y=1|X,A)))]
% integrandYXA0 = zeros(lenAgXzero,1,"gpuArray");
% for alpha = 1:lenAgXzero
%     pY1gAX0 = YgXis0(alpha).*invlenAgXzero;
%     integrandYXA0(alpha) = invlenAgXzero.*(pY1gAX0.*log2mine(pY1gAX0) + (1-pY1gAX0).*log2mine(1-pY1gAX0));
% end

% Linear algebra version
pY1gAX0 = YgXis0.*invlenAgXzero;
pY0gAX0 = ones(lenAgXzero,1)-pY1gAX0;%,"gpuArray")-pY1gAX0;
integrandYXA0 = invlenAgXzero.*(pY1gAX0.*log2mine(pY1gAX0) + pY0gAX0.*log2mine(pY0gAX0));
intpAgXlpYgAX0 = sum(integrandYXA0); %%%% NaN


YgXis1 = XAY(Xones,3);
lenAgXone = length(YgXis1);
invlenAgXone = 1./lenAgXone;
intpAgXlpAgX1 = log2mine(invlenAgXone);

% int [p(A|X)*(p(Y=0|X,A)*log(p(Y=0|X,A)) + p(Y=1|X,A)*log(p(Y=1|X,A)))]
% integrandYXA1 = zeros(lenAgXone,1,"gpuArray");
% for alpha = 1:lenAgXone
%     pY1gAX1 = YgXis1(alpha).*invlenAgXone;
%     integrandYXA1(alpha) = invlenAgXone.*(pY1gAX1.*log2mine(pY1gAX1) + (1-pY1gAX1).*log2mine(1-pY1gAX1));
% end

% Linear Algebra version
pY1gAX1 = YgXis1.*invlenAgXone;
pY0gAX1 = ones(lenAgXone,1)-pY1gAX1;%,"gpuArray")-pY1gAX1;
integrandYXA1 = invlenAgXone.*(pY1gAX1.*log2mine(pY1gAX1) + pY0gAX1.*log2mine(pY0gAX1));


intpAgXlpYgAX1 = sum(integrandYXA1);



% Calculate the probabilities including p(A)
% int [p(A)log(p(A))]
lenA = length(XAY(:,2));
invlenA = 1./lenA;
intpAlpA = log2mine(invlenA);

% int [p(A)*(p(Y=1|A)*log(p(Y=1|A)) + p(Y=0|A)*log(p(Y=0|A)))]
% integrandAYA = zeros(lenA,1,"gpuArray");
% for alpha = 1:lenA
%     pY1gA = XAY(alpha,3).*invlenA;
%     integrandAYA(alpha) = invlenA.*(pY1gA.*log2mine(pY1gA) + (1-pY1gA).*log2mine(1-pY1gA));
% end

% Linear algebra version
pY1gA = XAY(:,3).*invlenA;
pY0gA = ones(lenA,1)-pY1gA;%,"gpuArray")-pY1gA;
integrandAYA = invlenA.*(pY1gA.*log2mine(pY1gA) + (pY0gA).*log2mine(pY0gA));
intpApYgAlpYgA = sum(integrandAYA);

% Calculate the Mutual Information:
%I(X;Y,A) = sumx(p(X) (int[p(A|X)log(p(A|X))] +
%int[p(A|X)sumy(p(Y|X,A)log(p(Y|X,A))))] - int[p(A)log(p(A))] +
%int[p(A)sumy(p(Y|A)log(p(Y|A)))];
mutualInfo = pXis0.*(intpAgXlpAgX0 + intpAgXlpYgAX0) +...
             pXis1.*(intpAgXlpAgX1 + intpAgXlpYgAX1) -...
             intpAlpA + intpApYgAlpYgA;
end









function mutualInfo = monteCarloComplicated(a,b,p0,numIts)
% with normal arrays the timeit is 2.3773s
% with GPU arrays the timeit is 142.2834s

XAY = zeros(numIts,3);
for i = 1:numIts
    XAY(i,:) = simulateChannel(a,b,p0);
end             % This loop takes 0.8s with 100k iterations
% rawXAY = XAY;
% Calculate X probabilities
Xzeros = XAY(:,1) == 0;
Xones = XAY(:,1) == 1;

pXis1 = sum(XAY(Xones,1))./numIts;
pXis0 = 1 - pXis1;

% Calculate the probabilies including A|X
% initialising = tic;




%%%% This is a new attempt
AgXzeros = XAY(Xzeros,2);
lenAgXzeros = length(AgXzeros);
[AlphagXzero,~,ic] = unique(AgXzeros,'stable');
AlphaMatches0 = accumarray(ic,1);
lenUnAgXzeros = length(AlphagXzero);
% pAgXis0logpAgXis0 = zeros(lenUnAgXzeros,1);
% pAgXis0pYgXAlogpYgXA = zeros(lenUnAgXzeros,1);


% Linear algebra version
% int [p(A|X)*log(p(A|X))]
pAgXis0 = AlphaMatches0./lenAgXzeros;
pAgXis0logpAgXis0 = pAgXis0.*log2mine(pAgXis0);
intpAgXis0LpAgXis0 = sum(pAgXis0logpAgXis0); %% step size missing? or is it in the pAgXis0 with the./lenAgXzeros?

% int [p(A|X)*(p(Y=0|X,A)*log(p(Y=0|X,A)) + p(Y=1|X,A)*log(p(Y=1|X,A)))]
pYis1gAX0 = zeros(lenUnAgXzeros,1);
for alpha = 1:lenUnAgXzeros
    positions = ismember(AlphagXzero(alpha),AgXzeros);
    YgAX0 = XAY(Xzeros(positions),3); %% This line might be wrong
    pYis1gAX0(alpha) = sum(YgAX0)./AlphaMatches0(alpha);
end
pYis0gAX0 = ones(lenUnAgXzeros,1)-pYis1gAX0;
pAgXis0pYgXAlogpYgXA = pAgXis0.*(pYis1gAX0.*log2mine(pYis1gAX0) + pYis0gAX0.*log2mine(pYis0gAX0));

intpAgXis0pYXA = sum(pAgXis0pYgXAlogpYgXA); %% step size missing?

% for alpha = 1:lenUnAgXzeros
%     alphacount = AlphaMatches0(alpha);
%     div = 1./alphacount;
%     % int [p(A|X)*log(p(A|X))]
%     pAgXis0 = alphacount./lenAgXzeros;
%     pAgXis0logpAgXis0(alpha) = pAgXis0.*log2mine(pAgXis0);
%     
%     % int [p(A|X)*(p(Y=0|X,A)*log(p(Y=0|X,A)) + p(Y=1|X,A)*log(p(Y=1|X,A)))]
%     positions = ismember(AlphagXzero(alpha),AgXzeros);
%     YgAX0 = XAY(Xzeros(positions),3); %% This line might be wrong
%     pYis1gAX0 = sum(YgAX0).*div;
%     pYis0gAX0 = 1-pYis1gAX0;
% 
%     pAgXis0pYgXAlogpYgXA(alpha) = pAgXis0.*(pYis1gAX0.*log2mine(pYis1gAX0) + pYis0gAX0.*log2mine(pYis0gAX0));
% end
% intpAgXis0LpAgXis0 = sum(pAgXis0logpAgXis0);
% intpAgXis0pYXA = sum(pAgXis0pYgXAlogpYgXA);

% AgXzeros = XAY(Xzeros,2);
% lenAgXzeros = length(AgXzeros);
% % AlphaMatches0 = cascadeZeros(triu(AgXzeros == AgXzeros'));
% pAgXis0logpAgXis0 = zeros(lenAgXzeros,1);
% pAgXis0pYgXAlogpYgXA = zeros(lenAgXzeros,1);
% % toc(initialising)
% for alpha = 1:lenAgXzeros
% %     int1 = tic;
%     alphacount = sum(AlphaMatches0(Alpha,:));
%     div = 1./alphacount;
%     % int [p(A|X)*log(p(A|X))]
%     pAgXis0 = alphacount./lenAgXzeros;
%     pAgXis0logpAgXis0(alpha) = pAgXis0.*log2mine(pAgXis0);
% %     toc(int1)
% 
%     % int [p(A|X)*(p(Y=0|X,A)*log(p(Y=0|X,A)) + p(Y=1|X,A)*log(p(Y=1|X,A)))]
% %     int2 = tic;
%     if alphacount ~= 0
%         %%%% New try
%         Y0gAX0 = XAY(Xzeros(AgXzeros(ic(alpha))),3) == 0;
%         Y1gAX0 = XAY(Xzeros(AgXzeros(ic(alpha))),3) == 1;
%        % Y0gAX0 = XAY(Xzeros(AlphaMatches0(alpha,:)),3) == 0;
%        % Y1gAX0 = XAY(Xzeros(AlphaMatches0(alpha,:)),3) == 1;
%         inter1 = sum(Y0gAX0).*div;
%         pYis0gAandX0 = inter1.*log2mine(inter1);
%         inter2 = sum(Y1gAX0).*div;
%         pYis1gAandX0 = inter2.*log2mine(inter2);
%     else
%         pYis0gAandX0(alpha) = 0;
%         pYis1gAandX0(alpha) = 0;
%     end
%     pAgXis0pYgXAlogpYgXA(alpha) = pAgXis0.*(pYis0gAandX0 + pYis1gAandX0);
% %     toc(int2)
% %     disp('\n')
% end
% % postanalysis = tic;
% intpAgXis0LpAgXis0 = sum(pAgXis0logpAgXis0);
% intpAgXis0pYXA = sum(pAgXis0pYgXAlogpYgXA);
% % toc(postanalysis)
% % toc

%%%% This is a new attempt
AgXones = XAY(Xones,2);
lenAgXones = length(AgXones);
[AlphagXone,~,ic] = unique(AgXones,'stable');
AlphaMatches1 = accumarray(ic,1);
lenUnAgXones = length(AlphagXone);
% pAgXis1logpAgXis1 = zeros(lenUnAgXones,1);
% pAgXis1pYgXAlogpYgXA = zeros(lenUnAgXones,1);

% Linear Algebra Version
% int [p(A|X)*log(p(A|X))]
pAgXis1 = AlphaMatches1./lenAgXones;
pAgXis1logpAgXis1 = pAgXis1.*log2mine(pAgXis1);
intpAgXis1LpAgXis1 = sum(pAgXis1logpAgXis1); %% step size missing?

% int [p(A|X)*(p(Y=0|X,A)*log(p(Y=0|X,A)) + p(Y=1|X,A)*log(p(Y=1|X,A)))]
pYis1gAX1 = zeros(lenUnAgXones,1);
for alpha = 1:lenUnAgXones
    positions = ismember(AlphagXone(alpha),AgXones);
    YgAX1 = XAY(Xones(positions),3); %% This line might be wrong
    pYis1gAX1(alpha) = sum(YgAX1)./AlphaMatches1(alpha);
end
pYis0gAX1 = ones(lenUnAgXones,1)-pYis1gAX1;
pAgXis1pYgXAlogpYgXA = pAgXis1.*(pYis1gAX1.*log2mine(pYis1gAX1) + pYis0gAX1.*log2mine(pYis0gAX1));

intpAgXis1pYXA = sum(pAgXis1pYgXAlogpYgXA); %% step size missing?

% for alpha = 1:lenUnAgXones
%     alphacount = AlphaMatches1(alpha);
%     div = 1./alphacount;
%     % int [p(A|X)*log(p(A|X))]
%     pAgXis1 = alphacount./lenAgXones;
%     pAgXis1logpAgXis1(alpha) = pAgXis1.*log2mine(pAgXis1);
%     
%     % int [p(A|X)*(p(Y=0|X,A)*log(p(Y=0|X,A)) + p(Y=1|X,A)*log(p(Y=1|X,A)))]
%     positions = ismember(AlphagXone(alpha),AgXones);
%     YgAX1 = XAY(Xones(positions),3); %% This line might be wrong
%     pYis1gAX1 = sum(YgAX1).*div;
%     pYis0gAX1 = 1-pYis1gAX1;
% 
%     pAgXis1pYgXAlogpYgXA(alpha) = pAgXis1.*(pYis1gAX1.*log2mine(pYis1gAX1) + pYis0gAX1.*log2mine(pYis0gAX1));
% end
% intpAgXis1LpAgXis1 = sum(pAgXis1logpAgXis1);
% intpAgXis1pYXA = sum(pAgXis1pYgXAlogpYgXA);



% AgXones = XAY(Xones,2);
% lenAgXones = length(AgXones);
% AlphaMatches1 = cascadeZeros(triu(AgXones == AgXones'));
% pAgXis1logpAgXis1 = zeros(lenAgXones,1);
% pAgXis0pYgXAlogpYgXA = zeros(lenAgXones,1);
% for alpha = 1:lenAgXones
%     alphacount = sum(AlphaMatches1(alpha,:));
%     div = 1./alphacount;
%     % int [p(A|X)*log(p(A|X))]
%     pAgXis1 = alphacount./lenAgXones;
%     pAgXis1logpAgXis1(alpha) = pAgXis1.*log2mine(pAgXis1);
% 
%     % int [p(A|X)*(p(Y=0|X,A)*log(p(Y=0|X,A)) + p(Y=1|X,A)*log(p(Y=1|X,A)))]
%     if alphacount ~= 0
%         Y0gAX1 = XAY(Xones(AlphaMatches1(alpha,:)),3) == 0;
%         Y1gAX1 = XAY(Xones(AlphaMatches1(alpha,:)),3) == 1;
%         inter1 = sum(Y0gAX1).*div;
%         pYis0gAandX1 = inter1.*log2mine(inter1);
%         inter2 = sum(Y1gAX1).*div;
%         pYis1gAandX1 = (inter2).*log2mine(inter2);
%     else
%         pYis0gAandX1 = 0;
%         pYis1gAandX1 = 0;
%     end
%     pAgXis0pYgXAlogpYgXA(alpha) = pAgXis1.*(pYis0gAandX1 + pYis1gAandX1);
% end
% intPAgXis1LpAgXis1 = sum(pAgXis1logpAgXis1);
% intpAgXis1pYXA = sum(pAgXis0pYgXAlogpYgXA);




% %% int [p(A|X)*(p(Y=0|X,A)*log(p(Y=0|X,A)) + p(Y=1|X,A)*log(p(Y=1|X,A)))]
% % This is a tough one and it might be wrong
% % pYis0gAandX0 = zeros(length(AgXzeros),1);
% % pYis1gAandX0 = zeros(length(AgXzeros),1);
% pAgXis0pYgXAlogpYgXA = zeros(lenAgXzeros,1);
% for alpha = 1:lenAgXzeros
%     alphacount = sum(AlphaMatches0(alpha,:));
%     if alphacount ~= 0
%         Y0gAX0 = XAY(Xzeros(AlphaMatches0(alpha,:)),3) == 0;
%         Y1gAX0 = XAY(Xzeros(AlphaMatches0(alpha,:)),3) == 1;
%         pYis0gAandX0 = (sum(Y0gAX0)./alphacount).*log2mine(sum(Y0gAX0)./alphacount);
%         pYis1gAandX0 = (sum(Y1gAX0)./alphacount).*log2mine(sum(Y1gAX0)./alphacount);
%     else
%         %% I have forgotten the factor of pAgX for all of these
%         pYis0gAandX0(alpha) = 0;
%         pYis1gAandX0(alpha) = 0;
%     end
%     pAgXis0pYgXAlogpYgXA(alpha) = pAgXis0(alpha).*(pYis0gAandX0 + pYis1gAandX0);
% end
% intpAgXis0pYXA = sum(pAgXis0pYgXAlogpYgXA);


% pYis0gAandX1 = zeros(length(AgXones),1);
% pYis1gAandX1 = zeros(length(AgXones),1);
% pAgXis0pYgXAlogpYgXA = zeros(lenAgXones,1);
% for alpha = 1:lenAgXones
%     alphacount = sum(AlphaMatches1(alpha,:));
%     if alphacount ~= 0
%         Y0gAX1 = XAY(Xones(AlphaMatches1(alpha,:)),3) == 0;
%         Y1gAX1 = XAY(Xones(AlphaMatches1(alpha,:)),3) == 1;
%         pYis0gAandX1 = (sum(Y0gAX1)./alphacount).*log2mine(sum(Y0gAX1)./alphacount);
%         pYis1gAandX1 = (sum(Y1gAX1)./alphacount).*log2mine(sum(Y1gAX1)./alphacount);
%     else
%         pYis0gAandX1 = 0;
%         pYis1gAandX1 = 0;
%     end
%     pAgXis0pYgXAlogpYgXA(alpha) = pAgXis1(alpha).*(pYis0gAandX1 + pYis1gAandX1);
% end
% intpAgXis1pYXA = sum(pAgXis0pYgXAlogpYgXA);

% Calculate the probabilities including p(A)
%%%% This is a new attempt

[As,~,ic] = unique(XAY(:,2),'stable');
Acounts = accumarray(ic,1);
lenUnA = length(As);
% pAlpA = zeros(lenUnA,1);
% pApYgA = zeros(lenUnA,1);

% Linear Algebra Version

pA = Acounts./numIts;
pAlpA = pA.*log2mine(pA);
intpALpA = sum(pAlpA); %% step size missing?

pYis1gA = zeros(lenUnA,1);
for alpha = 1:lenUnA
    positions = ismember(As(alpha),XAY(:,2));
    YgA = XAY(positions,3);
    pYis1gA(alpha) = sum(YgA)./Acounts(alpha);
end
pYis0gA = ones(lenUnA,1)-pYis1gA;
pApYgA = pA.*(pYis0gA.*log2mine(pYis0gA) + pYis1gA.*log2mine(pYis1gA));
intpApYgALpYgA = sum(pApYgA); %% step size missing?


% for alpha = 1:lenUnA
%     % int [p(A)log(p(A))]
%     alphacount = Acounts(alpha);
%     pA = alphacount./numIts;
%     pAlpA(alpha) = pA.*log2mine(pA);
% 
%     % int [p(A)*(p(Y=1|A)*log(p(Y=1|A)) + p(Y=0|A)*log(p(Y=0|A)))]
%     div = 1./alphacount;
%     positions = ismember(As(alpha),XAY(:,2));
%     YgA = XAY(positions,3);
%     pYis1gA = sum(YgA).*div;
%     pYis0gA = 1 - pYis1gA;
%     pApYgA(alpha) = pA.*(pYis0gA.*log2mine(pYis0gA) + pYis1gA.*log2mine(pYis1gA));
% end
% intpALpA = sum(pAlpA);
% intpApYgALpYgA = sum(pApYgA);



% AMatches = cascadeZeros(triu(XAY(:,2) == XAY(:,2)'));
% pA = zeros(numIts,1);
% pApYgA = zeros(numIts,1);
% for alpha = 1:numIts
%     % int [p(A)log(p(A))]
%     intermediary = sum(AMatches(alpha,:))./numIts;
%     pA(alpha) = intermediary.*log2mine(intermediary);
% 
%     % int [p(A)*(p(Y=1|A)*log(p(Y=1|A)) + p(Y=0|A)*log(p(Y=0|A)))]
%     alphacount = sum(AMatches(alpha,:));
%     div = 1./alphacount;
%     if alphacount ~= 0
%         Y0gA = XAY(AMatches(alpha,:),3) == 0;
%         Y1gA = XAY(AMatches(alpha,:),3) == 1;
%         inter1 = sum(Y0gA).*div;
%         pYis0gA = (inter1).*log2mine(inter1);
%         inter2 = sum(Y1gA).*div;
%         pYis1gA = (inter2).*log2mine(inter2);
%     else
%         pYis0gA = 0;
%         pYis1gA = 0;
%     end
%     pApYgA(alpha) = pA(alpha).*(pYis0gA + pYis1gA);
% end
% intPALpA = sum(pA);
% intPApYgALpYgA = sum(pApYgA);
% 
% 


% %% int [p(A)*(p(Y=1|A)*log(p(Y=1|A)) + p(Y=0|A)*log(p(Y=0|A)))]
% pApYgA = zeros(numIts,1);
% for alpha = 1:numIts
%     alphacount = sum(AMatches(alpha,:));
%     if alphacount ~= 0
%         Y0gA = XAY(AMatches(alpha,:),3) == 0;
%         Y1gA = XAY(AMatches(alpha,:),3) == 1;
%         pYis0gA = (sum(Y0gA)./alphacount).*log2mine(sum(Y0gA)./alphacount);
%         pYis1gA = (sum(Y1gA)./alphacount).*log2mine(sum(Y1gA)./alphacount);
%     else
%         pYis0gA = 0;
%         pYis1gA = 0;
%     end
%     pApYgA(alpha) = pA(alpha).*(pYis0gA + pYis1gA);
% end
% intPApYgALpYgA = sum(pApYgA);

% Calculate the Mutual Information:
%I(X;Y,A) = sumx(p(X) (int[p(A|X)log(p(A|X))] +
%int[p(A|X)sumy(p(Y|X,A)log(p(Y|X,A))))] - int[p(A)log(p(A))] +
%int[p(A)sumy(p(Y|A)log(p(Y|A)))];
mutualInfo = pXis0.*(intpAgXis0LpAgXis0 + intpAgXis0pYXA) +...
             pXis1.*(intpAgXis1LpAgXis1 + intpAgXis1pYXA) -...
             intpALpA + intpApYgALpYgA;
end





function XAY = simulateChannel(a,b,p0)

samplex = rand;
sampley = rand;

if samplex < p0
    X = 0;
    alpha = round(betarnd(a,b),4);
else
    X = 1;
    alpha = round(betarnd(b,a),4);
end

if sampley < alpha
    Y = 1-X;
else
    Y = X;
end

XAY = [X;alpha;Y];
end


function output = log2mine(x)
    rawlog = log2(x);
    output = zeros(length(x),1);
    notInf = ~isinf(rawlog);
    output(notInf) = rawlog(notInf);
end