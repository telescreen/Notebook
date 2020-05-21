% Digital Signal Processing Using Matlab 3rd
% Chapter 2 excercises - Problem 2.5

n = -100:100;
y = exp(0.1*pi*n);

subplot(3,1,1); stem(n,y); title('y = exp(0.1*pi*n');
subplot(3,1,2); stem(n, real(y)); title('real part of y');
subplot(3,1,3); stem(n, imag(y)); title('imaginary part of y');

figure;
n = -20:20;
y = cos(0.1*n);
stem(n,y);