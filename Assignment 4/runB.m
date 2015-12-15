% script to execute the part B of the assignment
clc

if exist('uy.mat', 'file') == 2
    load('uy.mat');
elseif exist('u', 'var') == 1 && exist('y', 'var') == 1
    %donothing
else
    uiopen('ModelsB/newModel.slx', 1);
    return;
end

valor = 4;
[u_size, ~] = size(u);
[y_size, ~] = size(y);
matrix = zeros(u_size - valor + 1, 7);

for i = 1 : 3
    matrix(:,i) = y(valor - i:y_size - i);
    matrix(:,i+3) = u(valor - i:u_size - i);
end

matrix(:,7) = y(valor:y_size);

save('matrix.dat', 'matrix', '-ascii');