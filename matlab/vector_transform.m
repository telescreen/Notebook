theta = pi/2;
u = [1;0];
% Rotate theta angle
R = [cos(theta) -sin(theta); sin(theta) cos(theta)];
% Project to theta line
P = [cos(theta)^2 cos(theta)*sin(theta); cos(theta)*sin(theta) sin(theta)^2];
% Reflection through pi/3 line
H = [2*cos(theta)^2-1 2*cos(theta)*sin(theta); 
     2*cos(theta)*sin(theta), 2*sin(theta)^2-1];
v1 = R * u;
%v2 = R * v1;
v3 = P * u;
v4 = H * u;
A = [u v1 v3 v4];
x = A(1,:); y = A(2,:);
size_A = size(A);
t = zeros(1,size_A(2));
quiver(t,t,x,y);