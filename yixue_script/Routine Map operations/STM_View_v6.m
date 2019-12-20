function STM_View_v6
%2018-09-22 instead of using STM view, use this to generate automatic map
%analysis stuff
%modified from STM view

%create main figure
fh=figure('Name', 'STM_View v6.0',...
        'NumberTitle', 'off',...
        'units','centimeter', ...
        'Position',[1,5,10,5],...
        'Color',[0.5 0.5 0.5],...
        'MenuBar', 'none');
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Menu Bar%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
load_data = uimenu('Label','Load Data');

uimenu(load_data,'Label','Open File','Callback',@open_image_Callback);
speedy = uimenu(load_data,'Label','Speedy Map Analysis');
    uimenu(speedy,'Label','from File','Callback',@map_anal_file_Callback);
    uimenu(speedy,'Label','from Workspace','Callback',@map_anal_workspace_Callback);
uimenu(load_data,'Label','Load from Workspace','Callback',@load_wrkspc_Callback);   
uimenu(load_data,'Label','TBD')


cpy_data = uimenu('Label','Copy Data','Callback',@copy_Callback);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function open_image_Callback(hObject,source,eventdata)
        %img_obj = read_map_v5;
        read_map_include_nanonis;
%         if isempty(img_obj)
%            disp('Load Failed');
%            return;
%         end    
%         if img_obj~='nanonis'
%             assignin('base',['obj_' img_obj.name '_' img_obj.var],img_obj); % exports the data to the workspace
%             img_obj_viewer_test(img_obj);
%         end
    end

    function map_anal_file_Callback(hObject,source,eventdata)
        map = read_map_v7(1);
        if isempty(map)
            disp('Load Failed');
            return;
        end
        assignin('base',['obj_' map.name '_' map.var],map); % exports the data to the workspace
%         img_obj_viewer_test(map);
        
        [topo,pathname] = read_map_v7(2);
        if isempty(topo)
            disp('Load Failed');
            return;
        end
        assignin('base',['obj_' topo.name '_' topo.var],topo); % exports the data to the workspace
%         img_obj_viewer_test(topo);
        
        if map.e(1)>map.e(2) 
            map = invert_map(map);
        end
        newmap_automate(map,topo,pathname)

    end

    function map_anal_workspace_Callback(hObject,eventdata)       
        str = load_wrkspc_dialogue('Select Map');
        if ~isempty(str)
            map = evalin('base',str);
            %img_obj_viewer_test(map);    
        end
        
        str = load_wrkspc_dialogue('Select Topo');
        if ~isempty(str)
            topo = evalin('base',str);
            %img_obj_viewer_test(topo);    
        end
        pathname = 'C:\Users\chong\Documents\MATLAB\STMdata\BST 2019\';
        newmap_automate(map,topo,pathname)
        
    end


    function load_wrkspc_Callback(hObject,eventdata)       
        str = load_wrkspc_dialogue;
        if ~isempty(str)
            img_obj = evalin('base',str);
            img_obj_viewer_test(img_obj);
            % img_obj_viewer2(img_obj);
        end
    end
    function copy_Callback(hObject,eventdata)
        copy_data_dialogue;
    end
end