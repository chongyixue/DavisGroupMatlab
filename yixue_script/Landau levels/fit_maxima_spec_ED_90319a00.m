% 2019-3-19 YXC
% plot max (assuming = Ed) of 2.5T map
clear x; clear y;
% map = obj_90320a00_G;
% map = invert_map(obj_90320a00_G);
map = obj_90406a00_G_crop;
% img_obj_viewer_yxc(map)

[nx,ny,nz] = size(map.map);

EDmap = map;
EDmap.name = 'EDmap';

for x = 1:nx
    for y = 1:ny
        EDmap.map(y,x,1) = fit_maximum(map,x,y,'noplot');
    end
end

img_obj_viewer_yxc(EDmap)

EDval = reshape(EDmap.map(:,:,1),nx*ny,1);
histogram(EDval,500);
hold on
xlim([132,151])
title('$E_D$ histogram','Interpreter','latex')
xlabel('$$E_D$$(mV)','Interpreter','latex')
        
        