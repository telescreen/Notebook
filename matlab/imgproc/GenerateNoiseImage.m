function GenerateNoiseImage(input_img, output_dir, K, nmean, nstd)
% GenerateNoiseImage   Generate K noise image from input_image 
%                      output the results image to output_dir. The
%                      input_img is corrupted by gausian noise with mean
%                      nmean and standard deviation nstd.
% Written by: me (Tokyo - 2019/9/14)
[~, filename, fileext] = fileparts(input_img);
img = imread(input_img);

for idx = 1:K
   output_img = imnoise(img, 'gaussian', nmean, nstd);
   imwrite(output_img, fullfile(output_dir, [filename int2str(idx) fileext]));
end

end