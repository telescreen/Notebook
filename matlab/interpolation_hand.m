%% Hand interpolation
load('f:\data\myhand.mat','x','y');
n = length(x);
s = (1:n)';
t = (1:.05:n)';
u = spline(s,x,t);
v = spline(s,y,t);
clf reset;
plot(x,y,'bo',u,v,'r-');