function [X] = dtftK(x, n, K)
% Calculate DTFT of x
% K the resolution of DTFT
% If K > length(x), all other points is padding with 0
w = (-K:K)*pi/K;
X = x * exp(-1j*n'*w);
end