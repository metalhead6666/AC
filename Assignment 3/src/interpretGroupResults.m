function [ictalPositives, ictalNegatives, nIctalPositives, nIctalNegatives, preIctalPositives, preIctalNegatives, invalidData, expectedPositives, expectedNegatives] = interpretResults(expectedResults, results)

    ictalPositives = 0;
    ictalNegatives = 0;
    
    nIctalPositives = 0;
    nIctalNegatives = 0;
    
    preIctalPositives = 0;
    preIctalNegatives = 0;
    
    invalidData = 0;
    expectedPositives = 0;
    expectedNegatives = 0;
    
    
    for i=1:length(expectedResults)
       
        if(expectedResults(i) == 1)
            expectedPositives = expectedPositives + 1;
        else
            expectedNegatives = expectedNegatives + 1;
        end        
    end
    
    for i=1:length(expectedResults)
        if(results(i) == 1) %Ictal
            if(expectedResults(i) == 1)
                ictalPositives = ictalPositives + 1;
            else
                ictalNegatives = ictalNegatives + 1;
            end
            
        elseif(results(i) == 0)%Non-ictal
            if(expectedResults(i) == 1)
                nIctalNegatives = nIctalNegatives + 1;
            else
                nIctalPositives = nIctalPositives + 1;
            end
            
        else %results(i) == -1
            invalidData = invalidData + 1;
        end
    end
    
    
end