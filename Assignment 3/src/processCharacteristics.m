function reducedInput = processCharacteristics(inputData, targetData, numberCharacteristics)

    inputSize = size(inputData);
    inputChars = inputSize(2);
    
    %Se o número de características for inválido, considera-se todas as
    %características
    if(numberCharacteristics > inputChars || numberCharacteristics < 1)
        numberCharacteristics = inputChars;
    end
    
    result = horzcat(inputData, targetData);
    sizeResult = size(result);
    
    %Correlações
    [r,~] = corrcoef(result);
    
    %Analisar os valores de correlação da coluna 30 da matriz, que
    %relaciona o output com todas as características do input
    correlations = r(sizeResult(2), 1:inputChars);
    
    %Usar valor absoluto por causa dos negativos
    correlations = abs(correlations);
    
    %Ordená-las e selecionar as necessárias
    [~, indexes] = sort(correlations, 'descend');
    reducedInput = inputData(:, indexes(1:numberCharacteristics));
end