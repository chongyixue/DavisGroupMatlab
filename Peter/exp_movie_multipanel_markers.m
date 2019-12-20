function movie1 = exp_movie_multipanel_markers(fdata,row_n,col_n,directory,filename,frps,quality)
% changed by peter
% path = strcat(directory,filename);
% make figure so that it scales with number of maps to be plotted
f1=figure('Position',[50,100,col_n*350,row_n*350],'MenuBar','none');
set(f1,'Color',[0.2 0.2 0.2])

%% changed by peter
% path is combination of directory (save location) and filename of movie
% path = strcat(directory,filename,'.avi');
path = strcat(directory,filename,'.mp4');

% create the OBJ into which the movie will be written. Set framerate and
% quality
writerObj = VideoWriter(path, 'MPEG-4');
% writerObj = VideoWriter(path);
writerObj.FrameRate = frps;
writerObj.Quality = quality;
% open the OBJ
open(writerObj);
%%





[nr,nc,nz]=size(fdata.map1);
energy1 = fdata.e1;
n = row_n*col_n;


for i=1:nz
    for j = 1:n
        % subplot_tight is a special wrapper function that helps get rid of
        % unnecessary margin space in subplots
        subplot_tight(row_n,col_n,j, [0.02 0.02]);
        eval(['plane = fdata.map' num2str(j) '(:,:,i);']);
        eval(['col_map = fdata.clmap' num2str(j) ';']);
        eval(['clbnd = fdata.clbnd' num2str(j) '(i,:);']);
        
        eval(['data = fdata.markers' num2str(j) ';']);
        
        imagesc(squeeze(plane));colormap(col_map); caxis(clbnd); axis equal; axis off;
        text(0.35,0.05,[num2str(energy1(i),'%6.2f'),' meV'],'Units','normalized',...
            'Fontsize',16,'Color',[1 1 0],'FontWeight','Bold');
        if j==1
            text(0.45,0.95,'g(r)','Units','normalized',...
            'Fontsize',16,'Color',[1 1 0],'FontWeight','Bold');
        elseif j==2
            text(0.44,0.95,'g(q)','Units','normalized',...
            'Fontsize',16,'Color',[1 1 0],'FontWeight','Bold');
        elseif j==3
            text(0.41,0.95,'JDOS','Units','normalized',...
            'Fontsize',16,'Color',[1 1 0],'FontWeight','Bold');
        end
        freezeColors;
        hold on
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
                plot(txp,tyn,'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 3);
                %%
%                 plot(txp,tyn,'Marker', 'd', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','r', 'LineWidth', 1);
           else
%                plot([txp txp txn txn],[typ tyn typ tyn] ,'.c','MarkerSize',30);
%                plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','c', 'LineWidth', 1);
%%
%                 plot([txp txp txn txn],[typ tyn typ tyn],'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
                plot(txp,tyn,'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 3);
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
                plot(txp,tyn,'Marker', 'x', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
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
                plot(txp,tyn,'Marker', 'x', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
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
                plot(txp,tyn,'Marker', 'x', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
                %%
                %                 plot(txp,tyn,'Marker', 'd', 'LineStyle', 'none', 'MarkerSize', 10,'MarkerEdgeColor','k','MarkerFaceColor',[245,197,44]/255, 'LineWidth', 1);
           else
%                plot([txp txp txn txn],[typ tyn typ tyn] ,'.c','MarkerSize',30);
%                plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 's', 'LineStyle', 'none', 'MarkerSize', 10,'MarkerEdgeColor','k','MarkerFaceColor','c', 'LineWidth', 1);
%%
%                 plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 'x', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
                plot(txp,tyn,'Marker', 'x', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
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
        
        set(gca, 'NextPlot', 'replace');
        
        hold off;
    end
    
    movie1(:,i)=getframe(gcf);
    % changed by peter
    writeVideo(writerObj,movie1(:,i));
end

% close the OBJ    
close(writerObj);
% movie2avi(movie1, path,'compression','none','fps',frps,'quality',quality);
end