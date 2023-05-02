%% Beta Distribution for e0 and e1
resolution = 10;
a = 1:10;
b = 1:10;
constant = zeros(10);
epsilon0 = linspace(0,1,resolution);
pdfe0 = zeros(10);
for i = 2:resolution
    pdfe0 = cat(3,pdfe0,zeros(10));
end
pdfe1 = pdfe0;
for i = 1:10
    for j = 1:10
    constant(i,j) = gamma(a(i)+b(j))/(gamma(a(i))*gamma(b(j)));
    if isnan(constant(i,j))
        constant(i,j) = 0;
    end
        for e0 = 1:resolution
            pdfe0(i,j,e0) = constant(i,j)*epsilon0(e0).^(a(i)-1)*(1-epsilon0(e0)).^(b(j)-1);
            pdfe1(i,j,e0) =  constant(i,j)*(1-epsilon0(e0)).^(a(i)-1)*epsilon0(e0).^(b(j)-1);
            
        end
    end
end

figure(1)
for i = 1:10
    for j = 1:10
        e0line = squeeze(pdfe0(i,j,:));
        e1line = squeeze(pdfe1(i,j,:));
        plot(epsilon0,e0line,epsilon0,e0line)
        title(sprintf('at shape parameter values a = %f and b = %f',a(i),b(j)))
        xlabel('values of epsilon0')
        ylabel('p(e0<=epsilon0)')
        legend('pdf(e0,a,b)','pdf(e1,a,b)')
        drawnow
        pause(0.1)
    end
end
