function my_network = create_network(network_data)
    if(strcmp(network_data.networkName, 'Radial Basis Function'))
		%Create the network, giving it the training input and output data, and the desired goal for our training
		my_network = newrb(network_data.trainingInput, network_data.trainingOutput, network_data.goal, 1.0, network_data.hiddenLayers, 1);

    elseif(strcmp(network_data.networkName, 'Layer Recurrent'))
		%Define some of the network's specifications
		layersDelays = 1:2;
		layersSize = repmat(network_data.hiddenLayers, 1, network_data.numberLayers - 1);

		%Create the network
		my_network = layrecnet(layersDelays, layersSize, network_data.trainFunction);

		%Define specific parameters of the network
		my_network.performParam.lr = network_data.learningRate;
		my_network.trainParam.epochs = network_data.epochs;
		my_network.trainParam.show = 35;
		my_network.trainParam.goal = network_data.goal;
        my_network.trainParam.max_fail = network_data.validationChecks;
		my_network.performFcn = network_data.performanceFunction;

    elseif(strcmp(network_data.networkName, 'FeedForward'))
		%Define some of the network's specifications
		layersSize = repmat(network_data.hiddenLayers, 1, network_data.numberLayers - 1);
		
		%Create the network
		my_network = feedforwardnet(layersSize, network_data.trainFunction);

		%Define specific parameters of the network
        my_network.performParam.lr = network_data.learningRate;
		my_network.trainParam.epochs = network_data.epochs;
		my_network.trainParam.show = 35;
		my_network.trainParam.goal = network_data.goal;
        my_network.trainParam.max_fail = network_data.validationChecks;
		my_network.performFcn = network_data.performanceFunction;
    end
end