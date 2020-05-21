%% Analysis of color image
image_path = 'D:\Data\DIP3E\DIP3E_Original_Images_CH06\Fig0651(a)(flower_no_compression).tif';
f = imread(image_path);
imshow(f);
imfinfo(image_path)

[X1, map1] = rgb2ind(f, 8, 'nodither');
figure, imshow(X1, map1);
title('No dithered 8-bit color image');

[X2, map2] = rgb2ind(f, 8, 'dither');
figure, imshow(X2, map2);
title('Dithered 8-bit color image');

%% Dithering effects with gray-scale images
g = rgb2gray(f);
g1 = dither(g);
figure, imshow(g); figure, imshow(g1);