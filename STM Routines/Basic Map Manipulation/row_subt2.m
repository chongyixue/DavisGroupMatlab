%%%%%%%
% CODE DESCRIPTION: Mean value subtract for each row
%                       
% INPUT: The function accepts a data matrix 
%
% CODE HISTORY
% 080721 MHH Created

function new_data = row_subt2(data)
new_data = data;
[sx sy sz] = size(data.map);
for k = 1:sz
    for i=1:sx
        new_data.map(i,:,k) = data.map(i,:,k) - mean(data.map(i,:,k));
    end
end