%% Frequency Response
w = (0:500)*pi/500;
H = exp(1j*w) ./ (exp(1j*w) - 0.9*ones(1,501));
magH = abs(H); angH = angle(H);
subplot(2,1,1); plot(w/pi, magH); grid;
xlabel('frequency in pi units'); ylabel('|H|');
title('Magnitude Response');
subplot(2,1,2); plot(w/pi, angH/pi); grid;
xlabel('frequency in pi units'); ylabel('Phase in pi radians');
title('Phase Response');

%% Verify
b = 1; a = [1, -0.8];
n = 0:100; x = cos(0.05*pi*n);
y = filter(b,a,x);
subplot(2,1,1); stem(n,x);
xlabel('n'); ylabel('x(n)'); title('Input sequence');
subplot(2,1,2); stem(n,y);
xlabel('n'); ylabel('y(n)'); title('Output sequence');

%% Low pass filter using difference equation
b = [0.0181 0.0543 0.0543 0.0181];
a = [1.0000 -1.7600 1.1829 -0.2781];
m = 0:length(b)-1; n = 0:length(a)-1;
K = 500; k = 0:K;
w = pi*k/K;
num = b*exp(-1j*m'*w);
den = a*exp(-1j*n'*w);
H = num./den;
magH = abs(H); angH = angle(H);
subplot(2,1,1); plot(w/pi, magH); grid; axis([0 1 0 1]);
xlabel('frequency in pi units'); ylabel('|H|');
title('Magnitude Response');
subplot(2,1,2); plot(w/pi, angH); grid;
xlabel('frequency in pi units'); ylabel('Phase in pi radians');
title('Phase Response');
