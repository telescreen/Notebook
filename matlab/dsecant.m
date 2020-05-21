function Root = dsecant(func, xr, delta, maxiter, eps)
% Calculate root of func using modified secant algorithm
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
    xr = oldxr - delta*foldxr/(func(oldxr + delta) - foldxr);
    if xr ~= 0
        ea = abs((xr - oldxr)/xr);
    end
    if iter > maxiter || ea < eps
        break;
    end
end
Root = xr;
end