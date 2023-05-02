%% Generates all the surfaces plots of coupled Mutual Information for both 
% the first and second distributions, and saves them as a text file.
% the resolution will be 100x100 for the e0 and e1 values, for each d value.
% all will be uniformly distributed X

clear
close all

%% for Distribution 1: 100 text files
resolution = 100;
dist.num = 1;
for d = 1:(resolution+1)
    % declare Variables
    dist.d = (d-1)/100;    %transition probability delta
    ep0 = linspace(0,1,resolution); %test for a range of ep0 from 0 to 1
    ep1 = linspace(0,1,resolution); %test for a range of ep1 from 0 to 1
    Info = zeros(resolution);
    
    for i = 1:resolution
        e0 = ep0(i);
        for j = 1:resolution
            e1 = ep1(j);
            %Defining the distribution probabilities
            dist = declareDist(dist,e0,e1);
    
            Info(i,j) = Ixya(dist);  %compute the mutual information for these e0,e1.
        end
    end
    if d ~= 101
        text = sprintf('dist_1,d=0,%02d',round(resolution*dist.d));
    else
        text = sprintf('dist_1,d=1,00');
    end
    writematrix(Info,"Surfaces/dist1/" + text + ".txt")
end
fprintf('Finished Distribution 1 \n')
%% for the second distribution
resolution = 100;
dist.num = 2;
for d1 = 1:(resolution+1)
    dist.d1 = (d1-1)/resolution;
    for d2 = 1:(resolution+1)
        dist.d2 = (d2-1)/resolution;

        ep0 = linspace(0,1,resolution); %test for a range of ep0 from 0 to 1
        ep1 = linspace(0,1,resolution); %test for a range of ep1 from 0 to 1
        Info = zeros(resolution);
        
        for i = 1:resolution
            e0 = ep0(i);
            for j = 1:resolution
                e1 = ep1(j);
                %Defining the distribution probabilities
                dist = declareDist(dist,e0,e1);
        
                Info(i,j) = Ixya(dist);  %compute the mutual information for these e0,e1.
            end
        end
        if d1 ~= 101 && d2 ~= 101
        text = sprintf('dist_2,d1=0,%02d_&_d2=0,%02d',round(resolution*dist.d1),round(resolution*dist.d2));
        else
            if d1 ~= 101
                text = sprintf('dist_2,d1=0,%02d_&_d2=1,00',round(resolution*dist.d1));
            else
                if d2 ~= 101
                    text = sprintf('dist_2,d1=1,00_&_d2=0,%02d',round(resolution*dist.d2));
                else
                    text = sprintf('dist_2,d1=1,00_&_d2=1,00');
                end
            end
        end
        writematrix(Info,"Surfaces/dist2/" + text + ".txt")
    end
    fprintf('Distribution 2 is %d percent finished \n',d1)
end



