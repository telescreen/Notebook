%% Average Noisy Image to reduce error.
% Written by: me (Tokyo 2019/9/14)
clc; clear;

orig_image_path = 'D:\Data\DIP4E\galaxy-pair.tif';
noisy_image_path = 'D:\Data\DIP4E_Generated\galaxy-pair.tif';

orig_image = imread(orig_image_path);
noisy_image = imread(noisy_image_path);

% Average K number of images 
average_image = AverageImage(noisy_image_path, 100);

figure('Name', 'Original Image');
imshow(orig_image);
figure('Name', 'Image corrupted by gaussian noise');
imshow(noisy_image);
figure('Name', 'Result of averaging 5 images');
imshow(uint8(average_image));