%% This function reads in a information surface from my files
function [Info,dist] = readSurface(dist,PC)

if dist.num == 1
    if isfield(dist,'d') == 0
        dist.d = rand();
    end
    % convert d into a string of the right form
    strd = num2str(dist.d);
    strd(2) = ",";
    if strlength(strd) < 4
        strd(end+1:4) = '0';
    end

    identifier = sprintf("dist_1,d=%s",strd(1:4));
    if PC ==1
        Info = readmatrix("C:\Surfaces\dist1\" + identifier + ".txt");
    else
        Info = readmatrix(identifier + ".txt");
    end
end
if dist.num == 2
    
    if isfield(dist,"d1") == 0
        dist.d1 = rand();
    end

    strd1 = num2str(dist.d1);
    strd1(2) = ",";
    if strlength(strd1) < 4
        strd1(end+1:4) = '0';
    end

    if isfield(dist,"d2") == 0
        dist.d2 = rand();
    end

    strd2 = num2str(dist.d2);
    strd2(2) = ",";
    if strlength(strd2) < 4
        strd2(end+1:4) = '0';
    end
    
    identifier = sprintf("dist_2,d1=%s_&_d2=%s",strd1(1:4),strd2(1:4));
    
    if PC ==1
        Info = readmatrix("C:\Surfaces\dist2\" + identifier + ".txt");
    else
        Info = readmatrix(identifier + ".txt");
    end
end

end