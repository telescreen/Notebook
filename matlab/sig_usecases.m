% Plot Sequence x(n) = 2\delta(n+2) - \delta(n-4)
n = -5:5;
x = 2*impseq(-2,-5,5) - impseq(4,-5,5);
subplot(2,2,1);
stem(n,x); title('Sequence 1');
xlabel('n'); ylabel('x(n)');

% Plot sequence x(n) = n*(u(n) - u(n-10)) + 10*exp(-0.3*(n-10))(u(n-10) -
% u(n-20));
n = 0:20;
x1 = n.*(stepseq(0,0,20) - stepseq(10,0,20));
x2 = 10*exp(-0.3*(n-10)).*(stepseq(10,0,20)-stepseq(20,0,20));
x = x1 + x2;
subplot(2,2,2); stem(n,x); 
title('Sequence 2');
xlabel('n'); ylabel('x(n)');

% Plot sequence x(n) = cos(0.04*pi*n) + 0.2w(n);
n = 0:50;
x = cos(0.04*pi*n)+0.2*randn(size(n));
subplot(2,2,3); stem(n,x); title('sequence 3');
xlabel('n'); ylabel('x(n)');

% Plot sequence of period signal
n = -10:9; x = 5:-1:1;
xtilde = x'*ones(1,4); xtilde = (xtilde(:))';
subplot(2,2,4); stem(n,xtilde); title('sequence 4');
xlabel('n'); ylabel('xtilde(n)');