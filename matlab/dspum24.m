% Digital Signal Processing Using Matlab 3rd
%
clc; clear;
n = -3:3; x = [2 4 -3 1 -5 4 7];
[x11,n11] = sigshift(x,n,3); 
[x12,n12] = sigshift(x,n,-4);
[x1,m] = sigadd(2*x11,n11,3*x12,n12); 
[x1,m] = sigadd(x1,m,-x,n);
stem(m,x1);