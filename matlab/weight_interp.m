close all;
%%    Date     Tom  Ben
W = [10 27 2001 5 10 4 8
     11 19 2001 7 4 5 11
     12 03 2001 8 12 6 4
     12 20 2001 10 14 8 7
     01 09 2002 12 13 10 3
     01 23 2002 14 8 12 0
     03 06 2002 16 10 13 10
];
t = datenum(W(:,[3 1 2]));
Tom = W(:,4) + W(:,5)/16;
Ben = W(:,6) + W(:,7)/16;

period = t(1):1:t(end);
TomInterp = pchip(t, Tom, period);
BenInterp = pchip(t, Ben, period);

plot(t, Tom,'bo', t, Ben,'gs');
hold on;
plot(period, TomInterp, 'b-', period, BenInterp, 'g-');
hold off;

datetick('x', 'mmmdd');
title('Twins'' weights');
legend('Tom', 'Ben', 'location', 'southeast');