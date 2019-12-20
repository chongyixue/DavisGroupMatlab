function new_data = rotate_map2(data,angle)
new_map = imrotate(data.map,angle,'bicubic','crop');
new_data = data;
new_data.map = new_map;
end