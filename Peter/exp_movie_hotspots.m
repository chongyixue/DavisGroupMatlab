function movie1 = exp_movie_hotspots(map,energy,rx,ry,directory,filename,clmap,clbnd,frps,quality, data)
% 09_22_14: Changed to latest matlab standards for Windows 7. Files are now
% compressed. Peter Sprau

% path is combination of directory (save location) and filename of movie
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
colormap(clmap)

data.r = rx;

    for i=1:sz
        plane=map(:,:,i);
    
        set(gca,'Position',[0 0 1 1]);         
        axis equal;
        axis off; 

        imagesc(squeeze(plane)); axis off; 
        axis equal 
        hold on;
        text(0.35,0.1,[num2str(energy(i)*1000,'%6.2f'),' meV'],'Units','normalized',...
                'Fontsize',18,'Color',[1 1 0]);

        mini = clbnd(i,1); 
        maxi = clbnd(i,2);
        
        caxis([mini maxi]);
        
        %%
        p = 14;
        x1 = data.x(i);
        y1 = data.y(i);
       if(isreal(x1)&&isreal(y1))
%            hold on
           N = length(data.r);
           txp = (N-1)/(data.r(end)-data.r(1))*(x1-data.r(end))+N;
           txn = (N-1)/(data.r(end)-data.r(1))*(-x1-data.r(end))+N;
           typ = (N-1)/(data.r(end)-data.r(1))*(y1-data.r(end))+N;
           tyn = (N-1)/(data.r(end)-data.r(1))*(-y1-data.r(end))+N;
           %plot([x1 x1 -x1 -x1],[y1 -y1 y1 -y1] ,'.r','MarkerSize',30);
           if round((data.e(i)*10000)) == -24 || round((data.e(i)*10000)) == 24
%                 plot([txp txp txn txn],[typ tyn typ tyn] ,'dc','MarkerSize',30);
%                 plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 'd', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','c', 'LineWidth', 1);
%%
%                 plot([txp txp txn txn],[typ tyn typ tyn],'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
                plot(txp,tyn,'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
                %%
%                 plot(txp,tyn,'Marker', 'd', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','r', 'LineWidth', 1);
           else
%                plot([txp txp txn txn],[typ tyn typ tyn] ,'.c','MarkerSize',30);
%                plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','c', 'LineWidth', 1);
%%
%                 plot([txp txp txn txn],[typ tyn typ tyn],'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
                plot(txp,tyn,'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
                %%%                plot(txp,tyn,'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','r', 'LineWidth', 1);
           end
           %patch([1 1 5],[1 5 5],'red');
           %drawArrow([txp typ],[txn tyn]);
           %plot([0,10],[0,10] ,'.r','MarkerSize',30);
%            hold off
       end
       
       x2 = data.x2(i);
       y2 = data.y2(i);
       if(isreal(x2)&&isreal(y2))
%            hold on
           N = length(data.r);
           txp = (N-1)/(data.r(end)-data.r(1))*(x2-data.r(end))+N;
           txn = (N-1)/(data.r(end)-data.r(1))*(-x2-data.r(end))+N;
           typ = (N-1)/(data.r(end)-data.r(1))*(y2-data.r(end))+N;
           tyn = (N-1)/(data.r(end)-data.r(1))*(-y2-data.r(end))+N;
           %plot([x1 x1 -x1 -x1],[y1 -y1 y1 -y1] ,'.r','MarkerSize',30);
%            plot([txp txp txn txn],[typ tyn typ tyn] ,'.c','MarkerSize',30);
%            plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','c', 'LineWidth', 1);
%%
%                 plot([txp txp txn txn],[typ tyn typ tyn],'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
                plot(txp,tyn,'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
                %%
           %            plot(txp,tyn,'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','r', 'LineWidth', 1);
           %patch([1 1 5],[1 5 5],'red');
           %drawArrow([txp typ],[txn tyn]);
           %plot([0,10],[0,10] ,'.r','MarkerSize',30);
%            hold off
       end
       
       x3 = data.x3(i);
       y3 = data.y3(i);
       if(isreal(x3)&&isreal(y3))
%            hold on
           N = length(data.r);
           txp = (N-1)/(data.r(end)-data.r(1))*(x3-data.r(end))+N;
           txn = (N-1)/(data.r(end)-data.r(1))*(-x3-data.r(end))+N;
           typ = (N-1)/(data.r(end)-data.r(1))*(y3-data.r(end))+N;
           tyn = (N-1)/(data.r(end)-data.r(1))*(-y3-data.r(end))+N;
           %plot([x1 x1 -x1 -x1],[y1 -y1 y1 -y1] ,'.r','MarkerSize',30);
%            plot([txp txp txn txn],[typ tyn typ tyn] ,'.c','MarkerSize',30);
%            plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','c', 'LineWidth', 1);
%%
%                 plot([txp txp txn txn],[typ tyn typ tyn],'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
                plot(txp,tyn,'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
                %%
                %            plot(txp,tyn,'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','r', 'LineWidth', 1);
           %patch([1 1 5],[1 5 5],'red');
           %drawArrow([txp typ],[txn tyn]);
           %plot([0,10],[0,10] ,'.r','MarkerSize',30);
%            hold off
       end

        x4 = data.x4(i);
       y4 = data.y4(i);
       if(isreal(x4)&&isreal(y4))
%            hold on
           N = length(data.r);
           txp = (N-1)/(data.r(end)-data.r(1))*(x4-data.r(end))+N;
           txn = (N-1)/(data.r(end)-data.r(1))*(-x4-data.r(end))+N;
           typ = (N-1)/(data.r(end)-data.r(1))*(y4-data.r(end))+N;
           tyn = (N-1)/(data.r(end)-data.r(1))*(-y4-data.r(end))+N;
           %plot([x1 x1 -x1 -x1],[y1 -y1 y1 -y1] ,'.r','MarkerSize',30);
%            plot([txp txp txn txn],[typ tyn typ tyn] ,'.c','MarkerSize',30);
%            plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 's', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','c', 'LineWidth', 1);
%%
%                 plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 'x', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
                plot(txp,tyn,'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
                %%
                %            plot(txp,tyn,'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor',[245,197,44]/255, 'LineWidth', 1);
           %patch([1 1 5],[1 5 5],'red');
           %drawArrow([txp typ],[txn tyn]);
           %plot([0,10],[0,10] ,'.r','MarkerSize',30);
%            hold off
       end

        x5 = data.x5(i);
       y5 = data.y5(i);
       if(isreal(x5)&&isreal(y5))
%            hold on
           N = length(data.r);
           txp = (N-1)/(data.r(end)-data.r(1))*(x5-data.r(end))+N;
           txn = (N-1)/(data.r(end)-data.r(1))*(-x5-data.r(end))+N;
           typ = (N-1)/(data.r(end)-data.r(1))*(y5-data.r(end))+N;
           tyn = (N-1)/(data.r(end)-data.r(1))*(-y5-data.r(end))+N;
           %plot([x1 x1 -x1 -x1],[y1 -y1 y1 -y1] ,'.r','MarkerSize',30);
%            plot([txp txp txn txn],[typ tyn typ tyn] ,'.c','MarkerSize',30);
%            plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 's', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','c', 'LineWidth', 1);
%%
%                 plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 'x', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
                plot(txp,tyn,'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
                %%
                %            plot(txp,tyn,'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor',[245,197,44]/255, 'LineWidth', 1);
           %patch([1 1 5],[1 5 5],'red');
           %drawArrow([txp typ],[txn tyn]);
           %plot([0,10],[0,10] ,'.r','MarkerSize',30);
%            hold off
       end

        x6 = data.x6(i);
       y6 = data.y6(i);
       if(isreal(x6)&&isreal(y6))
%            hold on
           N = length(data.r);
           txp = (N-1)/(data.r(end)-data.r(1))*(x6-data.r(end))+N;
           txn = (N-1)/(data.r(end)-data.r(1))*(-x6-data.r(end))+N;
           typ = (N-1)/(data.r(end)-data.r(1))*(y6-data.r(end))+N;
           tyn = (N-1)/(data.r(end)-data.r(1))*(-y6-data.r(end))+N;
           %plot([x1 x1 -x1 -x1],[y1 -y1 y1 -y1] ,'.r','MarkerSize',30);
%            plot([txp txp txn txn],[typ tyn typ tyn] ,'.c','MarkerSize',30);
           if round(data.e(i)*10000) == -3 || round(data.e(i)*10000) == 3
%                 plot([txp txp txn txn],[typ tyn typ tyn] ,'dc','MarkerSize',30);
%                 plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 'd', 'LineStyle', 'none', 'MarkerSize', 10,'MarkerEdgeColor','k','MarkerFaceColor','c', 'LineWidth', 1);
%%
%                 plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 'x', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
                plot(txp,tyn,'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
                %%
                %                 plot(txp,tyn,'Marker', 'd', 'LineStyle', 'none', 'MarkerSize', 10,'MarkerEdgeColor','k','MarkerFaceColor',[245,197,44]/255, 'LineWidth', 1);
           else
%                plot([txp txp txn txn],[typ tyn typ tyn] ,'.c','MarkerSize',30);
%                plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 's', 'LineStyle', 'none', 'MarkerSize', 10,'MarkerEdgeColor','k','MarkerFaceColor','c', 'LineWidth', 1);
%%
%                 plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 'x', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
                plot(txp,tyn,'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
                %%
                %                plot(txp,tyn,'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', 10,'MarkerEdgeColor','k','MarkerFaceColor',[245,197,44]/255, 'LineWidth', 1);
           end
           %patch([1 1 5],[1 5 5],'red');
           %drawArrow([txp typ],[txn tyn]);
           %plot([0,10],[0,10] ,'.r','MarkerSize',30);
%            hold off
       end
       
       xqd = data.xqd(i);
       yqd = data.yqd(i);
       if(isreal(xqd)&&isreal(yqd))
           hold on
           N = length(data.r);
           txp = (N-1)/(data.r(end)-data.r(1))*(xqd-data.r(end))+N;
           txn = (N-1)/(data.r(end)-data.r(1))*(-xqd-data.r(end))+N;
           typ = (N-1)/(data.r(end)-data.r(1))*(yqd-data.r(end))+N;
           tyn = (N-1)/(data.r(end)-data.r(1))*(-yqd-data.r(end))+N;
           
           plot([txp txp txn txn],[typ tyn typ tyn],'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
           
           %patch([1 1 5],[1 5 5],'red');
           %drawArrow([txp typ],[txn tyn]);
           %plot([0,10],[0,10] ,'.r','MarkerSize',30);
           hold off
       end
        %%
        
        frame = getframe(gcf);
        writeVideo(writerObj,frame);
        set(gca, 'NextPlot', 'replace');
        hold off;
    end
% close the OBJ    
close(writerObj);
end