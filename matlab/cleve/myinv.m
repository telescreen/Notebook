function [X] = myinv(A)
% myinv Calculate the inversion of the given matrix
% dependencies: bslashtx, lutx
% written by: me (2016/11/03)

[n,~] = size(A);
X = zeros(n);
[L,U,p] = lutx(A);
eii = eye(n);

% Loop through all columns
for ii = 1:n
    t = bslashtx(L,eii(:,ii));
    X(:,ii) = bslashtx(U,t);
end

X = X(:,p);

end