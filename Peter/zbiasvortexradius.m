function [mvmap, mv2map]=zbiasvortexradius(data, vfeat, radius,vortexnumber,vdata)

piezo = data.r(2) - data.r(1);

radius = radius / (piezo);

ev = data.e;
map = data.map;

le = length(ev);

for j = 1:le
    if ev(j) == 0
        zlayer = j;
    end
end


zbmap = map(:,:,zlayer);
[nx,ny,nz] = size(zbmap);

opsmap = zeros(nx, ny, 1);

for i=1:nx
    for j=1:ny
        opsmap(i,j,1) = (mean(map(i,j,6:8))+mean(map(i,j,14:16)))/2 - mean(map(i,j,10:12));
    end
end

zbmap = opsmap;



mvmap = zeros(nx, ny, 1);
mv2map = zeros(nx, ny, 1);


change_color_of_STM_maps(zbmap);

hold on

for i=1:vortexnumber
    
    mx = vfeat.fity(i);
    my = vfeat.fitx(i);
    cm=circlematrix([nx,ny],radius,mx,my);
    mvmap = mvmap + double(cm);
    
    cm2=circlematrix([nx,ny],2*radius,mx,my);
    mv2map = mv2map + double(cm2);
    
    w = 2*radius;
    h = w;
    x = mx - radius;
    y = my - radius;
    rectangle('position',[y,x,w,h],...
        'Curvature',[1,1],'EdgeColor','r','LineStyle','-','LineWidth',2);
    
    w = 4*radius;
    h = w;
    x = mx - 2*radius;
    y = my - 2*radius;
    rectangle('position',[y,x,w,h],...
        'Curvature',[1,1],'EdgeColor','r','LineStyle','-.','LineWidth',2);
    
    
end

mvmap = im2bw(mvmap,0);
mv2map = im2bw(mv2map,0);



hold off

figure, img_plot5(mvmap)
figure, img_plot5(mv2map)


change_color_of_STM_maps(vdata.map);

hold on

for i=1:vortexnumber
    
    mx = vfeat.fity(i);
    my = vfeat.fitx(i);
    
    w = 2*radius;
    h = w;
    x = mx - radius;
    y = my - radius;
    rectangle('position',[y,x,w,h],...
        'Curvature',[1,1],'EdgeColor','r','LineStyle','-','LineWidth',2);
    
    w = 4*radius;
    h = w;
    x = mx - 2*radius;
    y = my - 2*radius;
    rectangle('position',[y,x,w,h],...
        'Curvature',[1,1],'EdgeColor','r','LineStyle','-.','LineWidth',2);
    
    
end


hold off





end

