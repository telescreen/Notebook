%% An affine transform that scales horizontally by a factor of 3 
% and vectically by a factor of 2
clc; clear; close all;
T1 = [3 0 0; 0 2 0; 0 0 1];
tform1 = affine2d(T1);
vistformfwd(tform1, [0 100], [0 100]);

%% Shearing effect
T2 = [1 0 0; .5 1 0; 0 0 1];
tform2 = affine2d(T2);
vistformfwd(tform2, [0 100], [0 100]);

%% Transform that is a combination of scaling, rotation, and shear
Tscale = [1.5 0 0; 0 2 0; 0 0 1];
Trotation = [cos(pi/4) sin(pi/4) 0; -sin(pi/4) cos(pi/4) 0; 0 0 1];
Tshear = [1 0 0; .2 1 0; 0 0 1];
T3 = Tscale * Trotation * Tshear;
tform3 = affine2d(T3);
vistformfwd(tform3, [0 100], [0 100]);

%% Linear conformal transform
clc; clear; close all;
f = checkerboard(50);
s = 0.8;
theta = pi/6;
T = [s*cos(theta) s*sin(theta) 0; -s*sin(theta) s*cos(theta) 0;0 0 1];
tform = affine2d(T);
g = imwarp(f, tform, 'FillValue', 0.5);
imshow(f, []); 
figure, imshow(g, []);