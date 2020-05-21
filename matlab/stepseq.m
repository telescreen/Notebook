function [x,n] = stepseq(n0,n1,n2)
%impseq Generates x(n) = u(n-n0); n1 <= n <= n2
% written by: me (2016/11/07)
% ---------------------------------------------------
n = n1:n2;
x = (n-n0) >= 0;
end