function [avevortex, avehalo] = halovortices(vdata,tdata,nomagmap,magmap,vpos,data)


ev = data.e;
[nx,ny,nz] = size(vdata.map);


nomagmap = nomagmap(29:253,29:253,:);
magmap = magmap(29:253,29:253,:);


opsmap = zeros(nx, ny, 1);

for i=1:nx
    for j=1:ny
%         opsmap(i,j,1) = (mean(nomagmap(i,j,17:25))+mean(nomagmap(i,j,41:49)))/2 - mean(nomagmap(i,j,26:40));
        opsmap(i,j,1) = (mean(nomagmap(i,j,13:21))+mean(nomagmap(i,j,45:53)))/2 - mean(nomagmap(i,j,29:37));
    end
end

% figure, img_plot4(opsmap);

change_color_of_STM_maps(tdata.map,'no');

%%
hold on


for i=1:9
    
    if i <= 4
        cstring = 'r';
    else
        cstring = 'y';
    end

    rectangle('position',[vpos(i,1),vpos(i,2),vpos(i,3)-vpos(i,1),vpos(i,4)-vpos(i,2)],...
        'EdgeColor',cstring,'LineStyle','-','LineWidth',2);
    

end

hold off

%%
change_color_of_STM_maps(vdata.map,'no');

hold on


for i=1:9
    
    if i <= 4
        cstring = 'r';
    else
        cstring = 'y';
    end

    rectangle('position',[vpos(i,1),vpos(i,2),vpos(i,3)-vpos(i,1),vpos(i,4)-vpos(i,2)],...
        'EdgeColor',cstring,'LineStyle','-','LineWidth',2);
    

end

hold off




%%
change_color_of_STM_maps(opsmap,'no');

hold on


for i=1:9
    
    if i <= 4
        cstring = 'r';
    else
        cstring = 'y';
    end

    rectangle('position',[vpos(i,1),vpos(i,2),vpos(i,3)-vpos(i,1),vpos(i,4)-vpos(i,2)],...
        'EdgeColor',cstring,'LineStyle','-','LineWidth',2);
    

end

hold off

avevortex_topo = zeros(vpos(1,4) - vpos(1,2)+1,vpos(1,3) - vpos(1,1)+1,1);
avehalo_topo = zeros(vpos(1,4) - vpos(1,2)+1,vpos(1,3) - vpos(1,1)+1,1);
avevortex = zeros(vpos(1,4) - vpos(1,2)+1,vpos(1,3) - vpos(1,1)+1,1);
avehalo = zeros(vpos(1,4) - vpos(1,2)+1,vpos(1,3) - vpos(1,1)+1,1);

for i=1:4
    
    figure, img_plot5(tdata.map(vpos(i,2):vpos(i,4),vpos(i,1):vpos(i,3),1));
    figure, img_plot4(vdata.map(vpos(i,2):vpos(i,4),vpos(i,1):vpos(i,3),1));
    
    avevortex_topo = avevortex_topo + tdata.map(vpos(i,2):vpos(i,4),vpos(i,1):vpos(i,3),1);
    avevortex = avevortex + vdata.map(vpos(i,2):vpos(i,4),vpos(i,1):vpos(i,3),1);
end

for i=5:9
    
    figure, img_plot5(tdata.map(vpos(i,2):vpos(i,4),vpos(i,1):vpos(i,3),1));
    figure, img_plot4(vdata.map(vpos(i,2):vpos(i,4),vpos(i,1):vpos(i,3),1));
    
    avehalo_topo = avehalo_topo + tdata.map(vpos(i,2):vpos(i,4),vpos(i,1):vpos(i,3),1);
    avehalo = avehalo + vdata.map(vpos(i,2):vpos(i,4),vpos(i,1):vpos(i,3),1);
end

change_color_of_STM_maps(avevortex_topo/4);

change_color_of_STM_maps(avevortex/4);

change_color_of_STM_maps(avehalo_topo/5);

change_color_of_STM_maps(avehalo/5);






end