function export_map(map,energy,rx,ry,format,directory,filename,clmap,clbnd)
figure('Color',[0 0 0],'Position',[100,100,450,450]);
sz = size(energy);

pp = 2.017;
xx = [pp pp -pp -pp];
yy = [pp -pp pp -pp];

for k=1:sz(2)
    set(gca, 'NextPlot', 'replace');
    set(gca,'Position',[0 0 1 1]); 
   
    %plot(xx,yy,'ro','MarkerEdgeColor','r','MarkerFaceColor','r',...
    %           'MarkerSize',5);
    axis equal;% hold on;
    pcolor(rx,ry,squeeze(map(:,:,k)));colormap(clmap); shading flat; 
    %text(0.37,0.05,[num2str(energy(k)*1000,'%6.2f'),' meV'],'Units','normalized',...
    %            'Fontsize',18,'Color',[1 1 1]);
    [min,max]= get_colormap_limits((map(:,:,k)),clbnd(1)/100,clbnd(2)/100,'h');
    caxis([min max]);
    A = getframe(gcf);
    path = strcat(directory,filename,'_',num2str(k,'%2.0f'),'_',num2str(energy(k)),'.',format);
    %
    imwrite(A.cdata,path,format);    
end
    
