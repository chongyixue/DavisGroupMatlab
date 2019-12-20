function save_STMdata_layers_as_images(map,energy,rx,ry,directory,filename,clmap,clbnd,fileformat)
% 09_22_14: Changed to latest matlab standards for Windows 7. Files are now
% compressed. Peter Sprau

% path is combination of directory (save location) and filename of movie
path = strcat(directory,filename);


[sy,sx,sz]=size(map);

    for i=1:sz
        
        
        f1=figure('Position',[150,150,350,350]);
        set(f1,'Color',[0 0 0])
        set(gcf,'Renderer','zbuffer');

        rx = rx(1:sx);
        ry = ry(1:sy);
        colormap(clmap)
        
        
        plane=map(:,:,i);
    
        set(gca,'Position',[0 0 1 1]);         
        axis equal;
        axis off; 

        imagesc(rx,ry,squeeze(plane)); axis off; 
        axis equal 
        
        mini = clbnd(i,1); 
        maxi = clbnd(i,2);
        
        caxis([mini maxi]);
        
        hold on;
        text(0.35,0.1,[num2str(energy(i)*1000,'%6.2f'),' meV'],'Units','normalized',...
                'Fontsize',18,'Color',[0.99 0.99 0.99]);
            
        
         slstr = strcat(path,num2str(energy(i)*1000,'%6.2f'),'meV','.',fileformat);
        
         set(gcf, 'PaperPositionMode', 'auto');
        saveas(gcf, slstr, fileformat);
        
        
        set(gca, 'NextPlot', 'replace');
        hold off;
        
              
       
    end
    

end