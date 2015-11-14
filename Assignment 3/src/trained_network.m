function handles = trained_network(handles)
    if exist('network.mat', 'file')
        load('network.mat');
        
    else
        handles = train_network(handles);
    end
end