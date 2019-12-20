function ha = spectrum_viewer(menu_handle)
% handle is used to set the UserData for the menu item in imb_obj_viewer
% which stores the figure_handle of spectrum_viewer.  When the UserData has
% a value then img_obj_viewer will plot data in spectrum_viewer
 fh = figure('Name','Spectrum Viewer',...
              'NumberTitle', 'off',... 
              'Color',[1 1 1],...
              'Position',[150,150,313,350],...
              'MenuBar', 'none',...              
              'Pointer','crosshair',...
              'Renderer','zbuffer',...
              'Visible','on');
set(fh,'CloseRequestFcn',@closefcn)
ha = axes('Units','Pixels','SortMethod','childorder','Position',[45,45,255,290]);

    function closefcn(hObject,eventdata)
        if ishandle(menu_handle)
            % in case the img_obj_viewer which called spectrum_viewer was
            % closed first, this condition statement still allows
            % spectrum_viewer to close without updating the img_obj_viewer.
            set(menu_handle,'UserData',[]);
            delete(fh);
        else
            delete(fh);
        end
        
    end

end