function result = input_function(string, array)
    result = 0;
    
    while ~ismember(result, array)
        result = input(string);
    end
end