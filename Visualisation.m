%% Visualising the results
clear all
close all
clc
option = 'low';
% option = 'high';
numLines = 3;

if strcmp(option,'high')
    A = logspace(0,2,100);
    B = A;
    Info = readmatrix("IXYgAhighShapeParams(logspace(0,2,100)).txt");

    indices = floor(linspace(1,100,numLines));
    for lineb = 1:numLines
        labelsfixedb(lineb) = string(sprintf('b \x2248 %d',round(B(indices(lineb)))));
        LinesfixedbY(lineb,:) = Info(indices(lineb),:);
    end
    figure(1)
    for i = 1:numLines
        plot(A,LinesfixedbY(i,:));
        xlabel('shape parameter a')
        ylabel('I(X;Y|A)')
        hold on
    end
    title('I(X;Y|A) with fixed shape parameter b')
    legend(labelsfixedb,"Location","north")


    for linea = 1:numLines
        labelsfixeda(linea) = string(sprintf('a \x2248 %d',round(A(indices(linea)))));
        LinesfixedaY(:,linea) = Info(:,indices(linea));
    end
    figure(2)
    for j = 1:numLines
        plot(A,LinesfixedaY(:,j));
        xlabel('shape parameter b')
        ylabel('I(X;Y|A)')
        hold on
    end
    title('I(X;Y|A) with fixed shape parameter a')
    legend(labelsfixeda,"Location","north")

else
    A = logspace(-2,0,100);
    B = A;
    Info = readmatrix("IXYgAlowShapeParams(logspace(-2,0,100).txt");
    
    indices = floor(linspace(1,100,numLines));
    for lineb = 1:numLines
        labelsfixedb(lineb) = string(sprintf('b \x2248 %0.2f',round(B(indices(lineb)),2)));
        LinesfixedbY(lineb,:) = Info(indices(lineb),:);
    end
    figure(1)
    for i = 1:numLines
        plot(A,LinesfixedbY(i,:));
        xlabel('shape parameter a')
        ylabel('I(X;Y|A)')
        hold on
    end
    title('I(X;Y|A) with fixed shape parameter b')
    legend(labelsfixedb,"Location","north")

    for linea = 1:numLines
        labelsfixeda(linea) = string(sprintf('a \x2248 %0.2f',round(A(indices(linea)),2)));
        LinesfixedaY(:,linea) = Info(:,indices(linea));
    end
    figure(2)
    for j = 1:numLines
        plot(A,LinesfixedaY(:,j));
        xlabel('shape parameter b')
        ylabel('I(X;Y|A)')
        hold on
    end
    title('I(X;Y|A) with fixed shape parameter a')
    legend(labelsfixeda,"Location","north")
end
