function xr = polyroot_muller(func, xr, h, eps, maxiter)
% POLYROOT_MULLER: 
%    Calculate the root of polynomial func using Muller algorithm
% 
% Written by: me (2016/09/25)

if ~exist('eps', 'var') || isempty(eps)
    % 3 significant digits 0.5*10e(2-n)%
    eps = 0.5e-3;
end
if ~exist('maxiter', 'var') || isempty(maxiter)
    maxiter = 500;
end

x2 = xr;
x1 = xr+h*xr;
x0 = xr-h*xr;
iter = 0;

while true
    iter = iter + 1;
    h0 = x1 - x0;
    h1 = x2 - x1;
    d0 = (func(x1) - func(x0))/h0;
    d1 = (func(x2) - func(x1))/h1;
    a = (d1 - d0)/(h1+h0);
    b = a*h1 + d1;
    c = func(x2);
    rad = sqrt(b*b - 4*a*c);
    if abs(b + rad) > abs(b - rad)
        den = b + rad;
    else
        den = b - rad;
    end
    dxr = -2*c/den;
    xr = x2 + dxr;
    if abs(dxr) < eps*xr || iter > maxiter
        break;
    end
    %fprintf('%d %f %f\n', iter, xr, abs(dxr));
    x0 = x1;
    x1 = x2;
    x2 = xr;
end
end