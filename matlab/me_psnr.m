function ratio = me_psnr(x, y)
% ME_PSNR: Calculate the PSNR Signal-to-Noise-Ratio of 2 gray-scale images
% ARGUMENTS:
%     x: double image
%     y: double image
% written by: me (2016/10/22)

% Get image size
[M, N] = size(x);
error = x - y;
MSE = sum(sum(error .* error)) / (M*N);
ratio = 10*log10(1/MSE);
end