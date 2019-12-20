% 2018-11-14 by Andrey Kostin
% open two maps (or topo), find one distict point
% input_pt -----point on the map to be translated
% reference_pt---point on the fixed map

function [ translated_map ] = translate_map(input, reference_pt, input_pt)
%translate input map to match reference map

input_map = input.map;

if strcmp(input.var,'T')
    [nx,ny] = size(input.map);
    nz = 1;
else
    [nx,ny,nz] = size(input.map);
end

map = zeros(nx,ny,nz);

t_vect = reference_pt - input_pt;

for i=1:nz
    map(:,:,i)=imtranslate(input_map(:,:,i),t_vect);
end

translated_map = input;
translated_map.map = map;

end

