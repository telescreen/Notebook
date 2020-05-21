ftheta = 3*pi/4;
u = [3; 0];
R0 = [cos(ftheta) -sin(ftheta); sin(ftheta) cos(ftheta)]; 
u0 = R0 * u;

theta = pi/2;
% Rotate theta
R = [cos(theta) -sin(theta); sin(theta) cos(theta)];

% Projection to x
P = [1 0; 0 0];

H = P*R; 
u1 = R * u0;
u2 = H * u0;
A = [u0 u1 u2];
x = A(1,:);
y = A(2,:);
t = zeros(1,length(x));
quiver(t,t,x,y);
H
P