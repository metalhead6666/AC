function handles = trained_network(handles)
    %    if exist('network.mat', 'file')
    %        load('network.mat');
    %        
    %    else
    %        handles = train_network(handles);
    %    end

    %Run sim with the test data set
    networkResults = sim(handles.network, handles.testInput);

    %Convert the results of the execution to an array of binary values
    networkResults = convertResults(networkResults);
    
    %Handle the classification, according to the defined type: Single or
    %Group
    if(strcmp(handles.classificationType,'group'))
        %GROUP
        
        %Expected output for neural network
        expectedOutput = translateOutputToGroup(handles.testOutput, handles.groupLimitOnes, handles.windowSize);
        
        %The output of our neural network
        gotOutput = translateOutputToGroup(networkResults, handles.groupLimitOnes, handles.windowSize);
        
        %Actually compare the output we got from the neural network's
        %execution with the expected output for the given test set
        [ictalPositives, ictalNegatives, nIctalPositives, nIctalNegatives, preIctalPositives, preIctalNegatives, invalidData, expectedPositives, expectedNegatives] = interpretGroupResults(expectedOutput, gotOutput);   
    
    else
        %SINGLE
        
        %Actually compare the output we got from the neural network's
        %execution with the expected output for the given test set
        [ictalPositives, ictalNegatives, nIctalPositives, nIctalNegatives, preIctalPositives, preIctalNegatives, invalidData, expectedPositives, expectedNegatives] = interpretResults(handles.testOutput, networkResults);   
    end
    
    %Compute sensitivity and specificity for this test
    sensitivity = ictalPositives / (ictalPositives + nIctalNegatives);
    specificity = ictalNegatives / (ictalNegatives + nIctalPositives);
    
    set(handles.sensitivityField,'String', strcat('Sensitivity:', num2str(sensitivity)));
    set(handles.specificityField,'String', strcat('Specificity:', num2str(specificity)));
    
    set(handles.ictalPosField,'String', strcat('Ictal Positives:', num2str(ictalPositives)));
    set(handles.ictalNegField,'String', strcat('Ictal Negatives:', num2str(ictalNegatives)));
    
    set(handles.preIctalPosField,'String', strcat('Pre-ictal Positives:', num2str(preIctalPositives)));
    set(handles.preIctalNegField,'String', strcat('Pre-ictal Negatives:', num2str(preIctalNegatives)));
    
    set(handles.nonIctalPosField,'String', strcat('Non-ictal Positives:', num2str(nIctalPositives)));
    set(handles.nonIctalNegField,'String', strcat('Non-ictal Negatives:', num2str(nIctalNegatives)));
    
    set(handles.invalidDataField,'String', strcat('Invalid Data:', num2str(invalidData)));
    
    set(handles.expectedPosField, 'String', strcat('Expected Positives:', num2str(expectedPositives)));
    set(handles.expectedNegField, 'String', strcat('Expected Negatives:', num2str(expectedNegatives)));   

end