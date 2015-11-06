function target = modify_target(target)
    filter = find(target == 1);
    
    target(filter(1) - 301 : filter(1) - 1) = 2;
    [filter_size, ~] = size(filter);
    
    for row = 2 : filter_size
        if filter(row) - 1 ~= 1
            target(filter(row) - 301 : filter(row) - 1) = 2;
        end
    end
end