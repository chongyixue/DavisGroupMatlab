function movie1 = exp_movie_new_rhominus(map,energy,rx,ry,directory,filename,clmap,clbnd,frps,quality)
% 09_22_14: Changed to latest matlab standards for Windows 7. Files are now
% compressed. Peter Sprau

f1=figure('Position',[50,100,2*500,1*500],'MenuBar','none');
set(f1,'Color',[0.2 0.2 0.2])


% path is combination of directory (save location) and filename of movie
% path = strcat(directory,filename,'.avi');
path = strcat(directory,filename,'.mp4');


[sy,sx,sz]=size(map);

% create the OBJ into which the movie will be written. Set framerate and
% quality
writerObj = VideoWriter(path, 'MPEG-4');
% writerObj = VideoWriter(path);
writerObj.FrameRate = frps;
writerObj.Quality = quality;


% open the OBJ
open(writerObj);

% f1=figure('Position',[150,150,350,350]);
% set(f1,'Color',[0 0 0])
% set(gcf,'Renderer','zbuffer');

rx = rx(1:sx);
ry = ry(1:sy);
% rx = (1:sx);
% ry = (1:sy);
clmap(119:139,:) = ones(21, 3);

colormap(clmap)

s = strcat('C:\Users\Peter\OneDrive\FeSe data related to ms\Splusminus_analysis\60716A00\smooth_rho_4p.mat');
dummy = load(s);
ev = dummy.ev;
ev = [ev(1), ev, 0];

map = cat(3, map(:,:, 1), map, zeros(sx, sy));
smooth_rho_4p = dummy.smooth_rho_4p;
    
sz = length(ev);
clbnd(31, :) = [-100, 100];
clbnd(32, :) = [-100, 100];
    for i=1:sz
        for j = 1:2
            % subplot_tight is a special wrapper function that helps get rid of
            % unnecessary margin space in subplots
            subplot_tight(1,2,j, [0.1 0.1]);
%             subplot(1,2,j);
            if j==1
            
                plot(ev(2:end-1), smooth_rho_4p,'k.','MarkerSize',25);
                hold on
                plot([ev(sz+1-i) ev(sz+1-i)],[-0.7 1.1],'-b','LineWidth',2);
                
                plot([0 4.5],[0 0],'--k','LineWidth',2);
                
                
                
                axes2 = gca;
                axes2.XTick = linspace(0,5,6);
                axes2.YTick = linspace(-0.6,1,5);
%                 axes2.YTick = [-0.6, -0.2, 0, 0.2, 0.6, 1.0];
%                 dummy1 = get(axes2, 'Position');
%                 dummy1(2) = 0.3;
%                 dummy1(4) = 0.5;
%                 axes2.Position = dummy1;
                dummy1 = get(axes2, 'Position');

                dummy1(1) = dummy1(1);
                dummy1(2) = dummy1(2)+ 0.05;
                axes2.Position = dummy1;
        
                axes2.FontSize = 16;
                axes2.FontWeight = 'bold';
                axis([0 4.5 -0.7 1.1]);
                xlabel('E [meV]', 'Fontsize',16,'Color',[0 0 0],'FontWeight','Bold');
                ylabel('\rho_-(E)', 'Fontsize',16,'Color',[0 0 0],'FontWeight','Bold');
                figw
                
                mini = clbnd(i,1); 
                maxi = clbnd(i,2);
        
                caxis([mini maxi]);
                colb = colorbar('southoutside');
                colb.Label.String = '\rho_-(q, E)';
                colb.Ticks = [-100, 0, 100];
                colb.FontSize = 16;
                colb.FontWeight = 'Bold';
%                 axis tight
                set(gca, 'NextPlot', 'replace');
                hold off;
                
        
            else 
        plane=map(:,:,sz+1-i);
        
        
        imagesc(squeeze(plane)); 
        axis square; axis off;
        imagesc(squeeze(plane)); 
        axis square; axis off;
        
        axes3 = gca;
        dummy1 = get(axes2, 'Position');
        dummy2 = get(gca, 'Position');
        
        dummy2(1) = dummy2(1)- 0.25;
        dummy2(2) = dummy2(2)- 0.05;
        dummy2(3) = 0.9;
        dummy2(4) = 0.9;
        axes3.Position = dummy2;

        text(0.4,0.05,[num2str(ev(sz+1-i),'%6.2f'),' meV'],'Units','normalized',...
            'Fontsize',16,'Color',[0 0 0],'FontWeight','Bold');
        
        hold on
        %% included to plot a circle for a certain q-vector region
        qr = 4;
        qc1(1) = 60-25;
        qc1(2) = 41-25;
        rectangle(gca, 'Position',[qc1(1)-qr,qc1(2)-qr,2*qr,2*qr],'Curvature',[1,1],'Linewidth',3,'Edgecolor','k')
        text(qc1(1)+5, qc1(2), 'p_1', 'Fontsize',14,'Color',[0 0 0],'FontWeight','Bold');
        
        bpx1 = 34 - 25;
        bpy1 = 51 - 25;
        bpx2 = 68 - 25;
        bpy2 = 51 - 25;
        bpx3 = 51 - 25;
        bpy3 = 34 - 25;
        bpx4 = 51 - 25;
        bpy4 = 68 - 25;
        
        plot([bpx1, bpx2, bpx3, bpx4], [bpy1, bpy2, bpy3, bpy4], 'k.', 'MarkerSize', 24)
        text(bpx1-5, bpy1-3, '(-\pi/a,\pi/b)', 'Fontsize',14,'Color',[0 0 0],'FontWeight','Bold');
        text(bpx2-4.4, bpy2-3, '(\pi/a,-\pi/b)', 'Fontsize',14,'Color',[0 0 0],'FontWeight','Bold');
        text(bpx3-4.4, bpy3-3, '(\pi/a,\pi/b)', 'Fontsize',14,'Color',[0 0 0],'FontWeight','Bold');
        text(bpx4-5, bpy4-3, '(-\pi/a,-\pi/b)', 'Fontsize',14,'Color',[0 0 0],'FontWeight','Bold');
        %%
        
        
        mini = clbnd(i,1); 
        maxi = clbnd(i,2);
        
        caxis([mini maxi]);
%         colb = colorbar('southoutside');
%         colb.Label.String = '\rho_-(q, E)';
%         colb.Ticks = [-100, 0, 100];
%         colb.FontSize = 16;
%         colb.FontWeight = 'Bold';
        freezeColors;
        
%         set(gca,'Position',[0 0 1 1]);         
%         axis equal;
%         axis off; 
% 
%         imagesc(rx,ry,squeeze(plane)); axis off; 
%         axis equal 
%         hold on;
%         text(0.4,0.1,[num2str(energy(i)*1000,'%6.2f'),' meV'],'Units','normalized',...
%                 'Fontsize',18,'Color',[0 0 0]);
        
        
        
        set(gca, 'NextPlot', 'replace');
        hold off;
            end
        
        end
        frame = getframe(gcf);
        writeVideo(writerObj,frame);
        
    end
% close the OBJ    
close(writerObj);
end