function [trainingInput, trainingOutput, testInput, testOutput] = prepareDataSets(handles)
    disp('yey');
    
    %Carregar dados do ficheiro de treino
    load(handles.trainingFile);
    
    %Alterar o Target
    Trg = modify_target(Trg);
    
    %Filtrar características
    FeatVectSel = processCharacteristics(FeatVectSel, Trg, handles.characteristics);
    
    %Indices das crises
    crysisIndexes = getCrysisIndexes(Trg);
    
    %Dados de treino
    [trainingInput, trainingOutput] = getPercentageData(crysisIndexes, Trg, FeatVectSel, handles.percentageTraining);
    
    
    %Carregar dados do ficheiro de teste
    load(handles.testFile);
    
    %Alterar o Target
    Trg = modify_target(Trg);
    
    %Filtrar características
    FeatVectSel = processCharacteristics(FeatVectSel, Trg, handles.characteristics);
    
    %Indices das crises
    crysisIndexes = getCrysisIndexes(Trg);
    
    numberCrysis = size(crysisIndexes);
    numberCrysis = numberCrysis(1);
    
    temp = 100 - handles.percentageTest;
    
    startTest = round(numberCrysis * (temp/100));
    startTest = crysisIndexes(startTest) + 1;
    testInput = FeatVectSel(startTest:end,:);
    testInput = testInput';
    
    testOutput = Trg(startTest:end,:);
    testOutput = testOutput';
    
    %Preparar os outputs por causa dos três neurónios na camada de saída
    
    [linhas,~] = size(trainingOutput);
    tempTrain = zeros(linhas, 3);
    [linhas,~] = size(testOutput);
    tempTest = zeros(linhas, 3);
    
    for i=1:length(trainingOutput)
        if(trainingOutput(1,i)==0) %Non-ictal
            tempTrain(i,:) = [1,0,0];
        elseif(trainingOutput(1,i) == 1) %ictal
            tempTrain(i,:) = [0,0,1];
        else %pre-ictal
            tempTrain(i,:) = [0,1,0];
        end
    end
    
    for i=1:length(testOutput)
        if(testOutput(1,i)==0) %Non-ictal
            tempTrain(i,:) = [1,0,0];
        elseif(testOutput(1,i) == 1) %ictal
            tempTrain(i,:) = [0,0,1];
        else %pre-ictal
            tempTrain(i,:) = [0,1,0];
        end
    end
    
    trainingOutput = tempTrain;
    testOutput = tempTest;    
end
