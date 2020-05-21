function p = manualhist
% MANUALHIST Generates a bimodal histogram interactively

% Initialize
repeats = true;
quitnow = 'x';

% Compute the default histogram in case the user quits before estimating at
% least one histogram
p = twomodegauss(0.15, 0.05, 0.75, 0.05, 1, 0.07, 0.002);

% Cycle until an x is input
while repeats
    s = input('Enter m1, sig1, m2, sig2, A1, A2, k or x to quit:', 's');
    if s == quitnow
        break;
    end
    % Convert the input string to a vector of numerical values and
    % verify the number of inputs
    v = str2num(s);
    disp(numel(v));
    if numel(v) ~= 7
        disp('Incorrect number of inputs');
        continue;
    end
    p = twomodegauss(v(1), v(2), v(3), v(4), v(5), v(6), v(7));
    % Start a new figure and scale the axes. Specifying only xlim leaves
    % ylim on auto
    figure, plot(p); xlim([0 255]);
end
end