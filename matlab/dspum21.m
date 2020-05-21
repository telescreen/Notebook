% Digital Signal Processing Using Matlab 3rd
% Chapter 2 excercises
%
clc; clear;

% Sequence 1
n1 = -5:15;
x1 = 3*impseq(-2,-5,15)+2*impseq(0,-5,15)-impseq(3,-5,15)+5*impseq(7,-5,15);
subplot(4,2,1); 
stem(n1,x1); 
title('Sequence 1'); xlabel('n'); ylabel('x(n)');

% Sequence 2
n2 = -10:10;
x2 = zeros(size(n2));
for k = -5:5
    t = exp(-(abs(k)))*impseq(-2*k,-10,10);
    x2 = x2 + t;
end
subplot(4,2,2); 
stem(n2,x2);
title('Sequence 2'); xlabel('n'); ylabel('x(n)');

% Sequence 3
l3 = 0; r3 = 15; n3 = l3:r3;
x3 = 10*stepseq(0,l3,r3)-5*stepseq(5,l3,r3) ...
   - 10*stepseq(10,l3,r3)+5*stepseq(15,l3,r3);
subplot(4,2,3);
stem(n3,x3);
title('Sequence 3'); xlabel('n'); ylabel('x(n)');

% Sequence 4
n4 = -20:10;
x4 = exp(0.1*n4).*(stepseq(-20,-20,10) - stepseq(10,-20,10));
subplot(4,2,4);
stem(n4,x4);
title('Sequence 4'); xlabel('n'); ylabel('x(n)');

% Sequence 5
n5 = -200:200;
x5 = 5*(cos(0.49*pi*n5) + cos(0.51*pi*n5));
subplot(4,2,5);
stem(n5,x5);
title('Sequence 5'); xlabel('n'); ylabel('x(n)');

% Sequence 6
n6 = -200:200;
x6 = 2*sin(0.01*pi*n6).*cos(0.5*pi*n6);
subplot(4,2,6);
stem(n6,x6);
title('Sequence 6'); xlabel('n'); ylabel('x(n)');

% Sequence 7
n7 = 0:100;
x7 = exp(-0.05*n7).*sin(0.1*pi*n7 + pi/3);
subplot(4,2,7);
stem(n7,x7);
title('Sequence 7'); xlabel('n'); ylabel('x(n)');

% Sequence 8
n8 = 0:100;
x8 = exp(0.01*n8).*sin(0.1*pi*n8);
subplot(4,2,8);
stem(n8,x8);
title('Sequence 8'); xlabel('n'); ylabel('x(n)');
