function [trainingInput, trainingOutput, testInput, testOutput] = prepareDataSets(handles)
    disp('yey');
    
    %Carregar dados do ficheiro de treino
    load(handles.trainingFile);
    
    %Alterar o Target
    Trg = modify_target(Trg);
    
    %Filtrar características
    FeatVectSel = processCharacteristics(FeatVectSel, Trg, handles.characteristics);
    
    
end
