function obj_wrkspc = find_obj_wrkspc
obj_wrkspc = [];
data_names = evalin('base','who');         
count = 0;
for i = 1:length(data_names)
    if evalin('base',['isstruct(' data_names{i} ') && isfield(' data_names{i} ',''map'')' ])
        count = count + 1;
        obj_wrkspc{count} = data_names{i};
    end
end
end