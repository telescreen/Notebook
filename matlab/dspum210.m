n = 0:200; alpha = 0.1;
x = cos(0.2*pi*n)+0.5*cos(0.6*pi*n);
[xs,ns] = sigshift(x,n,50);
[y,ny] = sigadd(x,n,alpha*xs,ns);

[xf,nf] = sigfold(x,n);

[ycorr,ncorr] = conv_m(y,ny,xf,nf);

subplot(2,1,1); stem(ns,xs);
subplot(2,1,2); stem(ncorr,ycorr);