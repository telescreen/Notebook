function list_perm_mat(dim)
    p = perms(1:dim);
    for i = 1:length(p)
        a = zeros(dim);
        %disp(p(i,:));
        for j = 1:length(p(i,:))
            a(j,p(i,j)) = 1;
        end
        disp(a);
    end
end