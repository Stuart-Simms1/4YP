%% Binary Symmetric Channel with Beta Distributed Alpha
% Maximising I(X;Y|alpha) over a and b assuming X is uniformly distributed
% a are the rows, b are the columns
size = 2;
mx = 100;
HYgivenAlpha = zeros(mx*size);
HYgivenXandAlpha = zeros(mx*size);
IXandYgivenAlpha = zeros(mx*size);
vec = 1/size:1/size:mx + 1/size;
for a = vec
    for b = vec
        % Entropy of relevant stuff
%         Hya = @(alpha) -(alpha.^a-1).*(1-alpha).^(b-1)./(beta(a,b)); 
%         HYgivenAlpha(round(size*a),round(size*b)) = integral(Hya,0,1);
        Hyxa = @(alpha) ((alpha.^a).*(1-alpha).^(b-1)).*...
            (-alpha.*log2(alpha)-(1-alpha).*log2(1-alpha))./beta(a,b);
        HYgivenXandAlpha(round(size*a),round(size*b)) = integral(Hyxa,0,1);
        
        % Mutual Information
%         IXandYgivenAlpha(round(size*a),round(size*b)) = ...
%             HYgivenAlpha(round(size*a),round(size*b)) -...
%             HYgivenXandAlpha(round(size*a),round(size*b));
    IXandYgivenAlpha(round(size*a),round(size*b)) = 1 - HYgivenXandAlpha(round(size*a),round(size*b));
    end
end
%% Plotting results
surf(vec,vec,IXandYgivenAlpha)
xlabel('a')
ylabel('b')
[M,I] = max(IXandYgivenAlpha,[],'all')