%% Binary Asymetric Channel with Beta Distributed Alpha, Beta
% Maximising I(X;Y|alpha,beta) over a and b assuming X is uniformly distributed
%a are the rows, b are the columns
size = 3;
mx = 1;
HYgivenAlphaandBeta = zeros(mx*size);
HYgivenXandAlphaandBeta = zeros(mx*size);
IXandYgivenAlphaandBeta = zeros(mx*size);
vec = 1/size:1/size:mx + 1/size;


for a1 = vec

    for b1 = vec

        for a2 = vec

            for b2 = vec
%         % Entropy of relevant stuff
%         Hyab = @(alpha,be) alpha.^(a1-1).*(1-alpha).^(b1-1).* ...
%             (be.^(a2-1).*(1-be).^(b2-1)).* ...
%             ((alpha+1-be).*log2((alpha+1-be)./2) + ...
%             (be+1-alpha).*log2((be+1-alpha)./2))./...
%             (2.*beta(a1,b1).*beta(a2,b2));
% 
%         HYgivenAlphaandBeta(round(size*a1),round(size*b1),round(size*a2),round(size*b2)) = integral2(Hyab,0,1,0,1,'RelTol', 1e-4, 'AbsTol', 1e-6);

        Hyxab = @(alpha,be) (alpha.^(a1-1)).*(1-alpha).^(b1-1).*...
            be.^(a2-1).*(1-be).^(b2-1).* ...
            ((-alpha.*log2(alpha)-(1-alpha).*log2(1-alpha)) + ...
            (-be.*log2(be)-(1-be).*log2(1-be)))./...
            (4.*beta(a1,b1).*beta(a2,b2));
        
        HYgivenXandAlphaandBeta(round(size*a1),round(size*b1),round(size*a2),round(size*b2)) = integral2(Hyxab,0,1,0,1,'RelTol', 1e-4, 'AbsTol', 1e-6);
        
%         % Mutual Information
%         IXandYgivenAlphaandBeta(round(size*a1),round(size*b1),round(size*a2),round(size*b2)) = ...
%             HYgivenAlphaandBeta(round(size*a1),round(size*b1),round(size*a2),round(size*b2)) -...
%             HYgivenXandAlphaandBeta(round(size*a1),round(size*b1),round(size*a2),round(size*b2));

        IXandYgivenAlphaandBeta(round(size*a1),round(size*b1),round(size*a2),round(size*b2)) = ...
            1 - HYgivenXandAlphaandBeta(round(size*a1),round(size*b1),round(size*a2),round(size*b2));
            end
        end
    end
end
%% Plotting results
Alpha = squeeze(IXandYgivenAlphaandBeta(:,:,2,2));
Be = squeeze(IXandYgivenAlphaandBeta(1,1,:,:));
figure(1)
surf(vec,vec,Alpha)
title('Alpha with fixed beta')
xlabel('a for alpha')
ylabel('b for alpha')

figure(2)
surf(vec,vec,Be)
title('Beta with fixed Alpha')
xlabel('a for Beta')
ylabel('b for Beta')

[M,I] = max(IXandYgivenAlphaandBeta,[],'all')