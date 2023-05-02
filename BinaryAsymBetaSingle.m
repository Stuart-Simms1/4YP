%% Binary Asymetric Channel with Beta Distributed Alpha, fixed Beta = 0.25
% Maximising I(X;Y|alpha,beta) over a and b assuming X is uniformly distributed
%a are the rows, b are the columns
be = 0.25;
Hb = -be.*log2(be)-(1-be).*log2(1-be);
size = 2;
mx = 100;
HYgivenAlphaandBeta = zeros(mx*size);
HYgivenXandAlphaandBeta = zeros(mx*size);
IXandYgivenAlphaandBeta = zeros(mx*size);
vec = 1/size:1/size:mx + 1/size;
for a = vec
    for b = vec
%         % Entropy of relevant stuff
%         Hyab = @(alpha) -(alpha.^(a-1).*(1-alpha).^(b-1).* ...
%             ((alpha+1-be).*log2((alpha+1-be)./2) + ...
%             (be+1-alpha).*log2((be+1-alpha)./2) ))./...
%             (2.*(beta(a,b)));
% 
%         HYgivenAlphaandBeta(round(size*a),round(size*b)) = integral(Hyab,0,1,'RelTol', 1e-4, 'AbsTol', 1e-6);

        Hyxab = @(alpha) ((alpha.^(a-1)).*(1-alpha).^(b-1)).*...
            ((-alpha.*log2(alpha)-(1-alpha).*log2(1-alpha)) + ...
            Hb)./...
            (2.*(beta(a,b)));
        
        HYgivenXandAlphaandBeta(round(size*a),round(size*b)) = integral(Hyxab,0,1,'RelTol', 1e-4, 'AbsTol', 1e-6);
        
        
        % Mutual Information
%         IXandYgivenAlphaandBeta(round(size*a),round(size*b)) = ...
%             HYgivenAlphaandBeta(round(size*a),round(size*b)) -...
%             HYgivenXandAlphaandBeta(round(size*a),round(size*b));
        IXandYgivenAlphaandBeta(round(size*a),round(size*b)) = 1 - HYgivenXandAlphaandBeta(round(size*a),round(size*b));
    end
end
%% Plotting results
surf(vec,vec,IXandYgivenAlphaandBeta)
xlabel('a')
ylabel('b')
[M,I] = max(IXandYgivenAlphaandBeta,[],'all')