m = -1;
vv = 0;
for i = 1:(2^16-1)
    v = bitget(i,1:16);
    mt = reshape(v,4,4);
    if m < det(mt)
        m = det(mt);
        vv = v;
    end
end
fprintf('maximum determinant of 4x4 matrix is: %f\n', m);
fprintf('Matrix\n');
disp(reshape(vv,4,4));