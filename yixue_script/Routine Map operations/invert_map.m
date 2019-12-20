% if our data is somehow inverted in energy (taken from huge E to small E)
% this function inverts
% YXC 2019-2-25

function invertedmap = invert_map(map)

invertedmap = map;
invertedmap.e = fliplr(map.e);
invertedmap.ave = flip(invertedmap.ave);
invertedmap.map = flip(map.map,3);


end
