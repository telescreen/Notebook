%% DFT element wise
w = (0:1:500)*pi/500;
X = exp(1j*w)./ (exp(1j*w) - 0.5*ones(1,501));
magX = abs(X); angX = angle(X); realX = real(X); imagX = imag(X);
subplot(2,2,1); plot(w/pi, magX); grid;
xlabel('frequency in pi units'); 
title('Magnitude Part'); ylabel('Magnitude');
subplot(2,2,3); plot(w/pi, angX); grid;
xlabel('frequency in pi units'); 
title('Angle Part'); ylabel('Radians');
subplot(2,2,2); plot(w/pi, realX); grid;
xlabel('frequency in pi units'); 
title('Real Part'); ylabel('Real');
subplot(2,2,4); plot(w/pi, imagX); grid;
xlabel('frequency in pi units'); 
title('Imaginary Part'); ylabel('Imaginary');

%% DFT with matrix multiplication
n = -1:3; x = 1:5; k = 0:500; w = (pi/500)*k;
X = x * (exp(-1j*pi/500)) .^ (n'*k);
magX = abs(X); angX = angle(X);
realX = real(X); imagX = imag(X);
subplot(2,2,1); plot(k/500,magX); grid
xlabel('frequency in pi units'); title('Magnitude part');
subplot(2,2,3); plot(k/500, angX/pi); grid;
xlabel('frequency in pi units'); title('Angle part');
subplot(2,2,2); plot(k/500, realX); grid;
xlabel('frequency in pi units'); title('Real part');
subplot(2,2,4); plot(k/500, imagX); grid;
xlabel('frequency in pi units'); title('Imaginary part');

%% DFT periodicity
n = 0:10; k = -200:200; 
x = (0.9*exp(1j*pi/3)).^n;
w = (pi/100)*k;
X = x * (exp(-1j*pi/100)) .^ (n'*k);
magX = abs(X); angX = angle(X);
subplot(2,1,1); plot(w/pi,magX); grid
xlabel('frequency in pi units'); title('|X|');
subplot(2,1,2); plot(w/pi, angX); grid;
xlabel('frequency in pi units'); title('Angle part');

%% x(n) = 0.9^n; -10 <= n <= 10;
n = -10:10; x = (-0.9).^abs(n); k = -50:50;
w = (pi/50)*k;
X = x * (exp(-1j*pi/50)) .^ (n'*k);
magX = abs(X); angX = angle(X);
subplot(2,1,1); plot(w/pi,magX); grid; axis([-1 1 0 30]);
xlabel('frequency in pi units'); title('|X|');
subplot(2,1,2); plot(w/pi, angX); grid; axis([-1 1 -1 1]);
xlabel('frequency in pi units'); title('Angle part');

%% DFT of sine
n = -20:20; k = -50:50;
w = pi/50*k;
x = cos(pi/2*n);
X = x * (exp(-1j*pi/50)) .^ (n'*k);
subplot(2,1,1); plot(w/pi, abs(X)); grid; axis([-1 1 0 25])
xlabel('frequency in pi units'); title('|X|');
subplot(2,1,2); plot(w/pi, angle(X)); grid; axis([-1 1 -1 1])
xlabel('frequency in pi units'); title('Angle part');

%% DFT of exponential sequence
n = -10:10; k = -50:50;
w = pi/50*k;
x = exp(1j*3*pi/4*n);
X = x * (exp(-1j*pi/50)).^(n'*k);
subplot(2,1,1); plot(w/pi, abs(X)); grid; axis([-1 1 0 25])
xlabel('frequency in pi units'); title('|X|');
subplot(2,1,2); plot(w/pi, angle(X)); grid; axis([-1 1 -1 1])
xlabel('frequency in pi units'); title('Angle part');

%% Linearity of Fourier Transform
x1 = rand(1,11); x2 = rand(1,11); n = 0:10;
alpha = 2; beta = 3; k=0:500; w = (pi/500)*k;
X1 = x1*(exp(-1j*pi/500)).^(n'*k);
X2 = x2*(exp(-1j*pi/500)).^(n'*k);
x = alpha*x1 + beta*x2;
X = x * (exp(-1j*pi/500)).^(n'*k);
X_check = alpha*X1+beta*X2;
max(abs(X-X_check))

%% Timeshift property of Fourier Transform
n = 0:10; x = rand(1,11);
k = 0:500; w = (pi/500)*k;
X = x * (exp(-1j*pi/500)).^(n'*k);
% signal shifted by two samples
y = x; m = n + 2;
Y = y * (exp(-1j*pi/500)).^(m'*k);
% verification
Y_check = (exp(-1j*2).^w).*X;
max(abs(Y-Y_check))

%% Frequency shift property of Fourier Transform
n = 0:100; x = cos(pi*n/2);
k = -100:100; w = (pi/100)*k;
X = x * (exp(-1j*pi/100)).^(n'*k);
y = exp(1j*pi*n/4).*x;
Y = y * (exp(-1j*pi/100)).^(n'*k);
% Graphical verification
subplot(2,2,1); plot(w/pi, abs(X)); grid; axis([-1 1 0 60]);
xlabel('frequency in pi units'); ylabel('|X|'); title('Magnitude of X');
subplot(2,2,2); plot(w/pi, angle(X)); grid; axis([-1 1 -1 1]);
xlabel('frequency in pi units'); ylabel('radians/pi'); title('Angle of X');
subplot(2,2,3); plot(w/pi, abs(Y)); grid; axis([-1 1 0 60]);
xlabel('frequency in pi units'); ylabel('|Y|'); title('Magnitude of Y');
subplot(2,2,4); plot(w/pi, angle(Y)); grid; axis([-1 1 -1 1]);
xlabel('frequency in pi units'); ylabel('radians/pi'); title('Angle of Y');

%% Verify conjugation
n = -5:10; x = rand(1,length(n)) + 1j*rand(1,length(n));
k = -100:100;
X = x * (exp(-1j*pi/100)).^(n'*k);
y = conj(x);
Y = y * (exp(-1j*pi/100)).^(n'*k);
Y_check = conj(fliplr(X));
max(abs(Y-Y_check))

%% Verify folding in time domain
n = -5:10; x = rand(1,length(n)); k = -100:100;
X = x * (exp(-1j*pi/100)).^(n'*k);
y = fliplr(x); m = -fliplr(n);
Y = y * (exp(-1j*pi/100)).^(m'*k);
Y_check = fliplr(X);
max(abs(Y-Y_check))

%% Check real signals
n = -5:10; x = sin(pi*n/2);
k = -100:100; w = (pi/100)*k;
X = x * (exp(-1j*pi/100)).^(n'*k);
[xe,xo,m] = evenodd(x,n);
XE = xe * (exp(-1j*pi/100)).^(m'*k);
XO = xo * (exp(-1j*pi/100)).^(m'*k);
XR = real(X);
XI = imag(X);
max(abs(XE-XR))
max(abs(XO-1j*XI))
% graphical verification
subplot(2,2,1); plot(w/pi, XR); grid; axis([-1 1 -2 2]);
xlabel('frequency in pi units'); ylabel('|X|'); title('Magnitude of X');
subplot(2,2,2); plot(w/pi, XI); grid; axis([-1 1 -10 10]);
xlabel('frequency in pi units'); ylabel('radians/pi'); title('Angle of X');
subplot(2,2,3); plot(w/pi, real(XE)); grid; axis([-1 1 -2 2]);
xlabel('frequency in pi units'); ylabel('|XE|'); title('Magnitude of XE');
subplot(2,2,4); plot(w/pi, imag(XO)); grid; axis([-1 1 -10 10]);
xlabel('frequency in pi units'); ylabel('radians/pi'); title('Angle of XE');
