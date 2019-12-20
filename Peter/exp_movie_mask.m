function movie1 = exp_movie_mask(map,energy,rx,ry,directory,filename,clmap,clbnd,frps,quality,ldosmask)
% XXX arpes movie maker
% XXX makes movie from one matrix block

f1=figure('Position',[100,100,450,450]);
set(f1,'Color',[0 0 0])

%main_axis = axes('Parent',f1,'Position',[.05 .05 .8 .8]);
%pp =  2.017;
%xx = [pp pp -pp -pp];
%yy = [pp -pp pp -pp];

%qpx =[NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;0.828547728235057;0.820093159579597;0.803184022268677;0.786274884957758;0.777820316302298;0.760911178991378;0.744002041680459;0.727092904369539;0.701729198403160;0.693274629747700;NaN;NaN;NaN;NaN;1.43478787878788;1.41087474747475;1.38696161616162;1.35109191919192;1.32717878787879;1.29130909090909;1.25543939393939;1.24348282828283;1.23152626262626;1.20761313131313;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN];
%qpy = [NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;0.828547728235056;0.820093159579597;0.803184022268677;0.786274884957758;0.777820316302298;0.760911178991378;0.744002041680459;0.727092904369539;0.701729198403160;0.693274629747700;NaN;NaN;NaN;NaN;0;0;0;0;0;0;0;0;0;0;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN];
[sy,sx,sz]=size(map);
colormap(clmap)

% if ~isempty(clmap)
%     colormap(clmap)
% else
%     % generate a histogram for difmap.  Will be used for setting
%     % color axis limit.  
%     n = 1000;
%     tmp_layer = reshape(map(:,:,1),nx*ny,1);
%     tmp_std = std(tmp_layer);
%     % pick a common number of bins based on the largest spread of values in
%     % one of the layers
%     n1 = abs((max(tmp_layer) - min(tmp_layer)))/(2*tmp_std)*1000;
%     n = max(n,floor(n1));    
% 
%     clear tmp_layer n1 tmp_std;
% 
%     [histo.freq(1,1:n), histo.val(1,1:n)] = hist(reshape(difmap(:,:,1),nx*ny,1),n);
% 
%     histo.size = [nx ny 1];
% 
%     %get the initial color map
%     color_map = struct2cell(load([color_map_path 'Blue1.mat']));
%     % color_map = color_map{1};
%     %initialize color limit values for each layer in caxis
%     caxis_val = zeros(1,2);
% 
%     caxis_val(1,1) = min(histo.val(1,:)); % min value for each layer
%     if isnan(caxis_val(1,1))
%         caxis_val(1,1) = 0;
%     end
%     caxis_val(1,2) = max(histo.val(1,:)); % max value for each layer
%     if isnan(caxis_val(1,2))
%         caxis_val(1,2) = 0;
%     end
% 
%     h = fspecial('average',[3,3]);
%     msmap = imfilter(difmap,h,'replicate');
%     %Create the plot
%     fh = img_plot3(msmap);
%     ah = gca;
% 
%     % imagesc((difmap(:,:,1)));
%     % colormap(color_map); axis off; axis equal; shading flat;
%     caxis([caxis_val(1,1) caxis_val(1,2)])
% 
%     %update the UserData in the figure object to store caxis information
%     set(fh,'UserData',caxis_val);
%     %%
%     palette_sel_dialogue(fh,color_map);  
% 
%     data_histogram_dialogue(1,histo,fh,ah);
% 
%     keyboard
% end



path = strcat(directory,filename);

    for i=1:sz
        plane=map(:,:,i);
         ldosmask1 = ldosmask{i};
%        plot(qpx(i),qpy(i),'yx','MarkerEdgeColor','y','MarkerFaceColor','r',...
%               'LineWidth',2,'MarkerSize',10);
%        hold on;       
         set(gca,'Position',[0 0 1 1]);         
         axis equal; 
         axis off; 
         
      %   plot(xx,yy,'ro','MarkerFaceColor','r','MarkerEdgeColor','r',...
      %       'MarkerSize',5);  
       %  hold on;
        % pcolor(rx,ry,squeeze(plane)); shading flat ; axis off; axis equal 
       

        
%          imagesc(rx,ry,squeeze(plane));
        imagesc(squeeze(plane));
         axis off; 
         axis equal 
         hold on
         
        nof = length(ldosmask1);
        for cc=1:nof
            dum1 = ldosmask1{cc};
            dum2 = dum1{1};
            xxx = dum2(:,2);
            yyy = dum2(:,1);
            plot(xxx,yyy,'-','Color','r','LineWidth',2);
            % line is needed to close the region
            line([xxx(end),xxx(1)],[yyy(end),yyy(1)],'Color','r','LineStyle','-','LineWidth',2);
        %     line([fitx(i),fitx(i)],[fity(i)-1,fity(i)+1],'Linewidth',2,'Color','m');
        %     line([fitx(i)-1,fitx(i)+1],[fity(i),fity(i)],'Linewidth',2, 'Color','m');
        end
        hold off

         
         
         hold on;
%          text(0.4,0.1,[num2str(energy(i)*1000,'%6.2f'),' meV'],'Units','normalized',...
%                 'Fontsize',18,'Color',[1 1 1]);
            
        text(0.4,0.1,[num2str(energy(i),'%6.1f'),' T'],'Units','normalized',...
                'Fontsize',18,'Color','w');
            
        
        %[mini,maxi]=get_colormap_limits(plane,clbnd(1)/100,clbnd(2)/100,'h');
        mini = clbnd(i,1); maxi = clbnd(i,2);
        caxis([mini maxi]);
        movie1(:,i)=getframe(gcf);
        set(gca, 'NextPlot', 'replace');
        hold off;
    end
    movie2avi(movie1, path,'compression','None','fps',frps,'quality',quality);
end