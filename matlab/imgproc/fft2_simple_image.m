%% Fourier Transform of simple images
img = zeros(512); img(200:312, 200:312) = 1;
F = fft2(img);
Fc = fftshift(F);
S2 = log(1 + abs(Fc));
subplot(1,2,1); imshow(img);
subplot(1,2,2); imshow(S2,[]);
max(S2(:))

%% Part 2
f = [ones(128,256); zeros(128,256)];
[M,N] = size(f);
h = fspecial('gaussian', 15, 7);
gs = imfilter(f,h);
imshow(gs);

%% Experiment with filters in time / frequency domain
clc; clear; close all;
f = imread('D:\Data\DIP4E\building-600by600.tif');
F = fft2(f);
Fs = fftshift(log(1+abs(F)));
Fs = gscale(Fs);
PQ = paddedsize(size(f));

h = fspecial('sobel');
H = freqz2(h, PQ(1), PQ(2));
H1 = ifftshift(H);

gs = imfilter(double(f), h);
gf = dftfilt(f,H1);
imshow(f);
figure, imshow(gs,[]);
figure, imshow(gf,[]);
figure, imshow(abs(gs) > 0.2*abs(max(gs(:))), []);
figure, imshow(abs(gf) > 0.2*abs(max(gf(:))), []);

%% Experiment with sobel matrix
clc; clear; close all;
f = imread('F:\data\images\random\Bikesgray.jpg');
h = fspecial('sobel');
g = imfilter(f, h);
imshow(g);

%% Linear filter of image
clc; clear; close all;
f = imread('F:\data\images\imp\DIP3E_Original_Images_CH04\Fig0442(a)(characters_test_pattern).tif');
imshow(f);
PQ = paddedsize(size(f));
[U,V] = dftuv(PQ(1), PQ(2));
D0 = 0.05*PQ(2);
F = fft2(f, PQ(1), PQ(2));
H = exp(-(U.^2 + V.^2)/(2*(D0^2)));
g = dftfilt(f, H);
figure, imshow(fftshift(H), []);
figure, imshow(log(1 + abs(fftshift(F))), []);
figure, imshow(g, []);

%% Highpass filter of image
clc; clear; close all;
f = imread('F:\data\images\imp\DIP3E_Original_Images_CH04\Fig0442(a)(characters_test_pattern).tif');
imshow(f);
PQ = paddedsize(size(f));
D0 = 0.05 * PQ(1);
H = hpfilter('gaussian', PQ(1), PQ(2), D0);
g = dftfilt(f, H);
figure, imshow(g, []);

%% High-frequency emphasis filtering
clc; clear; close all;
f = imread('f:\data\images\imp\DIP3E_Original_Images_CH04\Fig0459(a)(orig_chest_xray).tif');
imshow(f); title('Original image');
PQ = paddedsize(size(f));
D0 = 0.05 * PQ(1);
HBW = hpfilter('btw', PQ(1), PQ(2), D0, 2);
H = 0.5 + 2 * HBW;
gbw = dftfilt(f, HBW);
gbw = gscale(gbw);
figure, imshow(gbw);
title('Image with butterworth highpass filter of order 2');
ghf = dftfilt(f, H);
ghf = gscale(ghf);
figure, imshow(ghf);
ghe = histeq(ghf, 256);
title('Image with butterworth high frequency emphasis highpass filter of order 2');