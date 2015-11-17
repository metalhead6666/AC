function results = convertResults(results)
    [~, numberCols] = size(results);    

    %Convert values in results to 0 or 1.
    for i=1:numberCols
        if(results(1,i)>=0.5)
            results(1,i) = 1;
        else
            results(1,i) = 0;
        end

        if(results(2,i)>=0.5)
            results(2,i) = 1;
        else
            results(2,i) = 0;
        end

        if(results(3,i)>=0.5)
            results(3,i) = 1;
        else
            results(3,i) = 0;
        end
    end
    
end
