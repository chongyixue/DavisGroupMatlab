function hist2d_viewer(in_data)
%  Create and then hide the GUI as it is being constructed.

f = figure('NumberTitle', 'off',...                            
              'Position',[150,150,355,393],...
              'MenuBar', 'none',...
              'WindowButtonMotionFcn',@get_axes_pos,...
              'Pointer','crosshair',...
              'Renderer','zbuffer',...
              'Visible','off');
              %'CloseRequestFcn',@img_obj_closereq);
color_map_path = 'C:\Analysis Code\MATLAB\STM View\Color Maps\';             

% make a copy of in_data in guidata - copy by reference invoked so only one copy
% of object data exists in guidata
guidata(f,in_data);
[nr nc nz] = size(getfield(guidata(f),'histo'));
obj_name = getfield(guidata(f),'name');
obj_var = getfield(guidata(f),'var');
obj_energy = getfield(guidata(f),'e');

set(f,'Name',[obj_name '-' obj_var]);

coord_tb = uicontrol('Style','text',...                
                'Position',[87,5,265,35],...
                'UserData',[0 0]);

   str={['coord: ' '( ' num2str(0, '%6.5f') ' , '  num2str(0,'%6.5f') ' )',...
   '   ' 'pixel: ' '( ' num2str(0,'%6.0f') ' , ' num2str(0,'%6.0f') ' )' ],...
   ['z: ' '( ' num2str(0, '%6.5f') ' )']};
   set(coord_tb,'String',str);
            
   bias = uicontrol('Style','text',...
                     'String','Bias (mV)',...
                     'Position',[3,27,65,15]);
   energy_list = uicontrol('Style','popupmenu',...       
          'String', num2str(1000*obj_energy','%10.2f'),...
          'Value', 1,...
          'Position',[3,0,80,25],...
          'Callback',{@plot_Callback});
         %'String', num2str(1000*data.e','%10.2f'),...
      
   ha = axes('Units','Pixels','DrawMode','fast','Position',[35,75,312,312]);  
   align([bias, energy_list],'Center','None');   
   
   % allow zoom function for figure;
   zh = zoom(f); set(zh,'Enable','off');
   
   %%%%%%%%%%%%%%%%%%%%%%%%%% Initialize the GUI%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Change units to normalized so components resize automatically.
set([f,ha],'Units','normalized');
data = guidata(f);
% generate a histogram for each layer of data.  Will be used for setting
% color axis limit.  Also include the dimensions of img_obj.
n = 1000;
for k = 1:nz
    tmp_layer = reshape(data.histo(:,:,k),nr*nc,1);
    tmp_std = std(tmp_layer);
    % pick a common number of bins based on the largest spread of values in
    % one of the layers
    n1 = abs((max(tmp_layer) - min(tmp_layer)))/(2*tmp_std)*1000;
    n = max(n,floor(n1));    
end
clear tmp_layer n1 tmp_std

for k=1:nz
    [histo.freq(k,1:n) histo.val(k,1:n)] = hist(reshape(data.histo(:,:,k),nr*nc,1),n);
end
histo.size = [nr nc nz];

%get the initial color map
color_map = struct2cell(load([color_map_path 'Blue2.mat']));
color_map = color_map{1};
%initialize color limit values for each layer in caxis
caxis_val = zeros(nz,2);
for k=1:nz;
      caxis_val(k,1) = min(histo.val(k,:)); % min value for each layer
      if isnan(caxis_val(k,1))
          caxis_val(k,1) = 0;
      end
      caxis_val(k,2) = max(histo.val(k,:)); % max value for each layer
      if isnan(caxis_val(k,2))
          caxis_val(k,2) = 0;
      end
end
%update the UserData in the figure object to store caxis information
set(f,'UserData',caxis_val);

%Create a plot in the axes.
%pcolor(data.map(:,:,1)); 
%imagesc((data.histo(:,:,1)));
xmin = min(min(data.xbin)); xmax = max(max(data.xbin));
ymin = min(min(data.ybin)); ymax = max(max(data.ybin));
%xticks = linspace(xmin,xmax,nr);
%yticks = linspace(ymin,ymax,nc);
%set(gca,'XTickLabel',num2str(data.xbin(:,1)));
%xticks = data.xbin(:,1); 
%imagesc(xticks,yticks,(data.histo(:,:,1)));
imagesc(data.xbin(:,1),data.ybin(:,1),(data.histo(:,:,1)));
set(gca,'YDir','normal')
set(gca,'Units','pixel');
colormap(color_map); shading flat;
caxis([caxis_val(1,1) caxis_val(1,2)])
clear data;
% Move the GUI to the center of the screen.
%movegui(f,'center')

% Make the GUI visible.
set(f,'Visible','on');
%set(ha, 'NextPlot', 'replace');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Menu Bar%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
f0 = uimenu('Label','Save');
    f0a = uimenu(f0,'Label','Put on Workspace','Callback',@wrk_spc_Callback);
    f0b = uimenu(f0,'Label','Save Layer to Workspace','Callback',@save_lyr_Callback);
          uimenu(f0,'Label','Save Zoomed Layer to Workspace','Callback',@save_zm_lyr_Callback);
        uimenu(f0,'Label','Export Movie','Callback',@export_movie_Callback);

disp = uimenu('Label','Display');
    uimenu(disp,'Label','Select Palette','Callback',@sel_pal_Callback);
    uimenu(disp,'Label','Plot Color Bar','Callback',@plot_colorbar_Callback);
    uimenu(disp,'Label','Adjust Histogram','Callback',@histogram_Callback);
    uimenu(disp,'Label','Invert Color Scale','Callback',@invert_color_Callback);


%%%%%%%%%%%%%%%%%%%%%%%CALLBACK FUNCTIONS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  function plot_Callback(hObject,eventdata)
       data = guidata(f);
       layer=get(energy_list,'Value'); 
       color_lim = get(f,'UserData');
       color_lim = color_lim(layer,:);
       x_lim = get(ha,'XLim');
       y_lim = get(ha,'YLim');
       %pcolor(data.map(:,:,layer)); 
       %imagesc((data.histo(:,:,layer)));  
        xticks = data.xbin(:,n);
        yticks = data.ybin(:,n);
       imagesc(xticks, yticks,(data.histo(:,:,layer)));  
       set(ha,'Units','pixels');
       set(gca,'YDir','normal');
       shading flat;
       set(ha,'XLim',x_lim); set(ha,'YLim',y_lim);
       caxis(color_lim);
    end
    
    function get_axes_pos(src,evnt)
        data = guidata(f);
        n = get(energy_list,'Value');       
        cp = get(ha,'CurrentPoint');
        xticks = data.xbin(:,n);
        yticks = data.ybin(:,n);
        xpixel = round(axes2pix(nc,xticks,cp(1,1)));
        ypixel = round(axes2pix(nr,yticks,cp(1,2)));

        if xpixel > nc || ypixel > nr || xpixel < 1 || ypixel < 1
           return;
        end
        
        str={['coord: ' '( ' num2str(cp(1,1), '%6.3f') ' , '  num2str(cp(1,2),'%6.3f') ' )',...
         '   ' 'pixel: ' '( ' num2str(xpixel,'%6.0f') ' , ' num2str(ypixel,'%6.0f') ' )' ],...
        ['z: ' '( ' num2str(flipud(data.histo(ypixel,xpixel,n)), '%6.5f') ' )']};
        set(coord_tb,'String',str);
        set(coord_tb,'UserData',[xpixel ypixel]);         
    end
    function zoom_Callback(hObject,eventdata)        
        if strcmp(get(f4,'Label'),'Zoom OFF')
            set(zh,'Enable','on');
            set(f4,'Label','Zoom ON')
        else
            set(zh,'Enable','off');
            set(f4,'Label','Zoom OFF')
        end
    end
    function histogram_Callback(hObject,evendata)
        layer=get(energy_list,'Value'); 
        %lyr_lin = reshape(data.map(:,:,layer),nr*nc,1);
        data_histogram_dialogue(layer,histo,f,ha);
    end

    function sel_pal_Callback(hObject,eventdata)
        col_map = get(f,'Colormap');
        %palette_sel_dialogue(f,color_map);        
        palette_sel_dialogue(f,col_map);        
    end
    function invert_color_Callback(hObject,eventdata)
        c_map = get(f,'Colormap');
        inv_cmap = c_map(end:-1:1,:);
        set(f,'Colormap',inv_cmap);
    end
end