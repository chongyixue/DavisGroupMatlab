function movie1 = exp_movie_multipanel(fdata,row_n,col_n,directory,filename,frps,quality)
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
        
        imagesc(squeeze(plane));colormap(col_map); caxis(clbnd); axis equal; axis off;
        
        %% make one energy the oppsoite
%         if j==2 
%             text(0.35,0.05,[num2str(-energy1(i),'%6.2f'),' meV'],'Units','normalized',...
%             'Fontsize',16,'Color',[1 1 0],'FontWeight','Bold');
%         else
%             text(0.35,0.05,[num2str(energy1(i),'%6.2f'),' meV'],'Units','normalized',...
%                 'Fontsize',16,'Color',[1 1 0],'FontWeight','Bold');
%         end
%%
        text(0.35,0.05,[num2str(energy1(i),'%6.2f'),' meV'],'Units','normalized',...
            'Fontsize',16,'Color',[1 1 0],'FontWeight','Bold');
        
        freezeColors;
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