function [a, b] = data_histogram_dialogue_wo(layer,histo,fig_handle,axis_handle)
%store the original value of the caxis from the figure - will be used for
%undo
caxis_revert = get(fig_handle,'UserData');

c_min_revert = caxis_revert(layer,1);
c_max_revert = caxis_revert(layer,2);

fh=figure('Name', ['Histogram of layer ' num2str(layer)],...
        'units','normalized', ...
        'Position',[0.3,0.3,0.45,0.55],...
        'Color',[0.6 0.6 0.6],...
        'MenuBar', 'none',...
        'NumberTitle', 'off',...
        'Resize','off');
  
 axis off;
%%%%%%%%%%%%%%%%%%%%%%%%%%%GUI Controls%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
mini_edit = uicontrol(fh,'Style','Edit',...
                'String',num2str(caxis_revert(layer,1)),...
                'units','centimeter',...
                'Position',[1 1 2 1]);
            
maxi_edit = uicontrol(fh,'Style','Edit',...
                'String',num2str(caxis_revert(layer,2)),...
                'units','centimeter',...
                'Position',[3.5 1 2 1]);
            
min_label = uicontrol(fh,'Style','text',...
                        'String','Minimum',...
                        'units','centimeter',...
                        'Position',[1 0.4 2 0.4]);

max_label = uicontrol(fh,'Style','text',...
                         'String','Maximum',...
                         'units','centimeter',...
                         'Position',[3.5 0.4 2 0.4]);
                     
hist_axis = axes('Parent',fh,...
                 'units','normalized',...
                 'Position',[0.11 0.3 0.65 0.6]);             
                  set(get(hist_axis,'XLabel'),'String','Image Values');
                  set(get(hist_axis,'YLabel'),'String','% Occurrence');
                 
zoom_but = uicontrol(fh,'Style','pushbutton',...
                          'String','Zoom Selection',...
                          'units','centimeter',...
                          'Position',[6 1 2.5 1],...
                          'Callback',(@zoom_Callback));
                        
revert_but = uicontrol(fh,'Style','pushbutton',...
                          'String','Revert',...
                          'units','centimeter',...
                          'Position',[9 1 2.5 1],...
                          'Callback',@revert_Callback);
                      
apply_but = uicontrol(fh,'Style','pushbutton',...
                          'String','Apply',...
                          'units','centimeter',...
                          'Position',[12 1 2.5 1],...
                          'Callback',(@apply_Callback));
done_but = uicontrol(fh,'Style','pushbutton',...
                          'String','DONE',...
                          'units','centimeter',...
                          'Position',[12 5 2.5 1],...
                          'Callback',(@done_Callback));

clim_choice = uibuttongroup('Position',[0.79 0.55 .165 0.15],...
                            'Title','Threshold By: ',...
                            'TitlePosition','centertop',...
                            'BorderType','line');
            set(clim_choice,'UserData',1);      
set(clim_choice,'SelectionChangeFcn',@sel_Callback);
u0 = uicontrol('Style','Radio','String','Relative',...
    'pos',[15 25 65 30],'parent',clim_choice,'HandleVisibility','off');
u1 = uicontrol('Style','Radio','String','Absolute',...
    'pos',[15 0 65 30],'parent',clim_choice,'HandleVisibility','off');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%MAIN%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n = histo.freq(layer,:); x = histo.val(layer,:);
bar(x,n./sum(n),1,'r'); grid on;
xlim([c_min_revert c_max_revert]);
set(get(hist_axis,'XLabel'),'String','Value');
set(get(hist_axis,'YLabel'),'String','% Occurrence');
            
%%%%%%%%%%%%%%%%%%%%%%%%%Callback Functions%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function revert_Callback(hObject,evendata)
        set(hist_axis,'XLim',[c_min_revert c_max_revert]);
        set(mini_edit,'String',num2str(c_min_revert));
        set(maxi_edit,'String',num2str(c_max_revert));
        set(axis_handle,'CLim',[c_min_revert c_max_revert]);
        set(fig_handle,'UserData',caxis_revert);
    end

    function zoom_Callback(hObject,evendata)
        a = str2double(get(mini_edit,'String'));
        b = str2double(get(maxi_edit,'String'));
        set(hist_axis,'XLim',[a b]);
    end

    function apply_Callback(hObject,evendata)
        a = str2double(get(mini_edit,'String'));
        b = str2double(get(maxi_edit,'String'));
        if a >= b
            display('Min value must be less than Max value');
            return;
        end
%         %% COMMENTED OUT BY PETER 11/22/2015
%         %if user defined min and max values are beyond the range of the img
%         %values just replace them by the minimum and maximum values    
%         if a < min(x)
%             a = min(x);
%         end
%         if b > max(x)
%             b = max(x);
%         end
        %%
        %if threshold is absolute then all layers have the same min and max
        %values for the colormap 
        if get(clim_choice,'UserData') == 2
            set(axis_handle,'CLim',[a b]);
            c(1:histo.size(3),1) = a;
            c(1:histo.size(3),2) = b;
        % if threshold is relative then a and b are used to calculate what 
        %percentage of point lie below a and above b.  The same percentages
        %are then used for each layer
        else
            set(axis_handle,'CLim',[a b]);             
            n_sum = cumsum(n)/(histo.size(1)*histo.size(2));
         
            low_lim = find(x <= a);
            if ~isempty(low_lim)
                low_lim = low_lim(end);
            else
                low_lim = 1;
            end
            high_lim = find(x >= b);
            if ~isempty(high_lim)
                high_lim = high_lim(1);
            else
                high_lim = length(n);
            end
            
            lower_per = n_sum(low_lim); high_per = 1-n_sum(high_lim);
            for i = 1:histo.size(3)
                [c(i,1) c(i,2)] = ...
                   colormap_limits(histo.val(i,:),histo.freq(i,:),histo.size(1),histo.size(2),lower_per,high_per);
            end            
        end
            set(fig_handle,'UserData',c);
    end

    function sel_Callback(hObject,eventdata)
        choice = get(eventdata.NewValue,'String');
        if strcmp(choice, 'Absolute')
            set(clim_choice,'UserData',2);           
        else
            set(clim_choice,'UserData',1);
        end
    end
    function done_Callback(hObject,eventdata)
        close(fh)
    end
keyboard
        
end