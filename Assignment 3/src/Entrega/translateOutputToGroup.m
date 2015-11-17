function groupedOutput = translateOutputToGroup(output, groupLimitOnes, windowSize)
    
    groupedOutput = [];
    
    sizeOutput = size(output);
    numberCols = sizeOutput(2);
    
    for i=1:numberCols - windowSize
        
        %Check if current window has at least one valid value
        numberInvalids = length(find(output(1,i:i+windowSize-1) == 0 & output(2,i:i+windowSize-1) == 0 & output(3,i:i+windowSize-1) == 0));
        numberInvalids = numberInvalids + length(find(output(1,i:i+windowSize-1) == 1 & output(2,i:i+windowSize-1) == 1 & output(3,i:i+windowSize-1) == 1));
        numberInvalids = numberInvalids + length(find(output(1,i:i+windowSize-1) == 1 & output(2,i:i+windowSize-1) == 1 & output(3,i:i+windowSize-1) == 0));
        numberInvalids = numberInvalids + length(find(output(1,i:i+windowSize-1) == 1 & output(2,i:i+windowSize-1) == 0 & output(3,i:i+windowSize-1) == 1));
        numberInvalids = numberInvalids + length(find(output(1,i:i+windowSize-1) == 0 & output(2,i:i+windowSize-1) == 1 & output(3,i:i+windowSize-1) == 1));
        
        if(numberInvalids == windowSize)
            groupedOutput(i) = -1;
            
        else
            numberOnes = length(find(output(1,i:i + windowSize - 1) == 0 & output(2,i:i + windowSize - 1) == 0 & output(1,i:i + windowSize - 1) == 1));
            groupedOutput(i) = numberOnes >= groupLimitOnes;
        end
    end       
end