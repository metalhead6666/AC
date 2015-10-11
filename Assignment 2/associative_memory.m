function PAssociative = associative_memory(data)
    load('PerfectArial.mat');
    load('PFinal500.mat');
    
    % replicate the perfect matrix 50 times, to be the same size as the
    % train cases
    T = repmat(Perfect, 1, 50);
    
    option = 0;
    
    while(option ~= 1 && option ~= 2)
        option = input('\nLearning method:\n    1 - Hebb Rule\n    2 - Pseudo-Inverse Method\n');
    end
    
    % applies the transpose or the pseudo-inverse
    if(option == 1)
        PAssociative = T * PFinal';
    else
        PAssociative = T * pinv(PFinal);
    end
    
    PAssociative = PAssociative * data;
end