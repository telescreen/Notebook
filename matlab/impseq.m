function [x,n] = impseq(n0,n1,n2)
%impseq Generates x(n) = delta(n-n0); n1 <= n <= n2
% written by: me (2016/11/07)
% ---------------------------------------------------
n = n1:n2;
x = (n-n0) == 0;
end