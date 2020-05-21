%% DTFT of windows function
M = [10 25 50 101];
K = 100; k = -K:K; w = k*pi/K;

%% Rectangular
for idx = 1:length(M)
    [x,n] = stepseq(0,0,M(idx)-1);
    X = dtft(x,n,w); X = X / max(X);
    subplot(4,1,idx); plot(w/pi, abs(X)); grid on;
end

%% Hanning
for idx = 1:length(M)
    [x,n] = stepseq(0,0,M(idx)-1);
    x = 0.5*(1 - cos(2*pi*n/(M(idx)-1))).* x;
    X = dtft(x,n,w); X = X / max(X);
    subplot(4,1,idx); plot(w/pi, abs(X)); grid on;
end

%% Triangular
for idx = 1:length(M)
    [x,n] = stepseq(0,0,M(idx)-1);
    x = (1 - abs(M(idx)-1-2*n)/(M(idx)-1)).* x;
    X = dtft(x,n,w); X = X / max(X);
    subplot(4,1,idx); plot(w/pi, abs(X)); grid on;
end

%% Hamming
for idx = 1:length(M)
    [x,n] = stepseq(0,0,M(idx)-1);
    x = (0.54 - 0.46*cos(2*pi*n/(M(idx)-1))).* x;
    X = dtft(x,n,w); X = X / max(X);
    subplot(4,1,idx); plot(w/pi, abs(X)); grid on;
end