function expfitdemo
clc; 
t = (0:.1:2)';
y = [5.8955 3.5639 2.5173 1.9790 1.8990 1.3938 1.1359 ...
     1.0096 1.0343 0.8435 0.6856 0.6100 0.5392 0.3946 ...
     0.3903 0.5474 0.3459 0.1370 0.2211 0.1704 0.2636]';
clf
shg
set(gcf,'doublebuffer','on')
h = plot(t,y,'o',t,0*t,'-');
h(3) = title('');
axis([0 2 0 6.5]);

lambda0 = [3;6];
lambda = fminsearch(@expfitfun, lambda0);
set(h(2), 'color', 'black');

function res = expfitfun(lambda)
m = length(t);
n = length(lambda);
X = zeros(m,n);
for j = 1:n
    X(:,j) = exp(-lambda(j)*t);
end
beta = X\y;
z = X*beta;
res = norm(z-y);
end

set(h(2),'ydata',z);
set(h(3),'string',sprintf('%8.4f %8.4f',lambda));
pause(.1);
end

