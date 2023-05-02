%% Uncoupled Visualisations
clear all
close all
clc

numPoints = 100;
dist.pXis0 = 0.5;
dist.pXis1 = 1-dist.pXis0;

%% Distribution 1
dist.num = 1;
d = 0.22;

for i = 1:length(d)
    dist.d = d(i);
    epsilon0 = linspace(0,1,numPoints);
    epsilon1 = linspace(0,1,numPoints);
    MI = zeros(numPoints);
    for e0 = 1:numPoints
        for e1 = 1:numPoints
            dist = assign_probabilities(dist,epsilon0(e0),epsilon1(e1));
            MI(e0,e1) = mutual_information(dist);
        end
    end
    coupledTheoryLine(i,:) = diag(fliplr(MI));
    
    % Find the Uncoupled case line
    numIterations = 1000000;
    option = 1;
    uncoupledLine(i,:) = ones(numPoints,1)*uncoupledInfo(numIterations,dist,option);
    
%     if dist.num == 1
%         label1 = sprintf('Dist 1, d = %g',dist.d);
%     else
%         label1 = sprintf('Dist 2, d1 = %g, d2 = %g',dist.d1,dist.d2);
%     end
%     %% Plot results
%     figure(i)
%     plot(epsilon0,coupledTheoryLine,epsilon0,uncoupledLine)%,epsilon0,ZInfo)%,epsilon0,simulatedLine,'r--o')
%     txt = sprintf('I(X;Y,A) vs \x03F5\x2080 Showing Uncoupled Line');
%     title(txt)
%     xlabel(sprintf('\x03F5\x2080 = 1 - \x03F5\x2081'))
%     ylabel('I(X;Y,A)')
%     legend(label1,'Uncoupled Case')%,'Z Case')%,'Simulation')
end
% figure(1)
% labels = strings(2*length(d),1);
% for i = 1:length(d)
%     plot(epsilon0,coupledTheoryLine(i,:),epsilon0,uncoupledLine(i,:))
%     labels(i) = [sprintf('Dist 1, d = %g',d(i)),''];
%     hold on
%     drawnow
%     pause(0.25)
% end
% txt = sprintf('I(X;Y,A) vs \x03F5\x2080 Showing Uncoupled Line');
% title(txt)
% xlabel(sprintf('\x03F5\x2080 = 1 - \x03F5\x2081'))
% ylabel('I(X;Y,A)')
% legend(labels,"Location","best",Orientation="horizontal",NumColumns=3)
% axis([0;1;0;1])

for i = 1:length(d)
    figure(1)
    plot(epsilon0,coupledTheoryLine(i,:),epsilon0,uncoupledLine(i,:))
    label1 = sprintf('Dist 1, d = %g',d(i));
    label2 = sprintf('Uncoupled d = %g',d(i));
    txt = sprintf('I(X;Y,A) for Distribution 1 (0, %g) vs \x03F5\x2080 Showing Uncoupled Line',d(i));
    title(txt)
    xlabel(sprintf('\x03F5\x2080 = 1 - \x03F5\x2081'))
    ylabel('I(X;Y,A)')
    legend(label1,label2,Location="best")
    axis([0;1;0;1])
    drawnow
    pause(0.25)
end

% for i = 1:length(d)
% minMI = min(coupledTheoryLine(i,:));
% minUnc = min(uncoupledLine(i,:));
% if minMI >= minUnc
%     txt = sprintf('Coupled case always bigger at d = %g',d(i));
% else
%     txt = sprintf('Uncoupled case always bigger at d = %g',d(i));
% end
% disp(txt)
% end

% %% Distribution 2
