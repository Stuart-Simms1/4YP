%% finding the values for the uncoupled case mutual information

% example function
% x(1) = alpha
% x(2) = a
% x(3) = b
fun = @(x) x(1).^(x(2)-1).*(1-x(1)).^(x(3)-1) + x(1).^(x(3)-1).*(1-x(1)).^(x(2)-1) - 2.*beta(x(2),x(3));
opts = optimoptions('fsolve','Algorithm','Levenberg-Marquardt');
sol = fsolve(fun,[0.2 2 3],opts)
test = fun(sol);