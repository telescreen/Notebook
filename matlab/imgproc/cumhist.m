function cumhist(f)
% CUMHIST calculate and plot cumulative histogram of input image
% onlly for grayscale image
hnorm = imhist(f)./numel(f);
cdf = cumsum(hnorm);
x = linspace(0,1,256);
plot(x,cdf);
axis([0 1 0 1]);
set(gca, 'xtick', 0:.2:1);
set(gca, 'ytick', 0:.2:1);
xlabel('Input intensity values', 'fontsize', 9);
ylabel('Output intensity values', 'fontsize', 9);
text(0.18, 0.5, 'Transformation function', 'fontsize', 9);
end