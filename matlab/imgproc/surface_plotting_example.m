%% Plotting surface using mesh
clc; clear; close all;
H = fftshift(lpfilter('gaussian', 500, 500, 50));
surf(H(1:10:500,1:10:500))
axis([0 50 0 50 0 1])
shading interp

%% Plotting using meshgrid
[Y, X] = meshgrid(-2:0.1:2, -2:0.1:2);
Z = X.*exp(-X.^2 - Y.^2);
surf(Z);

%% Highpass surf
H = fftshift(hpfilter('ideal', 500, 500, 50));
surf(H(1:10:500, 1:10:500));
axis([0 50 0 50 0 1])
figure, imshow(H, [])
