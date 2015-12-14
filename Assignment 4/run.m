% script to execute the part A of the assignment

reference_function = input_function('Select the reference function:\n1-Square\n2-Sin\n', [1,2]);
controller_type = input_function('Select the controller:\n1-Mamdani\n2-Sugeno\n', [1,2]);
rules = input_function('Select the number of rules:\n1-9 rules\n2-25 rules\n', [1,2]);

if controller_type == 1
    defuzzification_method = input_function('Select the defuzzification method:\n1-Centroid\n2-Mom\n', [1,2]);
else
    defuzzification_method = input_function('Select the defuzzification method:\n1-Wtaver\n2-Wtsum\n', [1,2]);
end

perturbation = input_function('Select the perturbation:\n1-No perturbation\n2-Actuator\n3-Charge\n', [1,2,3]);

% load the pretended model and controller
model_name = 'Models/model_';
controller_name = 'Controllers/';

if controller_type == 1
    controller_name = strcat(controller_name, 'mamdani_');        
    
    if defuzzification_method == 1
        controller_name = strcat(controller_name, 'centroid_');
    else
        controller_name = strcat(controller_name, 'mom_');
    end
else
    controller_name = strcat(controller_name, 'sugeno_');
    
    if defuzzification_method == 1
        controller_name = strcat(controller_name, 'wtaver_');
    else
        controller_name = strcat(controller_name, 'wtsum_');
    end
end

if rules == 1
    controller_name = strcat(controller_name, '9_');
else
    controller_name = strcat(controller_name, '25_');
end

controller_name = strcat(controller_name, 'gaussmf.fis');

if reference_function == 1
	model_name = strcat(model_name, 'square');
else
	model_name = strcat(model_name, 'sin');
end

if perturbation == 1
    model_name = strcat(model_name, '.slx');
elseif perturbation == 2
	model_name = strcat(model_name, '_actuator.slx');
elseif perturbation == 3
	model_name = strcat(model_name, '_charge.slx');
end

controller = readfis(controller_name);
uiopen(model_name, 1);