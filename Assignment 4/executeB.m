% execute model B

choice = input_function('Select the reference method:\n1-Square\n2-Sin\n3-Sawtooth\n',[1,2,3]);

fuzzymodel = readfis('ControllersB/fuzzymodel.fis');
model_name = 'ModelsB/';

if choice == 1
    model_name = strcat(model_name, 'square.slx');
elseif choice == 2
    model_name = strcat(model_name, 'sine.slx');
else
    model_name = strcat(model_name, 'sawtooth.slx');
end

uiopen(model_name, 1);