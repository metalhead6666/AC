function crysis = getCrysisIndexes(Trg)

    crysis = [];
    aux = Trg;
    
    last = 0;
    cont = 1;
    
    tempOne = 1;
    
    while(~isempty(tempOne))
       %find first crysis
       tempOne = find(aux==1,1);
       
       if(isempty(tempOne))
           break;
       end
       
       aux = Trg((tempOne+last+1): length(Trg));
       
       tempTwo = find(aux==0,1);
       crysis(cont, 1) = tempOne+last;
       
       crysis(cont, 2) = tempOne+last+tempTwo;
       aux = Trg((tempOne+last+tempTwo+1): length(Trg));
       
       last = tempOne+last+tempTwo;
       cont = cont+1;        
    end
end