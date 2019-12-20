function gap_val_in_map = find_gap_val(gap_val,map_energy)
if gap_val == 0
    gap_val_in_map = 0;
    return;
end
if gap_val > max(map_energy) || gap_val < min(map_energy)
    display('Not a valid Gap Value to Find');
    gap_val_in_map = 0;
    return;
end
tmp_ind = find(map_energy == gap_val);
if ~isempty(tmp_ind)
    gap_val_in_map = map_energy(tmp_ind);
    return;
else    
    subt = abs(gap_val - map_energy);
    gap_val_in_map = min(abs(map_energy(subt == min(subt))))*sign(gap_val);
    
end