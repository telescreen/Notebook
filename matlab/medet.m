function [det] = medet(A)
% MYDET Calculate the determinant of matrix A
% Dependencies: lutx
% Written by: me (2016/11/03)
[~,U,~,sig] = lutx(A);
det = sig * prod(diag(U));
end