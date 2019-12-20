% 2019-4-8 YXC

map = obj_90428a00_G;

edmap = map;
[nx,ny,nz] = size(map.map);

for x = 1:nx
    for y = 1:ny
        [~,index] = max(edmap.map(x,y,1:39));
        edmap.map(x,y,1) = map.e(index)*1000;
    end
end
img_obj_viewer_yxc(edmap)


ed = edmap.map(:,:,1);
ed = reshape(ed,nx*ny,1);
histogram(ed,80);
hold on
xlim([130,150])
title('$E_D$ histogram','Interpreter','latex')
xlabel('$$E_D$$(mV)','Interpreter','latex')