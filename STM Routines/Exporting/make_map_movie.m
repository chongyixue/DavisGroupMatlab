function movie1 = make_map_movie(map,kx,ky,energy,co,py,px)
% XXX arpes movie maker
% XXX makes movie from one matrix block

f1=figure('Position',[100,100,500,450]);
set(f1,'Color',[0 0 0])

main_axis = axes('Parent',f1,'Position',[.05 .05 .8 .8]);

%axitos = axes('Parent',f1,'Position',[.65 .86 0.25  .08]);
%ave=squeeze(sum(sum(map)));


[sy,sx,sz]=size(map);
grid=linspace(min(kx),max(kx),15);
[gridy,gridx]=ndgrid(grid,grid');

for i=1:sz
    plane=map(:,:,i);
    e = energy(i)*1000;

    axes(main_axis)
    hold off

    pcolor(kx,ky,plane); shading flat ;  %colorbar
    hold on 

    title([num2str(e,'%6.1f'),' meV'],...
        'Fontsize',28,'Color',[1 1 1]);

    [mini,maxi]=get_colormap_limits(plane,0.05/100,1/100,'h');

    caxis([mini maxi])
    axis off;
    axis equal
%%%%%%%%%%%%%%%%%%%%%%
    hold on; plot(py,px,'ro','MarkerEdgeColor','k',...
    'MarkerFaceColor','r',...
    'MarkerSize',5);
    colorbar
    
%axis([31 45 66 80]);
%%%%%%%%%%%%%%%%%%%%%%%
   colormap(co)
%     axes(axitos)
%     plot(energy,ave,'b-', 'linewidth',2)
%     hold on
%     plot(e,ave(i),'r+','Markersize',10,'linewidth',2)
%     hold off;
%     axis off
    movie1(:,i)=getframe(gcf);
    
end