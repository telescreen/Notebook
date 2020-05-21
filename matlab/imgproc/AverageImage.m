function avgI = AverageImage(image_path, K)
% AverageImage: Average images in image_path by K other images
% Input
%    image_path     the path where we store other images. 
%    
%    K              The number of images we want to calculate average
%
% Written by: me (Tokyo 2019/9/14)

[filepath, filename, fileext] = fileparts(image_path);
img = imread(image_path);
avgI = double(img);
for idx = 2:K
    newImg = imread(fullfile(filepath, [filename int2str(idx) fileext]));    
    avgI = avgI + double(newImg);
end
avgI = avgI / K;

end