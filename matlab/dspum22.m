% Digital Signal Processing Using Matlab 3rd
% Generate random number and summary using hist and bar
%
rng(0,'twister');
x1 = 2*rand(100000,1);
subplot(4,1,1); histogram(x1,100);

x2 = randn(10000,10,10);
subplot(4,1,2); histogram(x2,100);