function Y = rowsaxpy(x, A, y)
%% Calculate y = y + A*x
% y: m-row vector
% x: n-row vector
% A: m x n matrix

% Get the row and column from current vector
[m,n] = size(A);
Y = zeros(m,1);
for i = 1:m
    for j = 1:n
        Y(i) = Y(i) + y(i) + A(i,j)*x(j);
    end
end
end