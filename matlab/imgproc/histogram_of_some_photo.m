%% Histogram of F:\data\DIP3E_Original_Images_CH03\Fig0304(a)(breast_digital_Xray).tif
clc; clear; close all;
f = imread('F:\data\images\imp\DIP3E_Original_Images_CH03\Fig0304(a)(breast_digital_Xray).tif');
h = histcounts(f, 256);
h1 = h(1:10:256);
horz = 1:10:256;
subplot(2,2,1);
plot(h);
axis([0 255 0 15000])
set(gca, 'xtick', 0:50:255);
set(gca, 'ytick', 0:2000:15000);
subplot(2,2,2);
bar(horz, h1);
axis([0 255 0 15000])
set(gca, 'xtick', 0:50:255);
set(gca, 'ytick', 0:2000:15000);
subplot(2,2,3);
stem(horz, h1, 'fill');
axis([0 255 0 15000])
set(gca, 'xtick', 0:50:255);
set(gca, 'ytick', 0:2000:15000);
subplot(2,2,4);
plot(h1);
axis([0 255 0 15000])
set(gca, 'xtick', 0:50:255);
set(gca, 'ytick', 0:2000:15000);

%% Histogram equalization
clc; clear; close all;
f = imread('F:\data\images\imp\DIP3E_Original_Images_CH03\Fig0316(4)(bottom_left).tif');
subplot(2,2,1); imshow(f); 
subplot(2,2,2); imhist(f); ylim('auto');
g = histeq(f);
subplot(2,2,3); imshow(g); 
subplot(2,2,4); imhist(g);
figure; cumhist(f);
ylim('auto');

%% Histogram matching
clc; clear; close all;
f = imread('F:\data\images\imp\DIP3E_Original_Images_CH03\Fig0323(a)(mars_moon_phobos).tif');
subplot(2,2,1); imshow(f); 
subplot(2,2,2); imhist(f);
p = twomodegauss(0.15,0.05,0.75,0.05,1,0.01,0.002);
f1 = histeq(f, p);
subplot(2,2,3); imshow(f1); 
subplot(2,2,4); imhist(f1);

%% Standard spatial filters
clc; clear; close all;
f = imread('F:\data\images\imp\DIP3E_Original_Images_CH03\Fig0338(a)(blurry_moon).tif');
imshow(f);
w = fspecial('laplacian', 0);
g1 = imfilter(f, w, 'replicate');
figure, imshow(g1, []);

f2 = im2double(f);
g2 = imfilter(f2, w, 'replicate');
figure, imshow(g2, []);

g = f2 - g2;
figure, imshow(g);

%% Median filtering to reduce salt-and-pepper noise
clc; clear; close all;
f = imread('F:\data\images\imp\DIP3E_Original_Images_CH03\Fig0335(a)(ckt_board_saltpep_prob_pt05).tif');
g = medfilt2(f);
imshow(g);