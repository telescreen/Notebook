function simplefixedpoint = simplefixedpoint(func, guess, eps, maxiter)
% Calculate root of function 'func' using simple fixed point algorithm
% Written: me (2016/09/21)
if ~exist('eps', 'var') || isempty(eps)
    eps = 0.5e-3;
end
if ~exist('maxiter', 'var') || isempty(maxiter)
    maxiter = 500;
end
iter = 0;
while true
    iter = iter + 1;
    old_guess = guess;
    guess = func(guess);
    if guess ~= 0
        ea = abs((guess - old_guess)/guess);
    end
    if ea < eps || iter > maxiter
        break;
    end
    %fprintf('Iteration %d: guess = %6f, ea = %6f\n', iter, guess, ea);
end
simplefixedpoint = guess;
end