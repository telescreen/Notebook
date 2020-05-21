%% 3.7: Signal decomposition into conjugate symmetric parts
n = -15:15;
u = stepseq(0,-15,15) - stepseq(10,-15,15);
x = 2*0.9.^(-n).*(cos(0.1*pi*n) - 1j*sin(0.9*pi*n)).*u;
[evenx, oddx, m] = evenodd(x, n);

% DTFT of the whole signal
K = 50; w = (-K:K)*pi/K;
X = dtft(x,n,w);
realX = real(X);
imagX = imag(X);

% DTFT of each component
Xreal = dtft(evenx,n,w);
Ximag = dtft(oddx,n,w);

% Verify DTFT property
max(abs(realX - Xreal))
max(abs(1j*imagX - Ximag))

%% 3.8: DTFT decomposition into conjugate symmetric and conjugate anti-symmetric parts
clear; clc;
n = -5:25;
u = stepseq(0, -5, 25) - stepseq(20, -5, 25);
x = exp(1j*0.1*pi*n).*u;
realx = real(x);
imagx = imag(x);
% DTFT of input signal
K = 50; w = (-K:K)*pi/K;
X = dtft(x,n,w);
realX = dtft(realx, n, w);
imagX = dtft(1j*imagx, n, w);
% Decompose input signal
[evenX, oddX, m] = evenodd(X, -K:K);
% Compare
max(abs(realX-evenX))
max(abs(imagX-oddX))