
count = 0;
for i=1:size(Cu_index)
    if gap_map_pos(Cu_index(i,1),Cu_index(i,2)) == 0
        count = count + 1;
    end
end
counts
clear i