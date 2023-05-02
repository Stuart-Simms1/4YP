%% Visualisation
clear all
close all

numPoints = 100;

% dist.pXis0 = 0.5;
% dist.pXis1 = 1-dist.pXis0;
% % dist.num = 1;
% % dist.d = 0.1;
% dist.num = 2;
% dist.d1 = 0.1;
% dist.d2 = 0.5;
% 
% epsilon0 = linspace(0,1,numPoints);
% epsilon1 = linspace(0,1,numPoints);

% %% Investigating I(X;Y,A) in total
% MI = zeros(numPoints);
% for e0 = 1:numPoints
%     for e1 = 1:numPoints
%         dist = assign_probabilities(dist,epsilon0(e0),epsilon1(e1));
%         MI(e0,e1) = mutual_information(dist);
%     end
% end
% 
% surf(epsilon0,epsilon1,MI)

% %% Investigating I(X;A) alone
% IXandA = zeros(numPoints);
% for e0 = 1:numPoints
%     for e1 = 1:numPoints
%         dist = assign_probabilities(dist,epsilon0(e0),epsilon1(e1));
%         IXandA(e0,e1) = IXA(dist);
%     end
% end
% 
% surf(epsilon0,epsilon1,IXandA)
% writematrix(IXandA)
% 
% function I = IXA(dist)
%     P = dist.Probabilities;
%     I = -xlogx(P(1,2))-xlogx(P(3,2))...
%     +P(1,1)*(xlogx(P(1,5))+xlogx(P(3,5)))...
%     +P(5,1)*(xlogx(P(5,5))+xlogx(P(7,5)));
% end

% %% Investigating distribution 2 and the effects of changing d1 and d2
% numInvestigations = 100;
% dist.pXis0 = 0.5;
% dist.pXis1 = 1-dist.pXis0;
% 
% d1 = linspace(0,1,numInvestigations);
% d2 = linspace(0,1,numInvestigations);
% dist.num = 2;
% % e0 = 0.1;
% % e1 = 1-e0;
% % E0 = linspace(0,1,5);
% % E1 = 0.5*ones(length(E0),1);
% E0 = [0.1;0.4;0.6;0.9];
% E1 = 0.5*ones(length(E0),1);
% MI = zeros(numInvestigations);
% for e = 1:length(E0)
%     for i = 1:numInvestigations
%         for j = 1:numInvestigations
%             dist.d1 = d1(i);
%             dist.d2 = d2(j);
%             dist = assign_probabilities(dist,E0(e),E1(e));
%             MI(i,j) = mutual_information(dist);
%         end
%     end
% %     figure(1)
% %     surf(d1,d2,MI,'EdgeColor','none')
% %     title(sprintf('Dist 2 with \x03F5\x2080 = %g and \x03F5\x2081 = %g',E0(e),E1(e)))
% %     xlabel('d1')
% %     ylabel('d2')
% %     zlabel('I(X;Y,A)')
% %     axis([0;1;0;1;0;1])
% % 
% %     figure(2)
% %     plot(d1,diag(MI))
% %     title(sprintf('I(X;Y,A) along the line d1 = d2, \x03F5\x2080 = %g, \x03F5\x2081 = %g',E0(e),E1(e)))
% %     xlabel('d1 = d2')
% %     ylabel('I(X;Y,A)')
% %     axis([0;1;0;1])
% %     drawnow
% %     pause(0.25)
% 
%     figure(2*e-1)
%     surf(d1,d2,MI,'EdgeColor','none')
%     title(sprintf('Dist 2 with \x03F5\x2080 = %g and \x03F5\x2081 = %g',E0(e),E1(e)))
%     xlabel('d2')
%     ylabel('d1')
%     zlabel('I(X;Y,A)')
%     axis([0;1;0;1;0;1])
%     
%     d1minusd2line = diag(fliplr(MI));
%     figure(2*e)
%     plot(d2,d1minusd2line)
%     title(sprintf('I(X;Y,A) along the line d1 = 1 - d2, \x03F5\x2080 = %g, \x03F5\x2081 = %g',E0(e),E1(e)))
%     xlabel('d1 = 1 - d2')
%     ylabel('I(X;Y,A)')
%     axis([0;1;0;1])
% end

% %% Investigating changing the input distribution
% numInvestigations = 100;
% dist.num = 2;
% 
% d1 = linspace(0,1,numInvestigations);
% d2 = linspace(0,1,numInvestigations);
% 
% p0 = [0.1;0.25;0.5;0.75];
% % e0 = 0.1;
% % e1 = 1-e0;
% e0 = 0.9;
% e1 = 0.1;
% MI = zeros(numInvestigations);
% for p = 1:length(p0)
%     dist.pXis0 = p0(p);
%     dist.pXis1 = 1-dist.pXis0;
%     for i = 1:numInvestigations
%         for j = 1:numInvestigations
%             dist.d1 = d1(i);
%             dist.d2 = d2(j);
%             dist = assign_probabilities(dist,e0,e1);
%             MI(i,j) = mutual_information(dist);
%         end
%     end
%     figure(1)
%     surf(d1,d2,MI,'EdgeColor','none')
%     title(sprintf('Dist 2 p0 = %g with \x03F5\x2080 = %g and \x03F5\x2081 = %g',p0(p),e0,e1))
%     xlabel('d1')
%     ylabel('d2')
%     zlabel('I(X;Y,A)')
% %     axis([0;1;0;1;0;1])
%     d1minusd2line = diag(fliplr(MI));
%     figure(2)
%     plot(d1,d1minusd2line)
%     title(sprintf('I(X;Y,A) for p0 = %g along the line d1 = 1 - d2, \x03F5\x2080 = %g, \x03F5\x2081 = %g',p0(p),e0,e1))
%     xlabel('d1 = 1 - d2')
%     ylabel('I(X;Y,A)')
%     axis([0;1;0;1])
%     drawnow
%     pause(0.25)

%     figure(2*p-1)
%     surf(d1,d2,MI,'EdgeColor','none')
%     title(sprintf('Dist 2 p0 = %g with \x03F5\x2080 = %g and \x03F5\x2081 = %g',p0(p),e0,e1))
%     xlabel('d1')
%     ylabel('d2')
%     zlabel('I(X;Y,A)')
%     axis([0;1;0;1;0;1])
    d1minusd2line = diag(fliplr(MI));
    figure(p)
    plot(d1,d1minusd2line)
    title(sprintf('I(X;Y,A) for p0 = %g along the line d1 = 1 - d2, \x03F5\x2080 = %g, \x03F5\x2081 = %g',p0(p),e0,e1))
    xlabel('d1 = 1 - d2')
    ylabel('I(X;Y,A)')
    axis([0;1;0;1])
end

% %% Investigating the Z channel
% 
% I = @(a,x) 1 + x.*(a.*log2mine(a)+(1-a).*log2mine(1-a));
% IdealP = @(a) 1./((1-a).*(1 + 2.^((a.*log2mine(a)+(1-a).*log2mine(1-a)))./(1-a)));
% a = linspace(0,1,100);
% x = linspace(0,1,100);
% MI = zeros(100);
% IdealProb = zeros(100,1);
% for i = 1:100
%     for j = 1:100
%         MI(i,j) = I(a(i),x(j));
%     end
%     IdealProb(i) = IdealP(a(i));
% end
% surf(a,x,MI)
% xlabel('a')
% ylabel('x')
% hold on
% plot3(a,ones(length(a),1),IdealProb)
% 
% 
% function output = log2mine(x)
%     if x  == 0 
%         output = 0;
%     else
%         if isinf(x)
%             output = 0;
%         else
%             output = log2(x);
%         end
%     end
% end
