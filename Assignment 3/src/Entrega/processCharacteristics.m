function reducedInput = processCharacteristics(inputData, targetData, numberCharacteristics)

    inputSize = size(inputData);
    inputChars = inputSize(2);
    
    %Se o n�mero de caracter�sticas for inv�lido, considera-se todas as
    %caracter�sticas
    if(numberCharacteristics > inputChars || numberCharacteristics < 1)
        numberCharacteristics = inputChars;
    end
    
    result = horzcat(inputData, targetData);
    sizeResult = size(result);
    
    %Correla��es
    [r,~] = corrcoef(result);
    
    %Analisar os valores de correla��o da coluna 30 da matriz, que
    %relaciona o output com todas as caracter�sticas do input
    correlations = r(sizeResult(2), 1:inputChars);
    
    %Usar valor absoluto por causa dos negativos
    correlations = abs(correlations);
    
    %Orden�-las e selecionar as necess�rias
    [~, indexes] = sort(correlations, 'descend');
    reducedInput = inputData(:, indexes(1:numberCharacteristics));
end