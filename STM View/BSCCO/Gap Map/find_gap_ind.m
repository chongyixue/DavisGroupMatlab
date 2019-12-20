function gap_ind_in_map = find_gap_ind(gap_val,map_energy)
gap_val_in_map = find_gap_val(gap_val,map_energy);
if gap_val_in_map == 0
    gap_ind_in_map = 0;
    return;
else
    gap_ind_in_map = find(map_energy == gap_val_in_map);
end

end