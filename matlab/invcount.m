function invc = invcount(arr)
    invc = 0;
    for i = 1:length(arr)
        for j = i+1:length(arr)
            if arr(i) > arr(j)
                invc = invc + 1;
            end
        end
    end
end