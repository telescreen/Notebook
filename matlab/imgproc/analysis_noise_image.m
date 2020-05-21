%% Histogram of ROI of image
clc; clear; close all;
f = imread('D:\Data\DIP4E\cktboard-controller.tif');
inclass = class(f);
imshow(f); title('Original image');

%% Corrupt image using pepper noise
[M, N] = size(f);
R = imnoise2('salt & pepper', M, N, 0.1, 0);
gp = f;
gp(R == 0) = 0;
R = imnoise2('salt & pepper', M, N, 0, 0.1);
gs = f;
gs(R == 1) = 255;
subplot(3,2,1); imshow(gp);
subplot(3,2,2); imshow(gs);

chgp = spfilt(gp, 'chmean', 3, 3, 1.5);
subplot(3,2,3); imshow(chgp);
chgs = spfilt(gs, 'chmean', 3, 3, -5);
subplot(3,2,4); imshow(chgs);

maxgp = spfilt(gp, 'max');
subplot(3,2,5); imshow(maxgp);
mings = spfilt(gs, 'min');
subplot(3,2,6); imshow(mings);

%% Adaptive spatial Filters
clc; close all;
g = imnoise(f, 'salt & pepper', .25);
f1 = medfilt2(g, [7 7], 'symmetric');
f2 = adpmedian(g, 7);
imshow(g);
figure, imshow(f1);
figure, imshow(f2);

%% Point Spread Function
f = checkerboard(8);
PSF = fspecial('motion', 7, 45);
gb = imfilter(f, PSF, 'circular');
noise = imnoise(zeros(size(f)), 'gaussian', 0, 0.001);
g = gb + noise;
imshow(pixeldup(g, 8), []);
title('Origin image after noise')

%% Inverse and Wiener filtering
fr1 = deconvwnr(g, PSF);
Sn = abs(fft2(noise)).^2;
nA = sum(Sn(:))/numel(noise);
Sf = abs(fft2(f)).^2;
fA = sum(Sf(:))/numel(f);
R = nA/fA;
fr2 = deconvwnr(g, PSF, R);

NCORR = fftshift(real(ifft2(Sn)));
ICORR = fftshift(real(ifft2(Sf)));
fr3 = deconvwnr(g, PSF, NCORR, ICORR);

imshow(pixeldup(fr1,8), []);
figure, imshow(pixeldup(fr2, 8), []);
figure, imshow(pixeldup(fr3, 8), []);

%% Denoise using Constrained Least Squares
close all;
fr = deconvreg(g, PSF, 4);
figure, imshow(pixeldup(fr, 8), []); 
title('deconvreg with noise poiwer = 4');
fr = deconvreg(g, PSF, 0.4, [1e-7, 1e7]);
figure, imshow(pixeldup(fr, 8), []); 
title('deconvreg with noise poiwer = 0.4');


%% Nonlinear methods: Lucy-Richardson Algorithm
f = checkerboard(8);
imshow(pixeldup(f, 8), []);
title('Original image');
PSF = fspecial('gaussian', 7, 10);
SD = 0.01;
g = imnoise(imfilter(f, PSF), 'gaussian', 0, SD^2);
figure, imshow(pixeldup(g, 8), []);
title('Image after gaussian PSF and underwent gaussian noise of sd = 0.01');

DAMPAR = 10*SD;
LIM = ceil(size(PSF, 1)/2);
WEIGHT = zeros(size(g));
WEIGHT(LIM + 1:end-LIM, LIM + 1:end-LIM) = 1;
NUMIT = 5;
fr = deconvlucy(g, PSF, NUMIT, DAMPAR, WEIGHT);
figure, imshow(pixeldup(fr, 8));
title('Image after being denoised');