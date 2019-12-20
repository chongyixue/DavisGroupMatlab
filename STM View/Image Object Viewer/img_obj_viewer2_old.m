function h = img_obj_viewer2(data)
 [nr nc nz] = size(data.map);
%  Create and then hide the GUI as it is being constructed.

   f = figure('Name',[data.name '-',data.var],...
              'NumberTitle', 'off',...                            
              'Position',[150,150,355,393],...
              'MenuBar', 'none',...
              'WindowButtonMotionFcn',@get_axes_pos,...
              'Pointer','crosshair',...
              'Renderer','zbuffer',...
              'Visible','off');
 color_map_path = 'C:\Analysis Code\MATLAB\STM View\Color Maps\';             
         
 coord_tb = uicontrol('Style','text',...                
                'Position',[87,5,265,35],...
                'UserData',[0 0]);

   str={['coord: ' '( ' num2str(0, '%6.2f') ' , '  num2str(0,'%6.2f') ' )',...
   '   ' 'pixel: ' '( ' num2str(0,'%6.0f') ' , ' num2str(0,'%6.0f') ' )' ],...
   ['z: ' '( ' num2str(0, '%6.5f') ' )']};
   set(coord_tb,'String',str);
            
   bias = uicontrol('Style','text',...
                     'String','Bias (mV)',...
                     'Position',[3,27,65,15]);
   energy_list = uicontrol('Style','popupmenu',...
          'String', num2str(1000*data.e','%10.2f'),...
          'Value', 1,...
          'Position',[3,0,80,25],...
          'Callback',{@plot_Callback});
      
   ha = axes('Units','Pixels','DrawMode','fast','Position',[2,42,352,352]);  
   align([bias, energy_list],'Center','None');   
   
   % allow zoom function for figure;
   zh = zoom(f); set(zh,'Enable','off');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Menu Bar%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
f0 = uimenu('Label','Save');
    f0a = uimenu(f0,'Label','Put on Workspace','Callback',@wrk_spc_Callback);
    f0b = uimenu(f0,'Label','Save Layer to Workspace','Callback',@save_lyr_Callback);
        uimenu(f0,'Label','Export Movie','Callback',@export_movie_Callback);

disp = uimenu('Label','Display');
    uimenu(disp,'Label','Select Palette','Callback',@sel_pal_Callback);
    uimenu(disp,'Label','Plot Color Bar','Callback',@plot_colorbar_Callback);
    uimenu(disp,'Label','Adjust Histogram','Callback',@histogram_Callback);
    uimenu(disp,'Label','Invert Color Scale','Callback',@invert_color_Callback);
    f1a = uimenu(disp,'Label','Spectrum Viewer','Callback',@spect_viewer_Callback);
    uimenu(disp,'Label','Show Average Spectrum','Callback',@avg_spect_Callback);

process = uimenu('Label','Process');
        uimenu(process,'Label','Crop', 'Callback',@crop_Callback)
        uimenu(process,'Label','Change Pixel Dimension','Callback',@pix_dim_Callback);
        uimenu(process,'Label','Line Cut','Callback',@line_cut_Callback);
    f2a = uimenu(process,'Label','Background Subtraction');
        uimenu(f2a,'Label','0','Callback',{@bkgnd_Callback,0});
        uimenu(f2a,'Label','1','Callback',{@bkgnd_Callback,1});
        uimenu(f2a,'Label','2','Callback',{@bkgnd_Callback,2});
        uimenu(f2a,'Label','3','Callback',{@bkgnd_Callback,3});
        uimenu(f2a,'Label','4','Callback',{@bkgnd_Callback,4});
        uimenu(f2a,'Label','5','Callback',{@bkgnd_Callback,5});
        uimenu(f2a,'Label','6','Callback',{@bkgnd_Callback,6});
    f2b = uimenu(process,'Label','Math');
        f2ba = uimenu(f2b,'Label', 'Add/Subtract');
        f2bb = uimenu(f2b,'Label', 'Multiply/Divide');
        f2ba = uimenu(f2b,'Label', 'Add/Subtract');
    f2c = uimenu(process,'Label','Image Manipulation');
        uimenu(f2c,'Label','Shear Correct','Callback',@shear_cor_Callback);
        uimenu(f2c,'Label','Symmetrize','Callback',@sym_Callback);
        uimenu(f2c,'Label','Gaussian Blur','Callback',@blur_Callback);
        uimenu(f2c,'Label','Remove FT Center','Callback',@rm_center_Callback);
        uimenu(f2c,'Label','Gaussian Filter','Callback',@gauss_filt_Callback);       
    f2d = uimenu(process,'Label','Extract Layer','Callback',@extract_lyr_Callback);

analysis = uimenu('Label','Analysis');
    ft_anal = uimenu(analysis,'Label','Fourier Transform','Callback',@ft_Callback);       
    zmap = uimenu(analysis,'Label','Z-Map','Callback',@zmap_Callback);
    bscco_anal = uimenu(analysis,'Label','BSCCO');
        uimenu(bscco_anal,'Label','Gap Map','Callback',@gapmap_Callback);
        uimenu(bscco_anal,'Label','Omega Map','Callback',@omega_Callback);
        uimenu(bscco_anal,'Label','Rescale energy by gap','Callback',@gap_scale_Callback)
        uimenu(bscco_anal,'Label','Gap Sorted Spectra','Callback',@gap_sort_Callback);
    nem_anal = uimenu(analysis,'Label','Nematicity Analysis');    
        uimenu(nem_anal,'Label','MNR(r) - r-space Derived','Callback',@MNR_Callback);
        uimenu(nem_anal,'Label','MNQ(r) - k-space Derived','Callback',@MNQ_Callback);
        uimenu(nem_anal,'Label','Nematic Tile 1','Callback',@nematic_tile1_Callback);
        uimenu(nem_anal,'Label','Nematic Tile 2','Callback',@nematic_tile2_Callback);
        uimenu(nem_anal,'Label','Nematic Domain Mean Subtraction','Callback',@nem_mean_subt_Callback);
        uimenu(nem_anal,'Label','Binary View of Domains','Callback',@binary_domains_Callback);
        uimenu(nem_anal,'Label','Average Domain Spectra','Callback',@avg_nem_spect_Callback);
f4 = uimenu('Label','Zoom OFF','Callback',@zoom_Callback);


%%%%%%%%%%%%%%%%%%%%%%%%%% Initialize the GUI%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Change units to normalized so components resize automatically.
set([f,ha],'Units','normalized');

% generate a histogram for each layer of data.  Will be used for setting
% color axis limit.  Also include the dimensions of img_obj.
n = 1000;
for k = 1:nz
    tmp_layer = reshape(data.map(:,:,k),nr*nc,1);
    tmp_std = std(tmp_layer);
    % pick a common number of bins based on the largest spread of values in
    % one of the layers
    n1 = abs((max(tmp_layer) - min(tmp_layer)))/(2*tmp_std)*1000;
    n = max(n,floor(n1));    
end
clear tmp_layer n1 tmp_std

for k=1:nz
    [histo.freq(k,1:n) histo.val(k,1:n)] = hist(reshape(data.map(:,:,k),nr*nc,1),n);
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
imagesc((data.map(:,:,1)));
colormap(color_map); axis off; axis equal; shading flat;
caxis([caxis_val(1,1) caxis_val(1,2)])

% Move the GUI to the center of the screen.
%movegui(f,'center')

% Make the GUI visible.
set(f,'Visible','on');
%set(ha, 'NextPlot', 'replace');
%%%%%%%%%%%%%%%%%%%%%%%CALLBACK FUNCTIONS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    function plot_Callback(hObject,eventdata)
       layer=get(energy_list,'Value'); 
       color_lim = get(f,'UserData');
       color_lim = color_lim(layer,:);
       x_lim = get(ha,'XLim');
       y_lim = get(ha,'YLim');
       %pcolor(data.map(:,:,layer)); 
       imagesc((data.map(:,:,layer)));        
       axis off; axis equal; shading flat;
       set(ha,'XLim',x_lim); set(ha,'YLim',y_lim);
       caxis(color_lim);
    end
    
    function get_axes_pos(src,evnt)
        n = get(energy_list,'Value');
        cp = get(ha,'CurrentPoint');
        xinit = round(cp(1,1));yinit = round(cp(1,2));
        if xinit > nc || yinit > nr || xinit < 1 || yinit < 1
           return;
        end
        str={['coord: ' '( ' num2str(data.r(xinit), '%6.2f') ' , '  num2str(data.r(yinit),'%6.2f') ' )',...
         '   ' 'pixel: ' '( ' num2str(xinit,'%6.0f') ' , ' num2str(yinit,'%6.0f') ' )' ],...
        ['z: ' '( ' num2str(data.map(yinit,xinit,n), '%6.5f') ' )']};
        set(coord_tb,'String',str);
        set(coord_tb,'UserData',[xinit yinit]); 
        spect_viewer_handle = get(f1a,'UserData');
        if ~isempty(spect_viewer_handle)
            axes(spect_viewer_handle);
            plot(data.e,squeeze(squeeze(data.map(yinit,xinit,:))));
        end            
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
    function plot_colorbar_Callback(hObject,eventdata)
         col_map = get(f,'Colormap');
         x = linspace(0,1,300);
        for i = 1:50
            palette(1:300,i) = x;
        end
        figure('Position',[150,150,180,300],'NumberTitle', 'off');
        pcolor(palette); shading flat; axis off; axis equal;colormap(col_map);
    end
    function invert_color_Callback(hObject,eventdata)
        c_map = get(f,'Colormap');
        inv_cmap = c_map(end:-1:1,:);
        set(f,'Colormap',inv_cmap);
    end
    function spect_viewer_Callback(hObject,eventdata)
        spect_viewer_handle = spectrum_viewer(f1a);
        set(f1a,'UserData',spect_viewer_handle);
    end
    
    function avg_spect_Callback(hObject,eventdata)
        x = data.e*1000;
        if ~isempty(data.ave)
            y = data.ave;            
        else
            y = squeeze(mean(mean(data.map)));
        end
            graph_plot(x,y,'b',[data.name ' Average Spectrum']);
    end
    
    function wrk_spc_Callback(hObject,eventdata)
         default_name = ['obj_' data.name '_' data.var];
         answer = wrk_space_dialogue(default_name);
         if ~isempty(answer)
            assignin('base',answer{1},data)
        end
    end
    function save_lyr_Callback(hObject,eventdata)  
       layer=get(energy_list,'Value'); 
       prompt={'Workspace Variable Name'};
       name='Save Layer to Workspace';
       numlines=1;
       defaultanswer= {''};
       answer = inputdlg(prompt,name,numlines,defaultanswer);       
       if strcmp(answer{1},'')
           return;
       else
           assignin('base',answer{1},data.map(:,:,layer));
       end
    end
    function export_movie_Callback(hObject,eventdata)
        color_lim = get(f,'UserData');
       %color_lim = color_lim(layer,:);             
       c_map =  get(f,'Colormap');
        exp_movie_dialogue(data.map,data.e,data.r,data.r,c_map,color_lim);
    end

    function crop_Callback(hOjbect,eventdata)
        crop_dialogue(data);
    end
    function pix_dim_Callback(hObject,eventdata)
        pix_dim_dialogue(data)
    end
    function line_cut_Callback(hObject,eventdata)
        line_cut_dialogue(data);
    end
    function bkgnd_Callback(hObject,eventdata,order)
          polyn_subtract(data,order);        
    end
    function ft_Callback(hObject,eventdata)
        ft_dialogue(data);
    end
    function zmap_Callback(hObject,eventday)
      z_maps(data);
        % new_data = z_maps(data);
       %if isempty(new_data)
        %   display('Z-Map Failed');
         %  return;
       %else
        %   img_obj_viewer2(new_data);
       %end
    end
    function shear_cor_Callback(hObject,eventdata)
        shear_corr_dialogue(data);
    end
    function sym_Callback(hObject,eventdata)
        sym_map_dialogue(data);
    end
    function blur_Callback(hObject,eventdata)
        gauss_blur_dialogue(data);
    end
    function rm_center_Callback(hObject,eventdata)
        rm_center(data);
    end
    function gauss_filt_Callback(hObject,eventdata)
        gauss_filter_dialogue(data);
    end

    function extract_lyr_Callback(hObject,eventdata)
       % open new window with just the specified layer
       layer=get(energy_list,'Value'); 
       color_lim = get(f,'UserData');
       color_lim = color_lim(layer,:);             
       c_map =  get(f,'Colormap');
       
       % select title for extracted image
       if length(data.e) <= 1
           str = ['Layer from ' data.name '-' data.var];
       else
           str = ['Layer from ' data.name '-' data.var ' at ' num2str(data.e(layer)*1000) 'mV'];
       end
       img_plot2((data.map(:,:,layer)),c_map,str);               
       caxis(color_lim);              
    end

    function gapmap_Callback(hObject,eventdata)
        BSCCO_gap_map_dialogue(data);
    end

    function omega_Callback(hObject,eventdata)
        display('Omega Map');
    end
    function gap_scale_Callback(hObject,eventdata)
        if isfield(data,'gap_map')
            gap_scale_map(data,data.gap_map);
        else
            display('No gap map from which to generate scaling')
            return;
        end
    end
    function gap_sort_Callback(hObject,eventdata)
        display('yes');
    end
    function MNR_Callback(hObject,eventdata)
        MNR_dialogue(data);
    end
    function MNQ_Callback(hObject,eventdata)
        MNQ_dialogue(data);
    end
    function avg_nem_spect_Callback(hObject,eventdata)
        avg_nem_spect_dialogue(data);
    end
    function nematic_tile1_Callback(hObject,eventdata)
        nematic_tile_dialogue(data);
    end
    function nematic_tile2_Callback(hObject,eventdata)
        nematic_tile2(data);
    end
    function nem_mean_subt_Callback(hObject,eventdata)
        nem_dom_mean_subt(data);
    end
    function binary_domains_Callback(hObject,eventdata)
        binary_domains(data);
    end
        
end
