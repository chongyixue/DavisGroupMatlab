% YXC 2019-4-24 show where in spatial location the ave spec come from

function map2 = show_average_contribution(map)

[~,~,nz] = size(map.map);
map2 = map;

for layer = 1:nz
%     maxx = max(max(map.map(:,:,layer)));
%     minn = min(min(map.map(:,:,layer)));
%     thres = minn + 0.6*(maxx-minn);
    filter  = map.map(:,:,layer) > map.ave(layer);
%     filter  = map.map(:,:,layer)> thres;
    map2.map(:,:,layer) = filter;
end
img_obj_viewer_yxc(map2)
end

