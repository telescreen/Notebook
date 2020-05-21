%% Identify the importance of zero-padding DFT
T = 16; F = 3;              % 3 cycles / 16 points
K = 128; n = 0:T/K:T;       % For plotting: take 128 points sample
x = sin(2*pi*F*n/T);

% Take T samples
m = 0:T-1;
xsample = x(m*K/T+1);
N = 128;
X = fft(xsample, N);
magX = abs(X);

subplot(2,1,1); plot(n,x, m, xsample,'*'); grid on;
subplot(2,1,2); plot(0:N-1, magX, '-*');