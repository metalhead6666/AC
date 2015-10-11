function return_value =  myclassify(data, filled)

    choice = 0;
    while( (choice ~= 1) && (choice ~= 2))
        choice = input('What kind of architecture do you want?\n 1-Associative Memory + Classifier\n 2-Only Classifier\n');
    end

    if(choice==1)
        P2 = associative_memory(data);
    else
        P2 = data;
    end

    %Create and train network
    net = neural_network();

    %Validate the neural network with the input
    validate = sim(net,P2);

    %Set result into the format needed at ocr_fun
    nCases = length(filled);
    result = -ones(1,nCases);

    for n_case = 1 : nCases
        case_result = find(validate(:,filled(n_case)) == max(validate(:,filled(n_case))));
        if length(case_result) == 1
            result(n_case) = case_result;
        end
    end
end
