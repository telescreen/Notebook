%% Analog signal
Dt = 0.00005; t = -0.005:Dt:0.005; xa = exp(-1000*abs(t));
% Continuous-time Fourier Transform
Wmax = 2*pi*2000; K = 500; k = 0:K; W = k*Wmax/K;
Xa = xa * exp(-1j*t'*W) * Dt; Xa = real(Xa);
W = [-fliplr(W), W(2:501)];
Xa = [fliplr(Xa), Xa(2:501)];
subplot(2,1,1); plot(t*1000, xa);
xlabel('t in msec.'); ylabel('xa(t)');
title('Analog signal');
subplot(2,1,2); plot(W/(2*pi*1000), Xa*1000);
xlabel('Frequency in KHz'); ylabel('Xa(jW)*1000');
title('Continuous-time Fourier Transform');

%% Sampling an Analog Signal
Dt = 0.00005; t = -0.005:Dt:0.005; xa = exp(-1000*abs(t));
% Discrete-time Signal
Ts = 0.0002; n = -25:25; x = exp(-1000*abs(n*Ts));
% Discrete-time Fourier Transform
K = 500; k = 0:K; w = k*pi/K;
Xa = x * exp(-1j*n'*w); Xa = real(Xa);
w = [-fliplr(w), w(2:K+1)];
Xa = [fliplr(Xa), Xa(2:K+1)];
subplot(2,1,1); plot(t*1000, xa);
xlabel('t in msec.'); ylabel('xa(t)');
title('Discrete signal'); hold on;
stem(n*Ts*1000,x); %gtext('Ts=0.2msec'); 
hold off;
subplot(2,1,2); plot(w/pi, Xa);
xlabel('Frequency in pi units'); ylabel('X1(jW)');
title('Continuous-time Fourier Transform');
