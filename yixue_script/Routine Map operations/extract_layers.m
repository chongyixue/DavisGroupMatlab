% YXC 2019-4-24 extract layers from map to make new map
% input: start mV, end mV

function map2 = extract_layers(map,startmV,endmV,varargin)

energies = (map.e)*1000;
[~,start] = min(abs(startmV-energies));
[~,fin] = min(abs(endmV-energies));

map2 = map;
map2.e = map.e(start:fin);
map2.map = map2.map(:,:,start:fin);
if isempty(map2.ave) ~= 1
    map2.ave = map2.ave(start:fin);
end
if nargin<4
    img_obj_viewer_test(map2)
end
end




