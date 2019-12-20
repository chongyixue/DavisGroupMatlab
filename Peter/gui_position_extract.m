function gui_position_extract
% SIMPLE_GUI2 Select a data set from the pop-up menu, then
% click one of the plot-type push buttons. Clicking the button
% plots the selected data in the axes.
 
   %  Create and then hide the GUI as it is being constructed.
   f = figure('Visible','off','Position',[360,500,450,285],'MenuBar', 'none');
 
   %  Construct the components.
   load_data = uimenu('Label','Load Data');

   uimenu(load_data,'Label','Open File','Callback',@open_image_Callback);
   uimenu(load_data,'Label','Load from Workspace','Callback',@load_wrkspc_Callback);  

   hsurf = uicontrol('Style','pushbutton','String','Select',...
          'Position',[315,220,70,25],...
          'Callback',{@selectbutton_Callback});
   hmesh = uicontrol('Style','pushbutton','String','Save',...
          'Position',[315,180,70,25],...
          'Callback',{@savebutton_Callback});
   hcontour = uicontrol('Style','pushbutton',...
          'String','Load data',...
          'Position',[315,135,70,25],...
          'Callback',{@loadbutton_Callback}); 
   htext = uicontrol('Style','text','String','Select Data',...
          'Position',[325,90,60,15]);
   hpopup = uicontrol('Style','popupmenu',...
          'String',{'Peaks','Membrane','Sinc'},...
          'Position',[300,50,100,25],...
          'Callback',{@popup_menu_Callback});
%    ha = axes('Units','Pixels','Position',[50,60,200,185]); 
   align([hsurf,hmesh,hcontour,htext,hpopup],'Center','None');
   
%    % Create the data to plot.
%    peaks_data = peaks(35);
%    membrane_data = membrane;
%    [x,y] = meshgrid(-8:.5:8);
%    r = sqrt(x.^2+y.^2) + eps;
%    sinc_data = sin(r)./r;
   
   % Initialize the GUI.
   % Change units to normalized so components resize 
   % automatically.
%    set([f,ha,hsurf,hmesh,hcontour,htext,hpopup],...
%    'Units','normalized');
   set([f,hsurf,hmesh,hcontour,htext,hpopup],...
   'Units','normalized');
   %Create a plot in the axes.
%    current_data = peaks_data;
%    surf(current_data);
   % Assign the GUI a name to appear in the window title.
   set(f,'Name','Extract the position on map')
   % Move the GUI to the center of the screen.
   movegui(f,'center')
   % Make the GUI visible.
   set(f,'Visible','on');
 
   %  Callbacks for simple_gui. These callbacks automatically
   %  have access to component handles and initialized data 
   %  because they are nested at a lower level.
 
   %  Pop-up menu callback. Read the pop-up menu Value property
   %  to determine which item is currently displayed and make it
   %  the current data.
      function popup_menu_Callback(source,eventdata) 
         % Determine the selected data set.
         str = get(source, 'String');
         val = get(source,'Value');
         % Set current data to the selected data set.
         switch str{val};
         case 'Peaks' % User selects Peaks.
            current_data = peaks_data;
         case 'Membrane' % User selects Membrane.
            current_data = membrane_data;
         case 'Sinc' % User selects Sinc.
            current_data = sinc_data;
         end
      end
  
   % Push button callbacks. Each callback plots current_data in
   % the specified plot type.
 
   function selectbutton_Callback(source,eventdata) 
   % Display surf plot of the currently selected data.
    h=gcf;
    dcm_obj=datacursormode(h);
    info_struct = getCursorInfo(dcm_obj);
    xpos=info_struct.Position(1,1);
    ypos=info_struct.Position(1,2);
    datacursormode off
   end
 
   function meshbutton_Callback(source,eventdata) 
   % Display mesh plot of the currently selected data.
      mesh(current_data);
   end
 
   function contourbutton_Callback(source,eventdata) 
   % Display contour plot of the currently selected data.
      contour(current_data);
   end 

    function open_image_Callback(hObject,source,eventdata)
        img_obj = read_map_v1;        
        if isempty(img_obj)
           disp('Load Failed');
           return;
        end        
        assignin('base',['obj_' img_obj.name '_' img_obj.var],img_obj);
%         img_obj_viewer2(img_obj);
        hh=img_plot3(img_obj.map(:,:,2));

        datacursormode on
    end

    function load_wrkspc_Callback(hObject,eventdata)       
        str = load_wrkspc_dialogue;
        if ~isempty(str)
            img_obj = evalin('base',str);
%             img_obj_viewer2(img_obj);
            hh=img_plot3(img_obj.map(:,:,2));
            datacursormode on
        end
    end
 
end 