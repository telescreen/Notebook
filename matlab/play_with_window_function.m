%% Compare Hanning window and rectangular window
K = 64; n = 0:K-1;
x = sin(2*pi*3.4*n/K);

% Rectangular window
subplot(3,1,1); plot(n,x); grid on;
title('3.4 cycle sinewave');

% FFT
X = fft(x);
% Hanning windows
x = hann(K).*x';
Xh = fft(x);

subplot(3,1,2); plot(n,x,'-*'); grid on;
title('3.4 cycle sinewave after multiplied by hanning window');

% Plotting
magX = abs(X); magX = magX(1:32);
magXh = abs(Xh); magXh = magXh(1:32);
subplot(3,1,3); plot(n(1:K/2), magX, 'b-o', n(1:K/2), magXh, 'c-*'); 
legend('Rectangular', 'Hanning');
set(gca, 'ytick', 0:5:25);
grid on;
title('Rectangular and Hanning window FFT');

%% Using Hanning window to detect a low-level signal
K = 64; n = 0:K-1;
x = sin(2*pi*3.4*n/K) + 0.1*sin(2*pi*7*n/K);

% Rectangular window
subplot(2,2,1); plot(n,x); grid on;
title('3.4 cycle sinewave');

% FFT
X = fft(x);
% Hanning windows
x = hann(K).*x';
subplot(2,2,2); plot(n,x,'-*'); grid on;
title('3.4 cycle sinewave after multiplied by hanning window');

Xh = fft(x);

% Plotting
magX = abs(X); magX = magX(1:32);
magXh = abs(Xh); magXh = magXh(1:32);
subplot(2,2,[3 4]); plot(n(1:K/2), magX, 'b-o', n(1:K/2), magXh, 'c-*'); 
legend('Rectangular', 'Hanning');
set(gca, 'ytick', 0:5:25);
set(gca, 'xtick',0:K/2);
grid on;
title('Rectangular and Hanning window FFT');
