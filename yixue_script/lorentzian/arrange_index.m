% 2019-6-12 YXC
% given an array and a reference array, return an array of indices to be
% scrambled
% indexarray,array,ref all have same length
% array are assumed to be arranged in ascending order, and end with 0
% i.e. array = [1,3,4,6,0,0,0]
% ref assumed to be eg [0,0,2,3,5,0,0]

function indexarray = arrange_index(array,ref)

n_nonzero = sum(array~=0);

[delta_ls,index_ls] = locate_index(array,ref);
index_ls = index_ls(1:n_nonzero); 
delta_ls = delta_ls(1:n_nonzero);

new_index_ls = index_ls;

for i = 2:n_nonzero
    if index_ls(i)>0
        if index_ls(i)-index_ls(i-1) < 0.5
            if delta_ls(i)>delta_ls(i-1)
                new_index_ls(i) = -1;
            else
                new_index_ls(i-1) = -1;
            end
        end
    end
end

index_ls = new_index_ls;
indexarray = zeros(length(array),1)-1;
indexarray(1:n_nonzero) = index_ls;

end


function [delta,index] = locate_index(array,number)
[delta,index] = min(abs(array-number'));
end


