function net = neural_network()
    % creates the neural network and trains it
    file = 0;
    
    while(file ~= 1 && file ~= 2)
        file = input('\nNumber of train cases:\n    1 - 500\n    2 - 200\n');
    end
    
    if(file == 1)
        load('PFinal500.mat');
    else
        load('PFinal200.mat');
    end
    
    option = 0;
    
    while(option ~= 1 && option ~= 2 && option ~= 3)
        option = input('\nActivation Function:\n    1 - Binary\n    2 - Linear\n    3 - Sigmoidal\n');
    end
    
    if(option == 1)
        activation_function = 'hardlim';
        learn_method = 'learnp';
    elseif(option == 2)
        activation_function = 'purelin';
        learn_method = 'learngd';
    else
        activation_function = 'logsig';
        learn_method = 'learngd';
    end
    
    % number of different digits, 10
    nA = 10;
    [nP, nCases] = size(PFinal);
    
    % generate T
    T = zeros(10, nCases);
    
    for i = 0 : nCases - 1
        T(mod(i, 10) + 1, i + 1) = 1;
    end
 
    %create neural network
    net = newp(ones(nP, 1) * [0 1], nA, activation_function, learn_method);
    
    %initialize network parameters (random)
	net.IW{1, 1} = 0.1 * rand(10, 256); 
	net.b{1, 1} = 0.1 * rand(10, 1);
    
    %enter training parameters
    net.performParam.ratio = 0.5;       % learning rate 
	net.trainParam.epochs = 1000;       % maximum epochs 
	net.trainParam.show = 35;           % show
	net.trainParam.goal = 1e-6;         % goal=objective 
	net.performFcn = 'sse';             % criterion 
    
    %train the neural network
    net = train(net, PFinal, T);
end