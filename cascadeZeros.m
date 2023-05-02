%% function to make the rest of a column 0 after a 1 is found
clear all
size = 10000;
X = triu(randi([0,1],size));
Y = cascadezeros(X);


function outputMatrix = cascadezeros(inputMatrix)
tic
outputMatrix = inputMatrix;
for row = 1:size(inputMatrix,1)
    colsleft  = sum(outputMatrix(row,:));
    if  colsleft > 1
        while colsleft > 1
        column = min(find(outputMatrix(row,:),colsleft-1,'last'));
        outputMatrix(row+1:end,column) = 0;
        colsleft = colsleft - 1;
        end
    end
end
toc
end


function Matrix = cascadeZeros(Matrix)
tic
sidelength = size(Matrix,1);
for row = 1:sidelength
    nonZeroElements = find(Matrix(row,row+1:end),sidelength,"first");
    if isempty(nonZeroElements)
        continue
    else
        for column = 1:length(nonZeroElements)
            Matrix(row+1:end,nonZeroElements(column)) = 0;
        end
    end
end
toc
end % Takes 2.59 seconds for 100000 side length matrix