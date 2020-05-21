%% Calculate DFT of x(n) = 0.6^abs(n) * (u(n+10) - u(n-11))
[x1,n] = stepseq(-10,-15,15);
[x2,n] = stepseq(11,-15,15);
x = (0.6.^abs(n)) .* (x1 - x2);
K = 100; k = -100:100; w = k*pi/K;
X = dtft(x,n,w);
magX = abs(X); angX = angle(X);
subplot(3,1,1); stem(n,x); grid on;
title('Finite-duration sequence');
subplot(3,1,2); plot(w/pi, magX); grid on;
title('Magnitude in pi units');
subplot(3,1,3); plot(w/pi, angX); grid on;
title('Angle in pi units');

%% Calculate DFT of x(n) = n*0.9^n * (u(n) - u(n-21))
[x1,n] = stepseq(0,-5,25);
[x2,n] = stepseq(21,-5,25);
x = (n .* 0.9.^n) .* (x1 - x2);
K = 100; k = -100:100; w = k*pi/K;
X = dtft(x,n,w);
magX = abs(X); angX = angle(X);
subplot(3,1,1); stem(n,x); grid on;
title('Finite-duration sequence');
subplot(3,1,2); plot(w/pi, magX); grid on;
title('Magnitude in pi units');
subplot(3,1,3); plot(w/pi, angX); grid on;
title('Angle in pi units');

%% Calculate DFT of x(n) = [cos(0.5*pi*n) + jsin(0.5*pi*n)][u(n) - u(n-51)]
[x1,n] = stepseq(0,-10,60);
[x2,n] = stepseq(21,-10,60);
x = (cos(0.5*pi*n) + 1j*sin(0.5*pi*n)) .* (x1 - x2);
K = 100; k = -100:100; w = k*pi/K;
X = dtft(x,n,w);
magX = abs(X); angX = angle(X);
subplot(3,1,1); stem(n,x); grid on;
title('Finite-duration sequence');
subplot(3,1,2); plot(w/pi, magX); grid on;
title('Magnitude in pi units');
subplot(3,1,3); plot(w/pi, angX); grid on;
title('Angle in pi units');

%% Calculate DFT of x(n) = [4,3,2,1,1,2,3,4]
n = 0:7;
x = [4 3 2 1 1 2 3 4];
K = 50; k = -50:50; w = k*pi/K;
X = dtft(x,n,w);
magX = abs(X); angX = angle(X);
subplot(3,1,1); stem(n,x); grid on;
title('Finite-duration sequence');
subplot(3,1,2); plot(w/pi, magX); grid on;
title('Magnitude in pi units');
subplot(3,1,3); plot(w/pi, angX); grid on;
title('Angle in pi units');

%% Calculate DFT of x(n) = [4,3,2,1,-1,-2,-3,-4]
n = 0:7;
x = [4 3 2 1 -1 -2 -3 -4];
K = 50; k = -50:50; w = k*pi/K;
X = dtft(x,n,w);
magX = abs(X); angX = angle(X);
subplot(3,1,1); stem(n,x); grid on;
title('Finite-duration sequence');
subplot(3,1,2); plot(w/pi, magX); grid on;
title('Magnitude in pi units');
subplot(3,1,3); plot(w/pi, angX); grid on;
title('Angle in pi units');

%% Fourier Transform of Unit impulse
[x,n] = impseq(0,-10,10);
K = 50; k = -50:50; w = k*pi/K;
X = dtft(x,n,w);
magX = abs(X); angX = angle(X);
subplot(3,1,1); stem(n,x); grid on;
title('Finite-duration sequence');
subplot(3,1,2); plot(w/pi, magX); grid on;
title('Magnitude in pi units');
subplot(3,1,3); plot(w/pi, angX); grid on;
title('Angle in pi units');

%% Fourier Transform of Double Exponential
K = 100; k = -100:100; w = k*pi/K;
Y = (1 - 0.6^2) ./ (1 - 2*0.6*cos(w) + 0.6^2);
magY = abs(Y); angY = angle(Y);
subplot(2,1,1); plot(w/pi, magY); grid on;
subplot(2,1,2); plot(w/pi, angle(Y)); grid on;

%% Calculate DFT of x(n) = 0.6^abs(n) * u(n)
[x, n] = stepseq(0,-10,10);
x = 0.6.^abs(n) .* x;
K = 100; k = -100:100; w = k*pi/K;
X = dtft(x,n,w);
magX = abs(X); angX = angle(X);
subplot(3,1,1); stem(n,x); grid on;
title('Finite-duration sequence');
subplot(3,1,2); plot(w/pi, magX); grid on;
title('Magnitude in pi units');
subplot(3,1,3); plot(w/pi, angX); grid on;
title('Angle in pi units');

%% Calculate DFT of x(n) = cos(3*pi/4*n)
n = -10:10; x = cos(0.4*pi*n);
K = 100; k = -100:100; w = k*pi/K;
X = dtft(x,n,w);
magX = abs(X); angX = angle(X);
subplot(3,1,1); stem(n,x); grid on;
title('Finite-duration sequence');
subplot(3,1,2); plot(w/pi, magX); grid on;
title('Magnitude in pi units');
subplot(3,1,3); plot(w/pi, angX); grid on;
title('Angle in pi units');

%% Fourier transform Linearity
x1 = [1 2 2 1]; n1 = 0:3;
x2 = [x1 x1]; n2 = 0:7;
K = 100; k = -100:100; w = k*pi/K;
X1 = dtft(x1,n1,w);
X2 = dtft(x2,n2,w);
subplot(3,1,1); plot(w/pi, abs(X1)); grid on;
X1 = X1 + X1 .* exp(-1j*w*4);
magX1 = abs(X1); magX2 = abs(X2);
max(abs(X1-X2))
subplot(3,1,2); plot(w/pi, magX1); grid on;
subplot(3,1,3); plot(w/pi, magX2); grid on;

%% Fourier transform of 2 * (0.5)^n * u(n+2)
[x,n] = stepseq(-2, -10, 10);
x = 2 * 0.5.^n .* x;
K = 100; k = 0:100; w = k*pi/K;
X = dtft(x,n,w);
Y = (2 ./ (1 - 0.5*exp(-1j*w))) .* exp(-2*1j*w);
subplot(2,1,1); plot(w/pi, abs(X)); grid on;
subplot(2,1,2); plot(w/pi, abs(Y)); grid on;