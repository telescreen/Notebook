function [y,n] = sigfold(x,n)
%sigfold: implements y(n) = x(-n)
%--------------------------------
% [y,n] = sigfold(x,n)
%
y = fliplr(x); n = -fliplr(n);
end