% Generate 100000 elements from a Gaussian distribution with mean 0 and
% standard deviation of 1.
clc; clear; close all;
r = imnoise2('gaussian', 100000, 1, 0, 1);
subplot(3,2,1), histogram(r, 50);
title('Gaussian')

% Uniform random numbers
r = imnoise2('uniform', 100000, 1, 0, 1);
subplot(3,2,2), histogram(r, 50);
title('Uniform')

% Lognormal
r = imnoise2('lognormal', 100000, 1);
subplot(3,2,3), histogram(r, 50);
title('lognormal')

% rayleigh
r = imnoise2('rayleigh', 100000, 1, 0, 1);
subplot(3,2,4), histogram(r, 50);
title('Rayleigh')

% exponential
r = imnoise2('exponential', 100000, 1);
subplot(3,2,5), histogram(r, 50);
title('Exponential')

% erlang
r = imnoise2('erlang', 100000, 1);
subplot(3,2,6), histogram(r, 50);
title('Erlang')

