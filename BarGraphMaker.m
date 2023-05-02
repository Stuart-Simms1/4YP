%This program will make a bar graph comparing the mutual information of the
%coupled case agiasnt the uncoupled case with H(Y) = 1.
clear all
%% declaring variables
dist.num = 1;
dist.d = 0.1;
numplots = 2;
% ep0 = 0.19;
% ep1 = 0.81;
ep0 = rand(numplots,1);
ep1 = rand(numplots,1);
for i = 1:numplots
    dist = declareDist(dist,ep0(i),ep1(i));
    if dist.num == 1
        hY = 1;
        hYX = -xlogx(dist.d)-xlogx(1-dist.d);
        uncoupledInfo = hY-hYX;
    end
    
    IXA = Ixa(dist);
    IXYGivenA = Ixygivena(dist);
    Info = Ixya(dist);
    
    subplot(numplots,1,i)
    Bars = [uncoupledInfo, 0; IXYGivenA, IXA; Info, 0];
    titles = categorical({'I(X;Y)','I(X;Y,A)','Info'});
    titles = reordercats(titles,{'I(X;Y)','I(X;Y,A)','Info'});
    bar(titles, Bars, 'stacked')
    hold on
end


% if dist.num == 2
%     hY=1;
%     hYX = ;
%     uncoupledInfo = hY-hYX;
% end