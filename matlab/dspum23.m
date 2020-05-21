% Digital Signal Processing Using Matlab 3rd
% Periodic sequence
%
clc; clear;

% Periodic sequence 1
n1 = -12:12; x1 = -2:2;
xtilde1 = x1'*ones(1,5); xtilde1 = (xtilde1(:))';
subplot(4,1,1); stem(n1,xtilde1);

% Periodic sequence 2
n2 = 0:62; x2 = exp(0.1*(0:20)).*(stepseq(0,0,20) - stepseq(20,0,20));
xtilde2 = x2'*ones(1,3); xtilde2 = (xtilde2(:))';
subplot(4,1,2); stem(n2,xtilde2);

% Periodic sequence 3
n3 = 0:43; x3 = sin(0.1*pi*(0:10)).*(stepseq(0,0,10) - stepseq(10,0,10));
xtilde3 = x3'*ones(1,4); xtilde3 = (xtilde3(:))';
subplot(4,1,3); stem(n3,xtilde3);

% Periodic sequence 4
n4 = 0:23; x41 = 1:3; x42 = 1:4;
xtilde41 = x41'*ones(1,8); xtilde41 = (xtilde41(:))';
xtilde42 = x42'*ones(1,6); xtilde42 = (xtilde42(:))';
xtilde4 = xtilde41 + xtilde42;
subplot(4,1,4); stem(n4,xtilde4);