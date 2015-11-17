function handles = train_network(handles)
    %Create desired network
    %handles = struct('networkName', handles.networkName, 'trainFunction', handles.trainFunction, 'performanceFunction', handles.performanceFunction, 'goal', handles.goal, 'epochs', handles.epochs, 'learningRate', handles.learningRate, 'numberLayers', handles.numberLayers, 'numberLayers', handles.numberLayersSizes, 'trainingInput', handles.training_input, 'trainingOutput', handles.training_output, 'activationFunction', handles.activationFunction, 'validationChecks', round(handles.epochs/2));

    %handles.network = createNetwork(network_data);
    if(strcmp(handles.networkName, 'Radial Basis Function'))
		%Create the network, giving it the training input and output data, and the desired goal for our training
		handles.network = newrb(handles.trainingInput, handles.trainingOutput, handles.goal, 1.0, handles.numberLayers, 1);

    elseif(strcmp(handles.networkName, 'Layer Recurrent'))
		%Define some of the network's specifications
		layersDelays = 1:2;
		layersSize = repmat(handles.numberLayers, 1, handles.numberLayers - 1);

		%Create the network
		handles.network = layrecnet(layersDelays, layersSize, handles.trainFunction);

		%Define specific parameters of the network
		handles.network.performParam.lr = handles.learningRate;
		handles.network.trainParam.epochs = handles.epochs;
		handles.network.trainParam.show = 35;
		handles.network.trainParam.goal = handles.goal;
        handles.network.trainParam.max_fail = round(handles.epochs/2);
		handles.network.performFcn = handles.performanceFunction;
        
        %handles.network = train(handles.network, handles.trainingInput, handles.trainingOutput, 'useGPU', 'yes');
        handles.network = train(handles.network, handles.trainingInput, handles.trainingOutput);

    elseif(strcmp(handles.networkName, 'FeedForward'))
		%Define some of the network's specifications
		layersSize = repmat(handles.numberLayers, 1, handles.numberLayers - 1);
		
		%Create the network
		handles.network = feedforwardnet(layersSize, handles.trainFunction);

		%Define specific parameters of the network
        handles.network.performParam.lr = handles.learningRate;
		handles.network.trainParam.epochs = handles.epochs;
		handles.network.trainParam.show = 35;
		handles.network.trainParam.goal = handles.goal;
        handles.network.trainParam.max_fail = round(handles.epochs/2);
		handles.network.performFcn = handles.performanceFunction;
        
        %handles.network = train(handles.network, handles.trainingInput, handles.trainingOutput, 'useGPU', 'yes');
        handles.network = train(handles.network, handles.trainingInput, handles.trainingOutput);
    end
end