%%%%%%%
% CODE DESCRIPTION: Mean value subtract for each row
%                       
% INPUT: The function accepts a data matrix 
%
% CODE HISTORY
% 080721 MHH Created

function new_data = row_subt(data)

[sx sy] = size(data);
for i=1:sx
    new_data(i,:) = data(i,:) - mean(data(i,:));
end