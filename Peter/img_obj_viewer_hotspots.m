function h = img_obj_viewer_hotspots(in_data)

%  Create and then hide the GUI as it is being constructed.
global list;
list = [-7,-18,-28,-40]/1000;
f = figure('NumberTitle', 'off',...                            
              'Position',[150,150,355,393],...
              'MenuBar', 'none',...
              'WindowButtonMotionFcn',@get_axes_pos,...
              'WindowButtonDownFcn',@get_pixel,...
              'Pointer','crosshair',...
              'Renderer','zbuffer',...
              'Visible','off');

            %  'CloseRequestFcn',@img_obj_closereq);
%color_map_path = 'C:\Users\feynman\Documents\MATLAB\Analysis Code\MATLAB\STM View\Color Maps\'; 
% color_map_path = '/Users/andreykostin/Documents/MATLAB/Analysis Code/MATLAB/STM View/Color Maps/'; 
% color_map_path = 'C:\Users\Peter\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\';             
color_map_path = 'C:\Users\pspra\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\';             


% make a copy of in_data in guidata - copy by reference invoked so only one copy
% of object data exists in guidata
guidata(f,in_data);
[nr nc nz] = size(getfield(guidata(f),'map'));
obj_name = getfield(guidata(f),'name');
obj_var = getfield(guidata(f),'var');
obj_energy = getfield(guidata(f),'e');

set(f,'Name',[obj_name '-' obj_var]);

coord_tb = uicontrol('Style','text',...                
                'Position',[100,5,250,35],...
                'UserData',[0 0]);

   str={['coord: ' '( ' num2str(0, '%6.4f') ' , '  num2str(0,'%6.4f') ' )',...
   '   ' 'pixel: ' '( ' num2str(0,'%6.0f') ' , ' num2str(0,'%6.0f') ' )' ],...
   ['z: ' '( ' num2str(0, '%6.5f') ' )']};
   set(coord_tb,'String',str);
            
   bias = uicontrol('Style','text',...
                     'String','Bias (mV)',...
                     'Position',[7,27,65,12]);
   energy_list = uicontrol('Style','popupmenu',...
                     'String', num2str(1000*obj_energy','%10.2f'),...
                     'Value', 1,...
                     'Position',[1,7,80,14],...
                     'Callback',{@plot_Callback});
                 %'String', num2str(1000*data.e','%10.2f'),...
   energy_slider = uicontrol('Style','slider',...
                     'Value',1,...
                     'Min',1,'Max',nz,...
                     'SliderStep',[1/nz 10/nz],...
                     'Position',[85,2,10,37],...
                     'Callback',{@slider_Callback});
      
   ha = axes('Units','Pixels','DrawMode','fast','Position',[2,42,352,352]); 
  % ha = axes('Units','normalized','DrawMode','fast','Position',[2,42,352,352]);
   %align([bias, energy_list],'Center','None');   
   
   % allow zoom function for figure;
   zh = zoom(f); set(zh,'Enable','off');
   ind = 0;
   cut_pixel = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Menu Bar%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
f0 = uimenu('Label','Save');
f0a = uimenu(f0,'Label','Put on Workspace','Callback',@wrk_spc_Callback);
f0b = uimenu(f0,'Label','Save Layer to Workspace','Callback',@save_lyr_Callback);
      uimenu(f0,'Label','Save Zoomed Layer to Workspace','Callback',@save_zm_lyr_Callback);
      uimenu(f0,'Label','Export Movie','Callback',@export_movie_Callback);
      uimenu(f0,'Label','Export Multipanel Panel Movie','Callback',@export_movie_multipanel_Callback);

disp = uimenu('Label','Display');
    uimenu(disp,'Label','Select Palette','Callback',@sel_pal_Callback);
    uimenu(disp,'Label','Plot Color Bar','Callback',@plot_colorbar_Callback);
    uimenu(disp,'Label','Adjust Histogram','Callback',@histogram_Callback);
    uimenu(disp,'Label','Invert Color Scale','Callback',@invert_color_Callback);
    f1a = uimenu(disp,'Label','Spectrum Viewer','Callback',@spect_viewer_Callback);
    f2a = uimenu(disp,'Label','Line Cut Viewer', 'Callback', @line_cut_viewer_Callback);
    uimenu(disp,'Label','Show Average Spectrum','Callback',@avg_spect_Callback);

process = uimenu('Label','Process');
    avg_menu = uimenu(process,'Label','Averaging');
        uimenu(avg_menu,'Label','Energy box-car average','Callback',@boxcar_avg_Callback);
        uimenu(avg_menu,'Label','4 pixel average','Callback',@px4_avg_Callback);

    crop_menu = uimenu(process,'Label','Crop');
        uimenu(crop_menu,'Label','Crop by Coordinates', 'Callback',@crop_Callback)
        uimenu(crop_menu,'Label','Crop Current FOV', 'Callback',@crop_FOV_Callback)
    
    uimenu(process,'Label','Change Pixel Dimension','Callback',@pix_dim_Callback);
    uimenu(process,'Label','Rotate Map','Callback',@rot_map_Callback);
    uimenu(process,'Label','Line Cut','Callback',@line_cut_Callback);
    
    
    f2a = uimenu(process,'Label','Background Subtraction');
        uimenu(f2a,'Label','0','Callback',{@bkgnd_Callback,0});
        uimenu(f2a,'Label','1','Callback',{@bkgnd_Callback,1});
        uimenu(f2a,'Label','2','Callback',{@bkgnd_Callback,2});
        uimenu(f2a,'Label','3','Callback',{@bkgnd_Callback,3});
        uimenu(f2a,'Label','4','Callback',{@bkgnd_Callback,4});
        uimenu(f2a,'Label','5','Callback',{@bkgnd_Callback,5});
        uimenu(f2a,'Label','6','Callback',{@bkgnd_Callback,6});
        
    filt_menu = uimenu(process,'Label','Filtering');
        uimenu(filt_menu,'Label','Bilateral Filter','Callback',@bilat_filt_Callback);
        uimenu(filt_menu,'Label','Gaussian Filter','Callback',@gauss_filt_Callback); 
    math_menu = uimenu(process,'Label','Math');
        uimenu(math_menu,'Label', 'Add/Subtract');
        uimenu(math_menu,'Label', 'Multiply/Divide');
        uimenu(math_menu,'Label', 'Add/Subtract');
        uimenu(math_menu,'Label','d/dE','Callback',@deriv_Callback);
    img_manip_menu = uimenu(process,'Label','Image Manipulation');
        uimenu(img_manip_menu,'Label','Shear Correct','Callback',@shear_cor_Callback);
        uimenu(img_manip_menu,'Label','Symmetrize','Callback',@sym_Callback);
        uimenu(img_manip_menu,'Label','(x,y) Gaussian Blur','Callback',@blur_Callback);
        uimenu(img_manip_menu,'Label','Remove FT Center','Callback',@rm_center_Callback);
        uimenu(img_manip_menu,'Label','Register','Callback',@register_Callback);
              
    
  
    
        f2d = uimenu(process,'Label','Inter-Data Operations','Callback',@intdata_ops_Callback);
       
    f2e = uimenu(process,'Label','Copy Data from...');
        uimenu(f2e,'Label','GUI Object','Callback',@copy_gui_data_Callback);
        uimenu(f2e,'Label','Workspace','Callback',@copy_wrkspc_data_Callback);              
        uimenu(process,'Label','Extract Layer','Callback',@extract_lyr_Callback);
    
    

analysis = uimenu('Label','Analysis');
    cntr_mass = uimenu(analysis,'Label','Center of Mass','Callback',@center_of_mass_Callback);
    histogram = uimenu(analysis,'Label','2D Histograms','Callback',@hist2d_Callback);
    ft_anal = uimenu(analysis,'Label','Fourier Transform','Callback',@ft_Callback);       
    cor_anal = uimenu(analysis,'Label','Correlations');
        uimenu(cor_anal,'Label','Autocorrelation','Callback',@autocor_Callback)
        uimenu(cor_anal,'Label','Cross Correlation','Callback',@crosscorr_Callback)
    zmap = uimenu(analysis,'Label','Z-Map','Callback',@zmap_Callback);
    bscco_anal = uimenu(analysis,'Label','BSCCO');
        uimenu(bscco_anal,'Label','Gap Map','Callback',@gapmap_Callback);
        uimenu(bscco_anal,'Label','Omega Map','Callback',@omega_Callback);
        uimenu(bscco_anal,'Label','Rescale energy by gap','Callback',@gap_scale_Callback)
        uimenu(bscco_anal,'Label','Gap Sorted Spectra','Callback',@gap_sort_Callback);
        uimenu(bscco_anal,'Label','SM Phase Extraction','Callback',@SM_phase_Callback);
    nem_anal = uimenu(analysis,'Label','Nematicity Analysis');    
        uimenu(nem_anal,'Label','MNR(r) - r-space Derived','Callback',@MNR_Callback);
        uimenu(nem_anal,'Label','MNQ(r) - k-space Derived','Callback',@MNQ_Callback);
        uimenu(nem_anal,'Label','MNQ(E)','Callback',@MNQ_E_Callback);
        uimenu(nem_anal,'Label','Nematic Tile 1','Callback',@nematic_tile1_Callback);
        uimenu(nem_anal,'Label','Nematic Tile 2','Callback',@nematic_tile2_Callback);
        uimenu(nem_anal,'Label','Nematic Domain Mean Subtraction','Callback',@nem_mean_subt_Callback);
        uimenu(nem_anal,'Label','Binary View of Domains','Callback',@binary_domains_Callback);
        uimenu(nem_anal,'Label','Average Domain Spectra','Callback',@avg_nem_spect_Callback);
f4 = uimenu('Label','Zoom OFF','Callback',@zoom_Callback);


%%%%%%%%%%%%%%%%%%%%%%%%%% Initialize the GUI%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Change units to normalized so components resize automatically.
set([f,ha],'Units','normalized');
data = guidata(f);
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
clear data;
% Move the GUI to the center of the screen.
%movegui(f,'center')

% Make the GUI visible.
set(f,'Visible','on');
%set(ha, 'NextPlot', 'replace');
%%%%%%%%%%%%%%%%%%%%%%%CALLBACK FUNCTIONS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    function plot_Callback(hObject,eventdata)
       data = guidata(f);
       layer=get(energy_list,'Value');
       color_lim = get(f,'UserData');
       color_lim = color_lim(layer,:);
       x_lim = get(ha,'XLim');
       y_lim = get(ha,'YLim');
       %pcolor(data.map(:,:,layer)); 
       imagesc((data.map(:,:,layer)));
       %imagesc(data.r,data.r,(data.map(:,:,layer)));
       [nx, ny, nz] = size(data.map);
       x1 = data.x(layer);
       y1 = data.y(layer);
       p = 14;
       if(isreal(x1)&&isreal(y1))
           hold on
           N = length(data.r);
           txp = (N-1)/(data.r(end)-data.r(1))*(x1-data.r(end))+N;
           txn = (N-1)/(data.r(end)-data.r(1))*(-x1-data.r(end))+N;
           typ = (N-1)/(data.r(end)-data.r(1))*(y1-data.r(end))+N;
           tyn = (N-1)/(data.r(end)-data.r(1))*(-y1-data.r(end))+N;
           %plot([x1 x1 -x1 -x1],[y1 -y1 y1 -y1] ,'.r','MarkerSize',30);
           if round((data.e(layer)*10000)) == -24 || round((data.e(layer)*10000)) == 24
%                 plot([txp txp txn txn],[typ tyn typ tyn] ,'dc','MarkerSize',30);
%                 plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 'd', 'LineStyle', 'none', 'MarkerSize', 10,'MarkerEdgeColor','k','MarkerFaceColor','c', 'LineWidth', 1);
                plot([txp txp txn txn],[typ tyn typ tyn],'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
           else
%                plot([txp txp txn txn],[typ tyn typ tyn] ,'.c','MarkerSize',30);
%                plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', 10,'MarkerEdgeColor','k','MarkerFaceColor','c', 'LineWidth', 1);
               plot([txp txp txn txn],[typ tyn typ tyn],'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
           end
           %patch([1 1 5],[1 5 5],'red');
           %drawArrow([round(txp) round(typ)],[round(txn) round(tyn)]);
           %plot([0,10],[0,10] ,'.r','MarkerSize',30);
           hold off
       end
       x2 = data.x2(layer);
       y2 = data.y2(layer);
       if(isreal(x2)&&isreal(y2))
           hold on
           N = length(data.r);
           txp = (N-1)/(data.r(end)-data.r(1))*(x2-data.r(end))+N;
           txn = (N-1)/(data.r(end)-data.r(1))*(-x2-data.r(end))+N;
           typ = (N-1)/(data.r(end)-data.r(1))*(y2-data.r(end))+N;
           tyn = (N-1)/(data.r(end)-data.r(1))*(-y2-data.r(end))+N;
           %plot([x1 x1 -x1 -x1],[y1 -y1 y1 -y1] ,'.r','MarkerSize',30);
%            plot([txp txp txn txn],[typ tyn typ tyn] ,'.c','MarkerSize',30);
%            plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', 10,'MarkerEdgeColor','k','MarkerFaceColor','c', 'LineWidth', 1);
           plot([txp txp txn txn],[typ tyn typ tyn],'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
           %patch([1 1 5],[1 5 5],'red');
           %drawArrow([round(txp) round(typ)],[round(txn) round(tyn)]);
           %plot([0,10],[0,10] ,'.r','MarkerSize',30);
           hold off
       end
       x3 = data.x3(layer);
       y3 = data.y3(layer);
       if(isreal(x3)&&isreal(y3))
           hold on
           N = length(data.r);
           txp = (N-1)/(data.r(end)-data.r(1))*(x3-data.r(end))+N;
           txn = (N-1)/(data.r(end)-data.r(1))*(-x3-data.r(end))+N;
           typ = (N-1)/(data.r(end)-data.r(1))*(y3-data.r(end))+N;
           tyn = (N-1)/(data.r(end)-data.r(1))*(-y3-data.r(end))+N;
           %plot([x1 x1 -x1 -x1],[y1 -y1 y1 -y1] ,'.r','MarkerSize',30);
%            plot([txp txp txn txn],[typ tyn typ tyn] ,'.c','MarkerSize',30);
%            plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', 10,'MarkerEdgeColor','k','MarkerFaceColor','c', 'LineWidth', 1);
           plot([txp txp txn txn],[typ tyn typ tyn],'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
           %patch([1 1 5],[1 5 5],'red');
           %drawArrow([round(txp) round(typ)],[round(txn) round(tyn)]);
           %plot([0,10],[0,10] ,'.r','MarkerSize',30);
           hold off
       end
       x4 = data.x4(layer);
       y4 = data.y4(layer);
       if(isreal(x4)&&isreal(y4))
           hold on
           N = length(data.r);
           txp = (N-1)/(data.r(end)-data.r(1))*(x4-data.r(end))+N;
           txn = (N-1)/(data.r(end)-data.r(1))*(-x4-data.r(end))+N;
           typ = (N-1)/(data.r(end)-data.r(1))*(y4-data.r(end))+N;
           tyn = (N-1)/(data.r(end)-data.r(1))*(-y4-data.r(end))+N;
           %plot([x1 x1 -x1 -x1],[y1 -y1 y1 -y1] ,'.r','MarkerSize',30);
%            plot([txp txp txn txn],[typ tyn typ tyn] ,'.c','MarkerSize',30);
%            plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 's', 'LineStyle', 'none', 'MarkerSize', 10,'MarkerEdgeColor','k','MarkerFaceColor','c', 'LineWidth', 1);
           plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 'x', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
           %patch([1 1 5],[1 5 5],'red');
           %drawArrow([txp typ],[txn tyn]);
           %plot([0,10],[0,10] ,'.r','MarkerSize',30);
           hold off
       end
       x5 = data.x5(layer);
       y5 = data.y5(layer);
       if(isreal(x5)&&isreal(y5))
           hold on
           N = length(data.r);
           txp = (N-1)/(data.r(end)-data.r(1))*(x5-data.r(end))+N;
           txn = (N-1)/(data.r(end)-data.r(1))*(-x5-data.r(end))+N;
           typ = (N-1)/(data.r(end)-data.r(1))*(y5-data.r(end))+N;
           tyn = (N-1)/(data.r(end)-data.r(1))*(-y5-data.r(end))+N;
           %plot([x1 x1 -x1 -x1],[y1 -y1 y1 -y1] ,'.r','MarkerSize',30);
%            plot([txp txp txn txn],[typ tyn typ tyn] ,'.c','MarkerSize',30);
%            plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 's', 'LineStyle', 'none', 'MarkerSize', 10,'MarkerEdgeColor','k','MarkerFaceColor','c', 'LineWidth', 1);
           plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 'x', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
           %patch([1 1 5],[1 5 5],'red');
           %drawArrow([txp typ],[txn tyn]);
           %plot([0,10],[0,10] ,'.r','MarkerSize',30);
           hold off
       end
       x6 = data.x6(layer);
       y6 = data.y6(layer);
       if(isreal(x6)&&isreal(y6))
           hold on
           N = length(data.r);
           txp = (N-1)/(data.r(end)-data.r(1))*(x6-data.r(end))+N;
           txn = (N-1)/(data.r(end)-data.r(1))*(-x6-data.r(end))+N;
           typ = (N-1)/(data.r(end)-data.r(1))*(y6-data.r(end))+N;
           tyn = (N-1)/(data.r(end)-data.r(1))*(-y6-data.r(end))+N;
           %plot([x1 x1 -x1 -x1],[y1 -y1 y1 -y1] ,'.r','MarkerSize',30);
%            plot([txp txp txn txn],[typ tyn typ tyn] ,'.c','MarkerSize',30);
           if round(data.e(layer)*10000) == -3 || round(data.e(layer)*10000) == 3
%                 plot([txp txp txn txn],[typ tyn typ tyn] ,'dc','MarkerSize',30);
%                 plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 'd', 'LineStyle', 'none', 'MarkerSize', 10,'MarkerEdgeColor','k','MarkerFaceColor','c', 'LineWidth', 1);
                plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 'x', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
           else
%                plot([txp txp txn txn],[typ tyn typ tyn] ,'.c','MarkerSize',30);
%                plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 's', 'LineStyle', 'none', 'MarkerSize', 10,'MarkerEdgeColor','k','MarkerFaceColor','c', 'LineWidth', 1);
               plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 'x', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
           end
           %patch([1 1 5],[1 5 5],'red');
           %drawArrow([txp typ],[txn tyn]);
           %plot([0,10],[0,10] ,'.r','MarkerSize',30);
           hold off
       end
        
       xqd = data.xqd(layer);
       yqd = data.yqd(layer);
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
       
       axis off; axis equal; shading flat;
       set(ha,'XLim',x_lim); set(ha,'YLim',y_lim);
       caxis(color_lim);
%       figure(50), plot(data.e,data.ave,'.k',[data.e(layer) data.e(layer)],ylim,'-r');
    end

    function slider_Callback(hObject,eventdata)
        data = guidata(f);
        layer = round(get(energy_slider,'Value'));
        set(energy_list,'Value',layer);
        set(energy_slider,'Value',layer);
        color_lim = get(f,'UserData');
        color_lim = color_lim(layer,:);
        x_lim = get(ha,'XLim');
        y_lim = get(ha,'YLim');
        imagesc((data.map(:,:,layer)));
               x1 = data.x(layer);
       y1 = data.y(layer);
       [nx, ny, nz] = size(data.map);
       p = 14;
        if(isreal(x1)&&isreal(y1))
           hold on
           N = length(data.r);
           txp = (N-1)/(data.r(end)-data.r(1))*(x1-data.r(end))+N;
           txn = (N-1)/(data.r(end)-data.r(1))*(-x1-data.r(end))+N;
           typ = (N-1)/(data.r(end)-data.r(1))*(y1-data.r(end))+N;
           tyn = (N-1)/(data.r(end)-data.r(1))*(-y1-data.r(end))+N;
           %plot([x1 x1 -x1 -x1],[y1 -y1 y1 -y1] ,'.r','MarkerSize',30);
           if round((data.e(layer)*10000)) == -24 || round((data.e(layer)*10000)) == 24
%                 plot([txp txp txn txn],[typ tyn typ tyn] ,'dc','MarkerSize',30);
%                 plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 'd', 'LineStyle', 'none', 'MarkerSize', 10,'MarkerEdgeColor','k','MarkerFaceColor','c', 'LineWidth', 1);
                plot([txp txp txn txn],[typ tyn typ tyn],'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
           else
%                plot([txp txp txn txn],[typ tyn typ tyn] ,'.c','MarkerSize',30);
%                plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', 10,'MarkerEdgeColor','k','MarkerFaceColor','c', 'LineWidth', 1);
               plot([txp txp txn txn],[typ tyn typ tyn],'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
           end
           %patch([1 1 5],[1 5 5],'red');
           %drawArrow([round(txp) round(typ)],[round(txn) round(tyn)]);
           %plot([0,10],[0,10] ,'.r','MarkerSize',30);
           hold off
       end
       x2 = data.x2(layer);
       y2 = data.y2(layer);
       if(isreal(x2)&&isreal(y2))
           hold on
           N = length(data.r);
           txp = (N-1)/(data.r(end)-data.r(1))*(x2-data.r(end))+N;
           txn = (N-1)/(data.r(end)-data.r(1))*(-x2-data.r(end))+N;
           typ = (N-1)/(data.r(end)-data.r(1))*(y2-data.r(end))+N;
           tyn = (N-1)/(data.r(end)-data.r(1))*(-y2-data.r(end))+N;
           %plot([x1 x1 -x1 -x1],[y1 -y1 y1 -y1] ,'.r','MarkerSize',30);
%            plot([txp txp txn txn],[typ tyn typ tyn] ,'.c','MarkerSize',30);
%            plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', 10,'MarkerEdgeColor','k','MarkerFaceColor','c', 'LineWidth', 1);
           plot([txp txp txn txn],[typ tyn typ tyn],'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
           %patch([1 1 5],[1 5 5],'red');
           %drawArrow([round(txp) round(typ)],[round(txn) round(tyn)]);
           %plot([0,10],[0,10] ,'.r','MarkerSize',30);
           hold off
       end
       x3 = data.x3(layer);
       y3 = data.y3(layer);
       if(isreal(x3)&&isreal(y3))
           hold on
           N = length(data.r);
           txp = (N-1)/(data.r(end)-data.r(1))*(x3-data.r(end))+N;
           txn = (N-1)/(data.r(end)-data.r(1))*(-x3-data.r(end))+N;
           typ = (N-1)/(data.r(end)-data.r(1))*(y3-data.r(end))+N;
           tyn = (N-1)/(data.r(end)-data.r(1))*(-y3-data.r(end))+N;
           %plot([x1 x1 -x1 -x1],[y1 -y1 y1 -y1] ,'.r','MarkerSize',30);
%            plot([txp txp txn txn],[typ tyn typ tyn] ,'.c','MarkerSize',30);
%            plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', 10,'MarkerEdgeColor','k','MarkerFaceColor','c', 'LineWidth', 1);
           plot([txp txp txn txn],[typ tyn typ tyn],'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
           %patch([1 1 5],[1 5 5],'red');
           %drawArrow([round(txp) round(typ)],[round(txn) round(tyn)]);
           %plot([0,10],[0,10] ,'.r','MarkerSize',30);
           hold off
       end
       x4 = data.x4(layer);
       y4 = data.y4(layer);
       if(isreal(x4)&&isreal(y4))
           hold on
           N = length(data.r);
           txp = (N-1)/(data.r(end)-data.r(1))*(x4-data.r(end))+N;
           txn = (N-1)/(data.r(end)-data.r(1))*(-x4-data.r(end))+N;
           typ = (N-1)/(data.r(end)-data.r(1))*(y4-data.r(end))+N;
           tyn = (N-1)/(data.r(end)-data.r(1))*(-y4-data.r(end))+N;
           %plot([x1 x1 -x1 -x1],[y1 -y1 y1 -y1] ,'.r','MarkerSize',30);
%            plot([txp txp txn txn],[typ tyn typ tyn] ,'.c','MarkerSize',30);
%            plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 's', 'LineStyle', 'none', 'MarkerSize', 10,'MarkerEdgeColor','k','MarkerFaceColor','c', 'LineWidth', 1);
            plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 'x', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
           %patch([1 1 5],[1 5 5],'red');
           %drawArrow([txp typ],[txn tyn]);
           %plot([0,10],[0,10] ,'.r','MarkerSize',30);
           hold off
       end
       x5 = data.x5(layer);
       y5 = data.y5(layer);
       if(isreal(x5)&&isreal(y5))
           hold on
           N = length(data.r);
           txp = (N-1)/(data.r(end)-data.r(1))*(x5-data.r(end))+N;
           txn = (N-1)/(data.r(end)-data.r(1))*(-x5-data.r(end))+N;
           typ = (N-1)/(data.r(end)-data.r(1))*(y5-data.r(end))+N;
           tyn = (N-1)/(data.r(end)-data.r(1))*(-y5-data.r(end))+N;
           %plot([x1 x1 -x1 -x1],[y1 -y1 y1 -y1] ,'.r','MarkerSize',30);
%            plot([txp txp txn txn],[typ tyn typ tyn] ,'.c','MarkerSize',30);
%            plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 's', 'LineStyle', 'none', 'MarkerSize', 10,'MarkerEdgeColor','k','MarkerFaceColor','c', 'LineWidth', 1);
           plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 'x', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
           %patch([1 1 5],[1 5 5],'red');
           %drawArrow([txp typ],[txn tyn]);
           %plot([0,10],[0,10] ,'.r','MarkerSize',30);
           hold off
       end
       x6 = data.x6(layer);
       y6 = data.y6(layer);
       if(isreal(x6)&&isreal(y6))
           hold on
           N = length(data.r);
           txp = (N-1)/(data.r(end)-data.r(1))*(x6-data.r(end))+N;
           txn = (N-1)/(data.r(end)-data.r(1))*(-x6-data.r(end))+N;
           typ = (N-1)/(data.r(end)-data.r(1))*(y6-data.r(end))+N;
           tyn = (N-1)/(data.r(end)-data.r(1))*(-y6-data.r(end))+N;
           %plot([x1 x1 -x1 -x1],[y1 -y1 y1 -y1] ,'.r','MarkerSize',30);
%            plot([txp txp txn txn],[typ tyn typ tyn] ,'.c','MarkerSize',30);
           if round(data.e(layer)*10000) == -3 || round(data.e(layer)*10000) == 3
%                 plot([txp txp txn txn],[typ tyn typ tyn] ,'dc','MarkerSize',30);
%                 plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 'd', 'LineStyle', 'none', 'MarkerSize', 10,'MarkerEdgeColor','k','MarkerFaceColor','c', 'LineWidth', 1);
                plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 'x', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
           else
%                plot([txp txp txn txn],[typ tyn typ tyn] ,'.c','MarkerSize',30);
%                plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 's', 'LineStyle', 'none', 'MarkerSize', 10,'MarkerEdgeColor','k','MarkerFaceColor','c', 'LineWidth', 1);
               plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 'x', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
           end
           %patch([1 1 5],[1 5 5],'red');
           %drawArrow([txp typ],[txn tyn]);
           %plot([0,10],[0,10] ,'.r','MarkerSize',30);
           hold off
       end

       xqd = data.xqd(layer);
       yqd = data.yqd(layer);
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
       
        axis off; axis equal; shading flat;
        set(ha,'XLim',x_lim); set(ha,'YLim',y_lim);
        caxis(color_lim);
%        figure(50), plot(data.e,data.ave,'.k',[data.e(layer) data.e(layer)],ylim,'-r');
    end
    
    function get_axes_pos(src,evnt)
        data = guidata(f);
        n = get(energy_list,'Value');
        cp = get(ha,'CurrentPoint');
        xinit = round(cp(1,1));yinit = round(cp(1,2));
        if xinit > nc || yinit > nr || xinit < 1 || yinit < 1
           return;
        end
        
        str={['coord: ' '( ' num2str(data.r(xinit), '%6.3f') ' , '  num2str(data.r(yinit),'%6.3f') ' )',...
         '   ' 'pixel: ' '( ' num2str(xinit,'%6.0f') ' , ' num2str(yinit,'%6.0f') ' )' ],...
        ['z: ' '( ' num2str(data.map(yinit,xinit,n), '%6.5f') ' )']};
        set(coord_tb,'String',str);
        set(coord_tb,'UserData',[xinit yinit]); 
        spect_viewer_handle = get(f1a,'UserData');
        line_cut_viewer_handle = get(f2a, 'UserData');
        if ~isempty(spect_viewer_handle)
            axes(spect_viewer_handle);


        plot(data.e,squeeze(squeeze(data.map(yinit,xinit,:))));

%             hold on
%             O = peak_energy_finder(data.e, squeeze(squeeze(data.map(yinit,xinit,:)))',list);
%             for u=1:length(list)
%                 plot([O.data(u) O.data(u)], get(spect_viewer_handle,'ylim'),'-r');
%             end
%             hold off
            
        end
        if ~isempty(line_cut_viewer_handle)
            axes(line_viewer_handle);
            l_cut=line_cut(in_data,[0 0],[xinit yinit],1);
            
        end
    end
    function get_pixel(src,evnt)
        data = guidata(f);
        n = get(energy_list,'Value');
        cp = get(ha,'CurrentPoint');
        xinit = round(cp(1,1));yinit = round(cp(1,2));
        if xinit > nc || yinit > nr || xinit < 1 || yinit < 1
           ind=0;
           return;
        end
        dims = size(data.map(:,:,1));
        zmin = data.map(yinit,xinit,n);
        x_temp = xinit;
        y_temp = yinit;
        for i=max(1,(xinit-2)):min(dims(2),(xinit+2))
            for j=max(1,(yinit-2)):min(dims(1),(yinit+2))
                z_current=data.map(j,i,n);
                if(z_current<zmin)
                    x_temp = i;
                    y_temp = j;
                    zmin = z_current;
                end
            end
        end
        if(~evalin('base','exist(''ind'')'))
            ind=0;
            ind(1)=(x_temp-1)*dims(1)+y_temp;
        else
            ind(end+1)=(x_temp-1)*dims(1)+y_temp;
        end
        assignin('base','ind',ind);
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
     
   function line_cut_viewer_Callback(hObject, eventdata)
       line_cut_viewer_handle = line_cut_viewer(f2a);
       set(f2a,'UserData',line_cut_viewer_handle);
   end


    function avg_spect_Callback(hObject,eventdata)
        data = guidata(f);
        x = data.e*1000;
        if ~isempty(data.ave)
            y = data.ave;            
        else
            y = squeeze(mean(mean(data.map)));
        end
            graph_plot(x,y,'b',[data.name ' Average Spectrum']);
    end
    
    function wrk_spc_Callback(hObject,eventdata)
         data = guidata(f);
         default_name = ['obj_' data.name '_' data.var];
         answer = wrk_space_dialogue(default_name);
         if ~isempty(answer)
            assignin('base',answer{1},data)
        end
    end

    function save_lyr_Callback(hObject,eventdata)  
       data = guidata(f);
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

function save_zm_lyr_Callback(hObject,eventdata)  
       data = guidata(f);
       layer=get(energy_list,'Value')
       prompt={'Workspace Variable Name'};
       name='Save Zoomed Layer to Workspace';
       numlines=1;
       defaultanswer= {''};
       answer = inputdlg(prompt,name,numlines,defaultanswer);       
       if strcmp(answer{1},'')
           return;
       else
           xlimits = round(get(gca,'xlim'));          
           ylimits = round(get(gca,'ylim')); 
           xlimits = xlimits(1):xlimits(end);  
           ylimits = ylimits(1):ylimits(1)+length(xlimits)-1; %make sure it's square
           assignin('base',answer{1},data.map(ylimits,xlimits,layer));
       end
    end

    function export_movie_Callback(hObject,eventdata)
        data = guidata(f);
        color_lim = get(f,'UserData');
       %color_lim = color_lim(layer,:);             
       c_map =  get(f,'Colormap');
        exp_movie_dialogue_hotspots(data.map,data.e,data.r,data.r,c_map,color_lim, data);
    end

    function bilat_filt_Callback(hObject,eventdata)
        bilateral_filt_dialogue(guidata(f));
    end

    function gauss_filt_Callback(hObject,eventdata)
        data = guidata(f);
        gauss_filter_dialogue(data);
    end
    function crop_Callback(hOjbect,eventdata)
        data = guidata(f);
        crop_dialogue(data);
    end
    function crop_FOV_Callback(hOjbect,eventdata)
        xlimits = round(get(gca,'xlim'));          
        ylimits = round(get(gca,'ylim'));            
        ylimits(2) = ylimits(1) + abs(xlimits(1)-xlimits(2)); %make sure it's square
        data = guidata(f);
        crop_dialogue(data,xlimits,ylimits);
    end

    function rot_map_Callback(hObject,eventdata)
        map_rotate_dialogue(guidata(f));
    end

    function pix_dim_Callback(hObject,eventdata)
        data = guidata(f);
        pix_dim_dialogue(data)
    end
    function line_cut_Callback(hObject,eventdata)
        data = guidata(f);
        line_cut_dialogue(data);
    end
    function bkgnd_Callback(hObject,eventdata,order)
        data = guidata(f);
        polyn_subtract(data,order);        
    end
    function ft_Callback(hObject,eventdata)
        data = guidata(f);
        ft_dialogue(data);
    end

    function autocor_Callback(hObject,eventdata)     
        data = guidata(f);
        autocorr_dialogue(data);
    end

    function crosscorr_Callback(hObject,eventdata)
        corr_dialogue(f);
    end
    function zmap_Callback(hObject,eventday)
        data = guidata(f);
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
        data = guidata(f);
        shear_corr_dialogue(data);
    end
    function sym_Callback(hObject,eventdata)
        data = guidata(f);
        sym_map_dialogue(data);
    end
    function blur_Callback(hObject,eventdata)
        data = guidata(f);
        gauss_blur_dialogue(data);
    end
    function rm_center_Callback(hObject,eventdata)
        data = guidata(f);
        rm_center(data);
    end
   
    function copy_gui_data_Callback(hObject,eventdata)        
        copy_gui_data_dialogue(f);                
    end
    function copy_wrkspc_data_Callback(hObject,eventdata);
        copy_wrkspc_data_dialogue(f);       
    end

    function intdata_ops_Callback(hObject,eventdata)
        intdata_ops_dialogue(f);
    end

    function deriv_Callback(hObject,eventdata)        
        map_deriv_dialogue(guidata(f));
    end

    function boxcar_avg_Callback(hObject,eventdata)       
        boxcar_avg_map_dialogue(guidata(f));
    end
    
    function px4_avg_Callback(hObject,eventdata)
        px4_avg(guidata(f));
    end

    function extract_lyr_Callback(hObject,eventdata)
       data = guidata(f);
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
       
       
       [nx, ny, nz] = size(data.map);
       x1 = data.x(layer);
       y1 = data.y(layer);
       p = 14;
       if(isreal(x1)&&isreal(y1))
           hold on
           N = length(data.r);
           txp = (N-1)/(data.r(end)-data.r(1))*(x1-data.r(end))+N;
           txn = (N-1)/(data.r(end)-data.r(1))*(-x1-data.r(end))+N;
           typ = (N-1)/(data.r(end)-data.r(1))*(y1-data.r(end))+N;
           tyn = (N-1)/(data.r(end)-data.r(1))*(-y1-data.r(end))+N;
           %plot([x1 x1 -x1 -x1],[y1 -y1 y1 -y1] ,'.r','MarkerSize',30);
           if round((data.e(layer)*10000)) == -24 || round((data.e(layer)*10000)) == 24
%                 plot([txp txp txn txn],[typ tyn typ tyn] ,'dc','MarkerSize',30);
%                 plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 'd', 'LineStyle', 'none', 'MarkerSize', 10,'MarkerEdgeColor','k','MarkerFaceColor','c', 'LineWidth', 1);
                plot([txp txp txn txn],[typ tyn typ tyn],'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
           else
%                plot([txp txp txn txn],[typ tyn typ tyn] ,'.c','MarkerSize',30);
%                plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', 10,'MarkerEdgeColor','k','MarkerFaceColor','c', 'LineWidth', 1);
               plot([txp txp txn txn],[typ tyn typ tyn],'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
           end
           %patch([1 1 5],[1 5 5],'red');
           %drawArrow([round(txp) round(typ)],[round(txn) round(tyn)]);
           %plot([0,10],[0,10] ,'.r','MarkerSize',30);
           hold off
       end
       x2 = data.x2(layer);
       y2 = data.y2(layer);
       if(isreal(x2)&&isreal(y2))
           hold on
           N = length(data.r);
           txp = (N-1)/(data.r(end)-data.r(1))*(x2-data.r(end))+N;
           txn = (N-1)/(data.r(end)-data.r(1))*(-x2-data.r(end))+N;
           typ = (N-1)/(data.r(end)-data.r(1))*(y2-data.r(end))+N;
           tyn = (N-1)/(data.r(end)-data.r(1))*(-y2-data.r(end))+N;
           %plot([x1 x1 -x1 -x1],[y1 -y1 y1 -y1] ,'.r','MarkerSize',30);
%            plot([txp txp txn txn],[typ tyn typ tyn] ,'.c','MarkerSize',30);
%            plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', 10,'MarkerEdgeColor','k','MarkerFaceColor','c', 'LineWidth', 1);
           plot([txp txp txn txn],[typ tyn typ tyn],'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
           %patch([1 1 5],[1 5 5],'red');
           %drawArrow([round(txp) round(typ)],[round(txn) round(tyn)]);
           %plot([0,10],[0,10] ,'.r','MarkerSize',30);
           hold off
       end
       x3 = data.x3(layer);
       y3 = data.y3(layer);
       if(isreal(x3)&&isreal(y3))
           hold on
           N = length(data.r);
           txp = (N-1)/(data.r(end)-data.r(1))*(x3-data.r(end))+N;
           txn = (N-1)/(data.r(end)-data.r(1))*(-x3-data.r(end))+N;
           typ = (N-1)/(data.r(end)-data.r(1))*(y3-data.r(end))+N;
           tyn = (N-1)/(data.r(end)-data.r(1))*(-y3-data.r(end))+N;
           %plot([x1 x1 -x1 -x1],[y1 -y1 y1 -y1] ,'.r','MarkerSize',30);
%            plot([txp txp txn txn],[typ tyn typ tyn] ,'.c','MarkerSize',30);
%            plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', 10,'MarkerEdgeColor','k','MarkerFaceColor','c', 'LineWidth', 1);
           plot([txp txp txn txn],[typ tyn typ tyn],'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
           %patch([1 1 5],[1 5 5],'red');
           %drawArrow([round(txp) round(typ)],[round(txn) round(tyn)]);
           %plot([0,10],[0,10] ,'.r','MarkerSize',30);
           hold off
       end
       x4 = data.x4(layer);
       y4 = data.y4(layer);
       if(isreal(x4)&&isreal(y4))
           hold on
           N = length(data.r);
           txp = (N-1)/(data.r(end)-data.r(1))*(x4-data.r(end))+N;
           txn = (N-1)/(data.r(end)-data.r(1))*(-x4-data.r(end))+N;
           typ = (N-1)/(data.r(end)-data.r(1))*(y4-data.r(end))+N;
           tyn = (N-1)/(data.r(end)-data.r(1))*(-y4-data.r(end))+N;
           %plot([x1 x1 -x1 -x1],[y1 -y1 y1 -y1] ,'.r','MarkerSize',30);
%            plot([txp txp txn txn],[typ tyn typ tyn] ,'.c','MarkerSize',30);
%            plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 's', 'LineStyle', 'none', 'MarkerSize', 10,'MarkerEdgeColor','k','MarkerFaceColor','c', 'LineWidth', 1);
           plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 'x', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
           %patch([1 1 5],[1 5 5],'red');
           %drawArrow([txp typ],[txn tyn]);
           %plot([0,10],[0,10] ,'.r','MarkerSize',30);
           hold off
       end
       x5 = data.x5(layer);
       y5 = data.y5(layer);
       if(isreal(x5)&&isreal(y5))
           hold on
           N = length(data.r);
           txp = (N-1)/(data.r(end)-data.r(1))*(x5-data.r(end))+N;
           txn = (N-1)/(data.r(end)-data.r(1))*(-x5-data.r(end))+N;
           typ = (N-1)/(data.r(end)-data.r(1))*(y5-data.r(end))+N;
           tyn = (N-1)/(data.r(end)-data.r(1))*(-y5-data.r(end))+N;
           %plot([x1 x1 -x1 -x1],[y1 -y1 y1 -y1] ,'.r','MarkerSize',30);
%            plot([txp txp txn txn],[typ tyn typ tyn] ,'.c','MarkerSize',30);
%            plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 's', 'LineStyle', 'none', 'MarkerSize', 10,'MarkerEdgeColor','k','MarkerFaceColor','c', 'LineWidth', 1);
           plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 'x', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
           %patch([1 1 5],[1 5 5],'red');
           %drawArrow([txp typ],[txn tyn]);
           %plot([0,10],[0,10] ,'.r','MarkerSize',30);
           hold off
       end
       x6 = data.x6(layer);
       y6 = data.y6(layer);
       if(isreal(x6)&&isreal(y6))
           hold on
           N = length(data.r);
           txp = (N-1)/(data.r(end)-data.r(1))*(x6-data.r(end))+N;
           txn = (N-1)/(data.r(end)-data.r(1))*(-x6-data.r(end))+N;
           typ = (N-1)/(data.r(end)-data.r(1))*(y6-data.r(end))+N;
           tyn = (N-1)/(data.r(end)-data.r(1))*(-y6-data.r(end))+N;
           %plot([x1 x1 -x1 -x1],[y1 -y1 y1 -y1] ,'.r','MarkerSize',30);
%            plot([txp txp txn txn],[typ tyn typ tyn] ,'.c','MarkerSize',30);
           if round(data.e(layer)*10000) == -3 || round(data.e(layer)*10000) == 3
%                 plot([txp txp txn txn],[typ tyn typ tyn] ,'dc','MarkerSize',30);
%                 plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 'd', 'LineStyle', 'none', 'MarkerSize', 10,'MarkerEdgeColor','k','MarkerFaceColor','c', 'LineWidth', 1);
                plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 'x', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
           else
%                plot([txp txp txn txn],[typ tyn typ tyn] ,'.c','MarkerSize',30);
%                plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 's', 'LineStyle', 'none', 'MarkerSize', 10,'MarkerEdgeColor','k','MarkerFaceColor','c', 'LineWidth', 1);
               plot([txp txp txn txn],[typ tyn typ tyn],'Marker', 'x', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
           end
           %patch([1 1 5],[1 5 5],'red');
           %drawArrow([txp typ],[txn tyn]);
           %plot([0,10],[0,10] ,'.r','MarkerSize',30);
           hold off
       end
        
       xqd = data.xqd(layer);
       yqd = data.yqd(layer);
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
       
       axis off; axis equal; shading flat;
       caxis(color_lim);             
    end



    function center_of_mass_Callback(hObject,eventdata)
        data = guidata(f);
        layer = get(energy_list,'Value');
        center_of_mass(squeeze(data.map(:,:,layer)));
    end
    function hist2d_Callback(hObject,eventdata)
        hist2d_dialogue(f);
    end
    function gapmap_Callback(hObject,eventdata)
        data = guidata(f);
        BSCCO_gap_map_dialogue(data);
    end

    function omega_Callback(hObject,eventdata)
        display('Omega Map');
    end
    function gap_scale_Callback(hObject,eventdata)
        data = guidata(f);
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

    function SM_phase_Callback(hObject,eventday)
        display('yes SM');
    end

    function MNR_Callback(hObject,eventdata)
        data = guidata(f);
        MNR_dialogue(data);
    end
    function MNQ_Callback(hObject,eventdata)
        data = guidata(f);
        MNQ_dialogue(data);
    end
    function MNQ_E_Callback(hObject,eventdata)
        data = guidata(f);
        MNQ_E_dialogue(data);
    end
    function avg_nem_spect_Callback(hObject,eventdata)
        data = guidata(f);
        avg_nem_spect_dialogue(data);
    end
    function nematic_tile1_Callback(hObject,eventdata)
        data = guidata(f);
        nematic_tile_dialogue(data);
    end
    function nematic_tile2_Callback(hObject,eventdata)
        data = guidata(f);
        nematic_tile2(data);
    end
    function nem_mean_subt_Callback(hObject,eventdata)
        data = guidata(f);
        nem_dom_mean_subt(data);
    end
    function binary_domains_Callback(hObject,eventdata)
        data = guidata(f);
        binary_domains(data);
    end
    function register_Callback(hObject,eventdata)
    data_loc = guidata(f);

        if ~isfield(data_loc,'t_form')
            display('No t_form field');
            return;
        end
       
       
        new_data=data_loc;
       
       
        for i=1:size(new_data.map,3)
        new_map(:,:,i)=imwarp(squeeze(new_data.map(:,:,i)), new_data.t_form.T, 'OutputView', imref2d([data_loc.t_form.size,data_loc.t_form.size])); %imref2d(size( squeeze(new_data.map(:,:,i)))));
         %new_map(:,:,i)=imwarp(squeeze(new_data.map(:,:,i)), new_data.t_form.T, 'OutputView', imref2d(size( squeeze(new_data.map(:,:,i)))));
        end
        new_data.map=new_map;
        new_data.r=data_loc.t_form.r;
        new_data.var = [new_data.var '_registered'];
    new_data.ops{end+1} = 'Registration';
   
    img_obj_viewer2(new_data);
       
       
    end 

end
function obj_gui = find_obj_gui(f)
% find all open figures
h = evalin('base','findobj(''type'',''figure'')');
% separate out all ones which have a structure element in their guidata
count = 0;
obj_gui = [];
for i = 1:length(h)
    if isstruct(guidata(h(i))) && h(i) ~= f
        count = count + 1;
        obj_gui(count) = h(i);     
    end
end

end
function img_obj_closereq(src,evnt)
   % User-defined close request function 
   % to display a question dialog box 
      selection = questdlg('Close This Figure?',...
         'Close Request Function',...
         'Yes','No','Yes'); 
      switch selection, 
         case 'Yes',
            delete(gcf)    
         case 'No'      
         return 
      end
   end

