A = rand(800);
b = rand(800,1);
B = rand(800,9);
tic;
A\b;
toc;
A\B;
toc;