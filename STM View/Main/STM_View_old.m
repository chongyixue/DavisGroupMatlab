function STM_View
%create main figure
fh=figure('Name', 'STM_View V 1.0',...
        'NumberTitle', 'off',...
        'units','centimeter', ...
        'Position',[1,5,10,5],...
        'Color',[0.5 0.5 0.5],...
        'MenuBar', 'none');
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Menu Bar%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
load_data = uimenu('Label','Load Data');

uimenu(load_data,'Label','Open File','Callback',@open_image_Callback);
uimenu(load_data,'Label','Load from Workspace','Callback',@load_wrkspc_Callback);   
uimenu(load_data,'Label','TBD')

cpy_data = uimenu('Label','Copy Data','Callback',@copy_Callback);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function open_image_Callback(hObject,source,eventdata)
        img_obj = read_map_v1;        
        if isempty(img_obj)
           disp('Load Failed');
           return;
        end        
        assignin('base',['obj_' img_obj.name '_' img_obj.var],img_obj);
        img_obj_viewer2(img_obj);
        
    end

    function load_wrkspc_Callback(hObject,eventdata)       
        str = load_wrkspc_dialogue;
        if ~isempty(str)
            img_obj = evalin('base',str);
            img_obj_viewer2(img_obj);
        end
    end
    function copy_Callback(hObject,eventdata)
        copy_data_dialogue;
    end
end