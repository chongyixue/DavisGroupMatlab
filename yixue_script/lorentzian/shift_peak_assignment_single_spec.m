% 2019-6-12 YXC
% given a referrence peakmVarray that has peaks in some indices
% return the llpeaks, in the same order as given by peakmVarray


function [llshifted,index_assignment] = shift_peak_assignment_single_spec(peakenergy,peakmV_array)

index_assignment = arrange_index(peakenergy,peakmV_array);
len = length(peakenergy);
llshifted = zeros(len,1);
for i = 1:len
    item = index_assignment(i);
    if item > 0
        llshifted(item) = peakenergy(i);
    end
end


end
