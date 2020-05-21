%% Plot frequency response of 0.9^abs(n)
clc; clear; close all;
n = -10:10;
x = 0.9.^abs(n);
X = dtftK(x,n,50);
plotdft(X, 50);

%% Plot frequency response of sinc(0.2n)[u(n+20) - u(n-20)]
clc; clear; close all;
l = -30; r = 30;
n = l:r; K = 100;
u = stepseq(-20, -30, 30) - stepseq(20, -30, 30);
x = sinc(0.2*n).*u;
X = dtftK(x,n,K);
plotdft(X, K);

%% Plot frequency response of sinc(0.2n)[u(n) - u(n-40)]
clc; clear; close all;
l = -5; r = 40;
n = l:r; K = 100;
u = stepseq(0,l,r) - stepseq(40,l,r);
x = sinc(0.2*n).*u;
X = dtftK(x,n,K);
plotdft(X, K);

%% Plot frequency response of sinc(0.2n)[u(n) - u(n-40)]
clc; clear; close all;
l = -10; r = 10;
n = l:r; K = 100;
u = stepseq(0,l,r);
x = (0.5.^n + 0.4.^n).*u;
X = dtftK(x,n,K);
plotdft(X, K);

%% Plot frequency response of sinc(0.2n)[u(n) - u(n-40)]
clc; clear; close all;
l = -10; r = 10;
n = l:r; K = 100;
x = (0.5.^abs(n)).*cos(0.1*pi*n);
X = dtftK(x,n,K);
plotdft(X, K);