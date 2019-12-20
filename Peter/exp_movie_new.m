function movie1 = exp_movie_new(map,energy,rx,ry,directory,filename,clmap,clbnd,frps,quality)
% 09_22_14: Changed to latest matlab standards for Windows 7. Files are now
% compressed. Peter Sprau

% path is combination of directory (save location) and filename of movie
% path = strcat(directory,filename,'.avi');
path = strcat(directory,filename);


[sy,sx,sz]=size(map);

% create the OBJ into which the movie will be written. Set framerate and
% quality
writerObj = VideoWriter(path, 'MPEG-4');
% writerObj = VideoWriter(path);
writerObj.FrameRate = frps;
writerObj.Quality = quality;


% open the OBJ
open(writerObj);

f1=figure('Position',[150,150,350,350]);
set(f1,'Color',[0 0 0])
set(gcf,'Renderer','zbuffer');

rx = rx(1:sx);
ry = ry(1:sy);
% rx = (1:sx);
% ry = (1:sy);
colormap(clmap)

    for i=1:sz
%         for j = 1:n
%             % subplot_tight is a special wrapper function that helps get rid of
%             % unnecessary margin space in subplots
%             subplot_tight(row_n,col_n,j, [0.02 0.02]);
        
        plane=map(:,:,i);
    
        set(gca,'Position',[0 0 1 1]);         
        axis equal;
        axis off; 

        imagesc(rx,ry,squeeze(plane)); axis off; 
        axis equal 
        hold on;
        text(0.35,0.1,[num2str(energy(i)*1000,'%6.2f'),' meV'],'Units','normalized',...
                'Fontsize',18,'Color',[1 1 1]);
        %% included to plot a circle for a certain q-vector region
%         qr = 4;
%         qc1(1) = 60-25;
%         qc1(2) = 41-25;
%         rectangle(gca, 'Position',[qc1(1)-qr,qc1(2)-qr,2*qr,2*qr],'Curvature',[1,1],'Linewidth',3,'Edgecolor','k')
        %%
        
        mini = clbnd(i,1); 
        maxi = clbnd(i,2);
        
        caxis([mini maxi]);
        
%         end
        frame = getframe(gcf);
        writeVideo(writerObj,frame);
        set(gca, 'NextPlot', 'replace');
        hold off;
    end
% close the OBJ    
close(writerObj);
end