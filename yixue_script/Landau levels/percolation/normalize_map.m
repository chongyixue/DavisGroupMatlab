% 2019-4-16 YXC

function map2 = normalize_map(map)

[nx,ny,~] = size(map.map);
for x = 1:nx
    for y = 1:ny
        data = squeeze(map.map(x,y,:));
%         data = data(16:end); % remove first few points that overloaded
        maxi = max(data);
        mini = min(data);
        map.map(x,y,:) = (map.map(x,y,:)-mini)./(maxi-mini);
    end
end
map.name = 'normalized';
img_obj_viewer_yxc(map)

map2 = map;


end