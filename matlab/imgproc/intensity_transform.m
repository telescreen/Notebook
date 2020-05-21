%% Plot gamma function
clc; clear; close all;
x = 0:.01:1;
gamma = 2;
y = x.^gamma;
plot(x,y);

%% Intensity transformation.
clc; clear; close all;
f = imread('F:\data\images\imp\DIP3E_Original_Images_CH03\Fig0304(a)(breast_digital_Xray).tif');
g = intrans(f, 'neg');
g1 = imadjust(f, [0.5 0.75], [0 1]);
g2 = intrans(f, 'gamma', 2);
subplot(2,2,1); imshow(f);
subplot(2,2,2); imshow(g);
subplot(2,2,3); imshow(g1);
subplot(2,2,4); imshow(g2);

%% Contrast stretching function
x = 0:.01:1;
m = 0.001; E = 2;
y = 1./(1 + (m./(double(x) + eps)).^E);
plot(x,y,'b-');

%% Contrast stretching to enhance image contrast
clc; clear; close all;
f = imread('F:\data\images\imp\DIP3E_Original_Images_CH03\Fig0343(a)(skeleton_orig).tif');
g = intrans(f, 'stretch', mean2(im2double(f)), 1.5);
subplot(1,2,1); imshow(f); subplot(1,2,2); imshow(g);

%% Spatial filtering
clc; clear; close all;
f = [zeros(256) ones(256); ones(256) zeros(256)];
w = ones(31);
gd = imfilter(f, w, 'replicate');
imshow(gd, []);

%% Spatial filter
%% Standard spatial filters
clc; clear; close all;
f = imread('F:\data\images\imp\DIP3E_Original_Images_CH03\Fig0338(a)(blurry_moon).tif');
subplot(2,2,1); imshow(f);
w = [1 1 1;1 -8 1;1 1 1];
g1 = imfilter(f, w, 'replicate');
subplot(2,2,2), imshow(g1, []);

f2 = im2double(f);
g2 = imfilter(f2, w, 'replicate');
subplot(2,2,3), imshow(g2, []);

g = f2 - g2;
subplot(2,2,4), imshow(g);