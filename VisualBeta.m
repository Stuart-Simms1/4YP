%% Visualising stuff

X = linspace(0,1,100);
numlines = 5;
A = logspace(-1,1,numlines);
B = A;
linesAB = zeros(100,4,numlines);
linesBA = zeros(100,4,numlines);
for a = 1:length(A)
    for b = 1:length(B)
        div = 1./beta(A(a),B(b));
        linesAB(:,a,b) = X.^(A(a)-1).*(1-X).^(B(b)-1).*div;
        linesBA(:,a,b) = X.^(B(b)-1).*(1-X).^(B(b)-1).*div;
    end
end

figure(1)
for i = 1:numlines
lineAB1 = squeeze(linesAB(:,:,i));
for j = 1:numlines
    plot3(X,A(j)*ones(100,1),lineAB1(:,j));
    set(gca, 'YScale', 'log')
    hold on
    axis([0;1;10^-1;10;0;10])
    xlabel('Beta Distributed Variable')
    ylabel('Shape parameter a')
    zlabel('pdf')
end
end