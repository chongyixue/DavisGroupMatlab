%2018-9-24 YXC
% get handle number given name of figure

function handletag = get_handle_tag(name)
obj_handles = find_obj_gui;
handletag = 0;
for j = 1:length(obj_handles)
    name2 = get(obj_handles(j),'Name');
    if strcmp(name2,name)==1
        handletag = obj_handles(j);
    end
end
