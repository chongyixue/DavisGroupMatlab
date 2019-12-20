function copy_gui_data_dialogue(current_obj_handle)
fh = figure('Name','Copy Items to Data Object',...
              'NumberTitle', 'off',...                            
              'Position',[150,150,350,400],...
              'MenuBar', 'none',...
              'Resize','off');    
obj_handles = find_obj_gui(current_obj_handle);
          
for i = 1:length(obj_handles)
    data_names{i} = get(obj_handles(i),'Name');
end

current_obj = guidata(current_obj_handle);
fields_current_obj = fieldnames(current_obj);

          
copy_structs = uicontrol('Parent',fh,'units','normalized',...
                       'Style','popupmenu',...
                       'String',['Variables to Copy' data_names],...
                       'Value', 1,...
                       'Position',[0.05 0.86,0.4 0.08],...
                       'Callback',@change_obj_Callback);

copy_struct_fields = uicontrol('Parent',fh,'units','normalized',...
                      'Style','listbox',...
                      'Position',[0.05 0.15 0.4 0.7],...
                      'String','',...
                      'Min',1,'Max',1000);

current_struct = uicontrol('Parent',fh,'units','normalized',...
                       'Style','text',...
                       'String',['Copy to ' get(current_obj_handle,'Name')],...
                       'Position',[0.55 0.86,0.4 0.04]);
                  
current_struct_fields = uicontrol('Parent',fh,'units','normalized',...
                      'Style','listbox',...
                      'Position',[0.55 0.15 0.4 0.7],...
                      'String',fields_current_obj,...
                      'Min',1,'Max',1000);

copy_but = uicontrol('Parent',fh,'units','normalized',...
                   'Style','pushbutton',...
                   'String','Copy',...
                   'Position',[0.33 0.05 0.15 0.05],...
                   'Callback',@copy_Callback);
close_but = uicontrol('Parent',fh,'units','normalized',...
                   'Style','pushbutton',...
                   'String','Close',...
                   'Position',[0.52 0.05 0.15 0.05],...
                   'Callback',@close_Callback);

%%%%%%%%%%%%%%%%%%%%%%%%CALLBACK FUNCTIONS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
function copy_Callback(hObject,eventdata)
        
     struct_ind = get(copy_structs,'Value');
     struct_ind = struct_ind -1;
     s = guidata(obj_handles(struct_ind));
     s_field_names = fieldnames(s);
     struct_field_ind = get(copy_struct_fields,'Value');
     for i = 1:length(struct_field_ind)
         eval(['current_obj.' s_field_names{i} '= s.' s_field_names{i}])
     end
     guidata(current_obj_handle,current_obj);
     current_obj = guidata(current_obj_handle);
     fields_current_obj = fieldnames(current_obj);
     set(current_struct_fields,'String',fields_current_obj);
end

function close_Callback(hObject,eventdata)
    close(fh);
end

function change_obj_Callback(hObject,eventdata)
    n = get(copy_structs,'Value');
    n = n - 1;
    if n == 0
        set(copy_struct_fields,'String','');    
    else         
        s = guidata(obj_handles(n));      
        s_field_names = fieldnames(s);
        set(copy_struct_fields,'String',s_field_names);
    end
end

end
% function obj_gui = find_obj_gui(f)
% % find all open figures
% h = evalin('base','findobj(''type'',''figure'')');
% % separate out all ones which have a structure element in their guidata
% count = 0;
% obj_gui = [];
% for i = 1:length(h)
%     if isstruct(guidata(h(i))) && h(i) ~= f
%         count = count + 1;
%         obj_gui(count) = h(i);     
%     end
% end
% end