% 2019-3-13 YXC
% plot minimum (assuming = Ed) of 0T map
clear x; clear y;
%map = invert_map(obj_90329a00_G);
map  = obj_90403a00_G;
% img_obj_viewer_yxc(map)

[nx,ny,nz] = size(map.map);

minimap = map;
minimap.name = 'minimap';

for x = 1:nx
    for y = 1:ny
        minimap.map(y,x,1) = fit_minimum(map,x,y,'noplot');
    end
end

img_obj_viewer_yxc(minimap)

EDval = reshape(minimap.map(:,:,1),nx*ny,1);
histogram(EDval,300);
hold on
% xlim([125,151])
title('$E_D$ histogram','Interpreter','latex')
xlabel('$$E_D$$(mV)','Interpreter','latex')
        
        