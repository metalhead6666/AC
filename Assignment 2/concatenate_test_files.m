% Function to concatenate all test cases

function concatenate_test_files()
    PFinal = [];
    
    for i = 1 : 10
        load(sprintf('P_%d', i));
        PFinal = horzcat(PFinal, P);
    end
    
    save('PFinal.mat', 'PFinal');
    load('PerfectArial.mat');
    PFinal = horzcat(PFinal, Perfect);
    save('PFinalPerfect.mat', 'PFinal');
end