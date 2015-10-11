% create the T file, for the data training output

function create_T_file()
    load('PerfectArial.mat');
    T = [];
    
    for i = 1:5
        T = horzcat(T, Perfect);
    end
    
    save('T.mat', 'T');
end