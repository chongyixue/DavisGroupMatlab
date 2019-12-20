% 2019-2-26
% ED_map 

map = invert_map(obj_90225a00_G);
map = subtract_background(map);

[nx,ny,nz] = size(map.map);

LLmap = map;
LLmap.name = 'LLmap2';

for x = 1:nx
    for y = 1:ny
        LLmap.map(y,x,1) = extract_ED(map,x,y,'noplot');
    end
end

img_obj_viewer_yxc(LLmap)



