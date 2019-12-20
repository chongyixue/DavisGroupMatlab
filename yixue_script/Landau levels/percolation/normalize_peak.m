%2019-5-3 YXC

function normalized = normalize_peak(map,startmV,endmV)

original = extract_layers(map,startmV,endmV,'noplot');
normalized = normalize_map_subtract_slope(original);



end

