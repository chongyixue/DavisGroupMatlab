function new_data = gap_ref(data,gapmap)

new_data = data;
e = new_data.e*1000;
% convert everything into positive to do calculation and put in real sign
% at the end
abs_e = abs(e);
abs_gapmap = abs(gapmap);
min_gap = min(min(abs_gapmap(abs_gapmap > 2)));
gap_e_index = find_zero_crossing(abs_e - min_gap); % closest index in energy vector
min_energy_index = find_zero_crossing(abs_e - min(abs_e));
n = length(e) - abs(gap_e_index - min_energy_index);

nr = size(new_data.map,1);
nc = size(new_data.map,2);

new_map = zeros(nr,nc,n);

%make new energy vector starting at 0 and ending at the maximum energy of
%old energy vector minus the minimum gap value
st_e = 0;
end_e = max(abs_e) - min_gap;
new_e = linspace(st_e,end_e,n)

end

