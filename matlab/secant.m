function Root = secant(func, x0, xr, maxiter, eps)
% Calculate root of func using secant algorithm
% written: me (2016/09/23)
if ~exist('eps', 'var') || isempty(eps)
    % 3 significant digits 0.5*10e(2-n)%
    eps = 0.5e-3;
end
if ~exist('maxiter', 'var') || isempty(maxiter)
    maxiter = 500;
end
iter = 0;
while true
    iter = iter + 1;
    oldxr = xr;    
    foldxr = func(oldxr);
    xr = oldxr - foldxr*(x0 - oldxr)/(func(x0) - foldxr);
    x0 = oldxr;
    if xr ~= 0
        ea = abs((xr - oldxr)/xr);
    end
    if ea < eps || iter > maxiter
        break;
    end
end
Root = xr;
end