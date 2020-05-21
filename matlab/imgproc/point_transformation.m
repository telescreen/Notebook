%% Read image
clc; clear; close all;
image_path = 'f:\data\images/102flowers\image_05583.jpg';
imfinfo(image_path)
f = imread(image_path);
R = histcounts(f(:,:,1), 256, 'Normalization', 'cdf');
G = histcounts(f(:,:,2), 256, 'Normalization', 'cdf');
B = histcounts(f(:,:,3), 256, 'Normalization', 'cdf');
subplot(2,2,1); imshow(f);
subplot(2,2,2);
plot(0:255, R, 'r', 0:255, G, 'g', 0:255, B, 'b');
axis([0 255 0 1]);
title('RGB histogram of input image');
g = intrans(f, 'stretch', mean2(im2double(f)), 0.9);
Rg = histcounts(g(:,:,1), 256, 'Normalization', 'cdf');
Gg = histcounts(g(:,:,2), 256, 'Normalization', 'cdf');
Bg = histcounts(g(:,:,3), 256, 'Normalization', 'cdf');
subplot(2,2,3); imshow(g);
subplot(2,2,4);
plot(0:255, Rg, 'r', 0:255, Gg, 'g', 0:255, Bg, 'b');
axis([0 255 0 1]);
