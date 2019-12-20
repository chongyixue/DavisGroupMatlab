% 2019-6-12 YXC
% given a referrence peakmVarray that has peaks in some indices
% return the llpeaks, in the same order as given by peakmVarray


function [llshifted,index_assignment] = shift_peak_assignment(llmatrix,method,x,y,peakmV_array)

unordered_array = llmatrix(method,x,y,:);
index_assignment = arrange_index(unordered_array,peakmV_array);
len = length(peakmV_array);
llshifted = zeros(len,1);
for i = 1:len
    index = index_assignment(i);
    if index > 0
        llshifted(index) = unordered_array(i);
    end
end


end
