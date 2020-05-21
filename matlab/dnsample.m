function [y,m] = dnsample(x,n,M)
%dnsample: Downsample sequence x(n) by a factor M to obtain y(m)
%   [y,m] = dnsample(x,n,M)
%
idx = mod(n,M);
y = x(idx==0);
t = n(idx==0);
m = t(1)/M:t(end)/M;
end