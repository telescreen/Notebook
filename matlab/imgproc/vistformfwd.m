function vistformfwd(tform , wdata, zdata, N)
%VISTFORMFWD Visualize forward geometric transform. 
%   VISTFORMFWD(TFORM, WRANGE, ZRANGE, N) shows 2 plots: an N-by-N grid in
%   the W-Z coordinate system, and the spatially transformed grid in the
%   X-Y coordinate system. WRANGE and ZRANGE are two-element vectors
%   specifying the desired range for the grid. N can be ommitted, in which
%   case the default value is 10.
if nargin < 4
    N = 10;
end
% Create the w-z grid and transform it.
[w, z] = meshgrid(linspace(wdata(1), zdata(2), N), ...
                  linspace(wdata(1), zdata(2), N));
wz = [w(:) z(:)];
%xy = tformfwd([w(:) z(:)], tform);
xy = transformPointsForward(tform, [w(:) z(:)]);

% Calculate the minimum and maximum values of w and x, as well as z and y.
% There are used so the two plots can be displayed using the same scale.
x = reshape(xy(:,1), size(w));
y = reshape(xy(:,2), size(z));
wx = [w(:); x(:)];
wxlimits = [min(wx) max(wx)];
zy = [z(:); y(:)];
zylimits = [min(zy) max(zy)];
% Create the w-z plot.
subplot(1,2,1); 
plot(w,z,'b');
hold on;
plot(w', z', 'b');
hold off;
xlim(wxlimits);
ylim(zylimits);
set(gca, 'XAxisLocation', 'top')
xlabel('w'); ylabel('z');

% Create the x-y plot
subplot(1,2,2);
plot(x,y,'b');
hold on;
plot(x', y', 'b');
hold off;
xlim(wxlimits);
ylim(zylimits);
set(gca, 'XAxisLocation', 'top');
xlabel('x'), ylabel('y')
end