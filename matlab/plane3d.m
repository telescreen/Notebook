point1 = [0;0;0];
point2 = [-10;-20;10];
point3 = [10;20;10];

points = [point1 point2 point3];
fill3(points(1,:), points(2,:), points(3,:), 'r');
grid on;
alpha(0.3);