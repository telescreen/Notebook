function [y,ny] = conv_m(x,nx,h,nh)
% conv_m: Modified convolution routine for signal processing
% ----------------------------------------------------------
%   [y,ny] = conv_m(x,nx,h,nh)
%   [y,n] = convolution result
%   [x,nx] = first signal
%   [h,nh] = second signal
%
nyb = nx(1) + nh(1); nye = nx(length(x)) + nh(length(h));
ny = nyb:nye; y = conv(x,h);
end