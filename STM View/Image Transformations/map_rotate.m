function new_data = map_rotate(data,angle)
% angle in degrees

if isstruct(data)
    img = data.map;
    new_data = data;
    new_data.map = imrotate(img,angle,'crop');    
    new_data.var = [new_data.var '_rotate_' num2str(angle)];
    new_data.ops{end+1} = ['rotate map by ' num2str(angle) 'degrees'];
    img_obj_viewer2(new_data);        
else
    img = data;
    new_data = imrotate(img,angle,'bicubic','crop');
end

end