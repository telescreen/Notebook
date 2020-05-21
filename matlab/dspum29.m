n1 = 0:20;
x = 0.9.^n1;
n2 = -20:0;
y = 0.8.^(-n2);

[xf,nf] = sigfold(x,n1);

[r,rn] = conv_m(y,n2,xf,nf);

subplot(3,1,1); stem(n1,x);
subplot(3,1,2); stem(n2,y);
subplot(3,1,3); stem(nf,xf);